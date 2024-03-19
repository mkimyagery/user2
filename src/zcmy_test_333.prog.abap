*&---------------------------------------------------------------------*
*& Report ZCM_TEST_333
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_333.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_file   TYPE rlgrap-filename OBLIGATORY,
              p_table  TYPE tabname OBLIGATORY,
              p_header AS CHECKBOX,
              p_mandt  AS CHECKBOX.

SELECTION-SCREEN END OF BLOCK a1.

TYPES: BEGIN OF gty_table,
         row TYPE n LENGTH 4,
       END OF gty_table.

DATA: gv_file_type TYPE sdbad-funct,
      gv_file_name TYPE dbmsgora-filename,
      gt_tablo     TYPE TABLE OF alsmex_tabline,
      gt_row       TYPE TABLE OF gty_table,
      gr_data      TYPE REF TO data.

FIELD-SYMBOLS: <fs_table> TYPE STANDARD TABLE.

"Kullanicidan dosya adi ve dosya yolu al.

AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_file.

  CALL FUNCTION 'F4_FILENAME'
    IMPORTING
      file_name = p_file.

START-OF-SELECTION.

  "Girilen dosyanin uzantisini bul.
  gv_file_name = p_file.

  CALL FUNCTION 'SPLIT_FILENAME'
    EXPORTING
      long_filename  = gv_file_name
    IMPORTING
      pure_extension = gv_file_type.

  TRANSLATE gv_file_type TO UPPER CASE.

  "XLS ya da XLSX olup olmadigini kontrol et.
  CHECK gv_file_type = 'XLS' OR gv_file_type = 'XLSX'.

  "Excelden veriyi oku.
  CALL FUNCTION 'ALSM_EXCEL_TO_INTERNAL_TABLE'
    EXPORTING
      filename                = p_file
      i_begin_col             = 1
      i_begin_row             = 1
      i_end_col               = COND #( WHEN gv_file_type = 'XLS'  THEN 256
                                        WHEN gv_file_type = 'XLSX' THEN 16834 )
      i_end_row               = COND #( WHEN gv_file_type = 'XLS'  THEN 65536
                                        WHEN gv_file_type = 'XLSX' THEN 1048576 )
    TABLES
      intern                  = gt_tablo
    EXCEPTIONS
      inconsistent_parameters = 1
      upload_ole              = 2
      OTHERS                  = 3.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

  "Excel dosyasinda kolon basliklari varsa bu hücreleri sil.
  IF p_header = abap_true.
    DELETE gt_tablo WHERE row = 1.

    LOOP AT gt_tablo ASSIGNING FIELD-SYMBOL(<gs_str>).
      <gs_str>-row = <gs_str>-row - 1.
    ENDLOOP.
  ENDIF.

  "Excel dosyasinda mandt yoksa manuel olarak ekle.
  IF p_mandt IS INITIAL.
    LOOP AT gt_tablo ASSIGNING <gs_str>.
      <gs_str>-col = <gs_str>-col + 1.
    ENDLOOP.

    gt_row = VALUE #( FOR gs_line IN gt_tablo ( row = gs_line-row ) ).
    SORT gt_row.
    DELETE ADJACENT DUPLICATES FROM gt_row.

    LOOP AT gt_row INTO DATA(gs_row).
      APPEND INITIAL LINE TO gt_tablo ASSIGNING <gs_str>.
      <gs_str>-row   = gs_row-row.
      <gs_str>-col   = '0001'.
      <gs_str>-value = sy-mandt.
    ENDLOOP.

    SORT gt_tablo BY row col.

  ENDIF.

  "Gelen tablo (veya structure) ismine göre Data referansini olustur.
  CREATE DATA gr_data TYPE STANDARD TABLE OF (p_table).

  "Referans icindeki internal tabloyu kullanilabilir hale getirebilmek icin FS'e ata.
  ASSIGN gr_data->* TO <fs_table>.

*  LOOP AT gt_tablo INTO DATA(gs_tablo) GROUP BY ( row = gs_tablo-row )
*                                       INTO DATA(gt_group).
*
*    APPEND INITIAL LINE TO <fs_table> ASSIGNING FIELD-SYMBOL(<fs_str>).
*
*    LOOP AT GROUP gt_group INTO DATA(gs_group).
*      ASSIGN COMPONENT gs_group-col OF STRUCTURE <fs_str> to FIELD-SYMBOL(<fs_hucre>).
*      IF sy-subrc IS INITIAL.
*        <fs_hucre> = gs_group-value.
*      ENDIF.
*    ENDLOOP.
*
*  ENDLOOP.


  IF gt_row IS INITIAL.
    gt_row = VALUE #( FOR gs_line IN gt_tablo ( row = gs_line-row ) ).
    SORT gt_row.
    DELETE ADJACENT DUPLICATES FROM gt_row.
  ENDIF.

  LOOP AT gt_row INTO gs_row.

    APPEND INITIAL LINE TO <fs_table> ASSIGNING FIELD-SYMBOL(<fs_str>).

    LOOP AT gt_tablo INTO DATA(gs_tablo) WHERE row = gs_row-row.

      ASSIGN COMPONENT gs_tablo-col OF STRUCTURE <fs_str> TO FIELD-SYMBOL(<fs_hucre>).

      IF sy-subrc IS INITIAL.
        <fs_hucre> = gs_tablo-value.
      ENDIF.

    ENDLOOP.

    CLEAR: gs_row.

  ENDLOOP.


  INSERT zcm_iller FROM TABLE <fs_table>.

  BREAK-POINT.
