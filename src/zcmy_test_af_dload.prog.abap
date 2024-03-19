*&---------------------------------------------------------------------*
*& Report ZCM_TEST_AF_TEST_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_af_dload.

DATA: gs_data     TYPE zcm_s_adobeform_fdm,
      gs_outparam TYPE sfpoutputparams,
      gv_funcname TYPE funcname,
      gs_pdf      TYPE  fpformoutput,
      gv_filename TYPE string,
      gv_path     TYPE string,
      gv_fullpath TYPE string,
      gt_data_tab TYPE STANDARD TABLE OF x255.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS: p_carrid TYPE s_carr_id.
SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  "Databaseden veriyi oku ve gerekli yerlere kaydet.
  SELECT SINGLE * FROM scarr   INTO       gs_data-scarr   WHERE carrid = p_carrid.
  SELECT *        FROM spfli   INTO TABLE gs_data-spfli   WHERE carrid = p_carrid.
  SELECT *        FROM sflight INTO TABLE gs_data-sflight WHERE carrid = p_carrid.

  "PDF'in acilmamasini ancak veri haline saklanmasi sagla.
  gs_outparam-getpdf   = abap_true.

  "PDF olusturmak icin JOB ac.
  CALL FUNCTION 'FP_JOB_OPEN'
    CHANGING
      ie_outputparams = gs_outparam
    EXCEPTIONS
      cancel          = 1
      usage_error     = 2
      system_error    = 3
      internal_error  = 4
      OTHERS          = 5.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

  "Adobe Formun fonksiyon ismini al.
  CALL FUNCTION 'FP_FUNCTION_MODULE_NAME'
    EXPORTING
      i_name     = 'ZCM_ADOBE_FORM_FDM'
    IMPORTING
      e_funcname = gv_funcname.

  "Adobe Formun fonksiyonunu cagir ve PDF'i veri olarak al.
  CALL FUNCTION gv_funcname
    EXPORTING
      is_input           = gs_data
    IMPORTING
      /1bcdwb/formoutput = gs_pdf
    EXCEPTIONS
      usage_error        = 1
      system_error       = 2
      internal_error     = 3
      OTHERS             = 4.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

  "PDF olusturma islemi tamamlandi. JOB kapat.
  CALL FUNCTION 'FP_JOB_CLOSE'
    EXCEPTIONS
      usage_error    = 1
      system_error   = 2
      internal_error = 3
      OTHERS         = 4.

  "Gelen PDF dosyasini BINARY formatina cevir.
  "Binary formati tamamen sayilardan olusan bir veri tipidir.
  CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
    EXPORTING
      buffer     = gs_pdf-pdf
    TABLES
      binary_tab = gt_data_tab.

  "kullaniciya nereye ve hangi isimle kaydetmek istedigini sor.
  cl_gui_frontend_services=>file_save_dialog(
    EXPORTING
      window_title              = 'Dosyayi nereye kaydetmek istersiniz?'
    CHANGING
      filename                  = gv_filename
      path                      = gv_path     "Kullanilmasa dahi acilmasi gerekiyor.
      fullpath                  = gv_fullpath "Kullanilmasa dahi acilmasi gerekiyor.
    EXCEPTIONS
      cntl_error                = 1
      error_no_gui              = 2
      not_supported_by_gui      = 3
      invalid_default_file_name = 4
      OTHERS                    = 5 ).

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

  "Kaydet.
  CALL METHOD cl_gui_frontend_services=>gui_download
    EXPORTING
      filename                = gv_filename
      filetype                = 'BIN'
    CHANGING
      data_tab                = gt_data_tab
    EXCEPTIONS
      file_write_error        = 1
      no_batch                = 2
      gui_refuse_filetransfer = 3
      invalid_type            = 4
      no_authority            = 5
      unknown_error           = 6
      header_not_allowed      = 7
      separator_not_allowed   = 8
      filesize_not_allowed    = 9
      header_too_long         = 10
      dp_error_create         = 11
      dp_error_send           = 12
      dp_error_write          = 13
      unknown_dp_error        = 14
      access_denied           = 15
      dp_out_of_memory        = 16
      disk_full               = 17
      dp_timeout              = 18
      file_not_found          = 19
      dataprovider_exception  = 20
      control_flush_error     = 21
      not_supported_by_gui    = 22
      error_no_gui            = 23
      OTHERS                  = 24.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.
