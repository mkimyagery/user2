*&---------------------------------------------------------------------*
*& Report ZCM_TEST_246
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_246.

DATA: gv_text  TYPE string VALUE 'Field sembol kullanimi örnek rapor',
      gs_scarr TYPE scarr,
      gt_spfli TYPE TABLE OF spfli.

FIELD-SYMBOLS: <fs_general> TYPE ANY,
               <fs_field>   TYPE ANY,
               <fs_str>     TYPE ANY,
               <fs_table>   TYPE ANY TABLE.

START-OF-SELECTION.

  ASSIGN gv_text TO <fs_general>.

  WRITE: <fs_general>.
  SKIP.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  SELECT SINGLE * FROM scarr
    INTO gs_scarr
    WHERE carrid = 'JL'.

  ASSIGN gs_scarr TO <fs_general>.

  ASSIGN COMPONENT 'CARRID' OF STRUCTURE <fs_general> TO <fs_field>.
  WRITE: / <fs_field>.

  ASSIGN COMPONENT 'CARRNAME' OF STRUCTURE <fs_general> TO <fs_field>.
  WRITE: / <fs_field>.
  SKIP.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  SELECT * FROM spfli INTO TABLE gt_spfli.

  ASSIGN gt_spfli TO <fs_table>.

  LOOP AT <fs_table> ASSIGNING <fs_str>.

    ASSIGN COMPONENT 'AIRPFROM' OF STRUCTURE <fs_str> to <fs_field>.
    WRITE: / <fs_field>.

  ENDLOOP.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
























*PARAMETERS: p_tbl_1 RADIOBUTTON GROUP abc,
*            p_tbl_2 RADIOBUTTON GROUP abc.
*
*FIELD-SYMBOLS: <gt_tablo> TYPE any TABLE.
*
*DATA: gt_tablo_1 TYPE TABLE OF zcm_tablo_1,
*      gt_tablo_2 TYPE TABLE OF zcm_tablo_2.
*
*START-OF-SELECTION.
*
*  IF p_tbl_1 = abap_true.
*
*    ASSIGN gt_tablo_1 TO <gt_tablo>.
*
*    SELECT * FROM zcm_tablo_1 INTO TABLE <gt_tablo>.
*  ENDIF.
