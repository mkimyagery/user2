*&---------------------------------------------------------------------*
*& Report ZCM_TEST_350
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_351.

DATA : gs_data        TYPE zcm_s_adobeform_fdm2,
       gs_outparams   TYPE sfpoutputparams,
       gv_funcname    TYPE funcname,
       gs_pdf         TYPE fpformoutput,
       gt_data_binary TYPE TABLE OF sdokcntbin,
       gv_filename    TYPE string,
       gv_path        TYPE string,
       gv_fullpath    TYPE string.
.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS : p_carrid TYPE s_carr_id.
SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  SELECT SINGLE * FROM scarr   INTO gs_data-scarr         WHERE carrid = p_carrid.
  SELECT *        FROM spfli   INTO TABLE gs_data-spfli   WHERE carrid = p_carrid.
  SELECT *        FROM sflight INTO TABLE gs_data-sflihgt WHERE carrid = p_carrid.

  "LP01 penceresinden kurtul.
  gs_outparams-getpdf = abap_true.


  "PDF i oluşturmak için Job aç!
  CALL FUNCTION 'FP_JOB_OPEN'
    CHANGING
      ie_outputparams = gs_outparams
    EXCEPTIONS
      cancel          = 1
      usage_error     = 2
      system_error    = 3
      internal_error  = 4
      OTHERS          = 5.

  CALL FUNCTION 'FP_FUNCTION_MODULE_NAME'
    EXPORTING
      i_name     = 'ZCM_ADOBE_FORM_FDM'
    IMPORTING
      e_funcname = gv_funcname.

  "2.derste üstünden geçilecek diyorum
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

  CALL FUNCTION 'FP_JOB_CLOSE'
    EXCEPTIONS
      usage_error    = 1
      system_error   = 2
      internal_error = 3
      OTHERS         = 4.

  CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
    EXPORTING
      buffer     = gs_pdf-pdf
    TABLES
      binary_tab = gt_data_binary.

  cl_gui_frontend_services=>file_save_dialog(
    EXPORTING
      window_title              = 'Dosyayi kaydetmek istediginiz yeri seciniz.'
    CHANGING
      filename                  = gv_filename
      path                      = gv_path
      fullpath                  = gv_fullpath
    EXCEPTIONS
      cntl_error                = 1
      error_no_gui              = 2
      not_supported_by_gui      = 3
      invalid_default_file_name = 4
      OTHERS                    = 5 ).

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

  cl_gui_frontend_services=>gui_download(
    EXPORTING
      filename                  = gv_filename
      filetype                  = 'BIN'
    CHANGING
      data_tab                  = gt_data_binary
    EXCEPTIONS
      file_write_error          = 1
      no_batch                  = 2
      gui_refuse_filetransfer   = 3
      invalid_type              = 4
      no_authority              = 5
      unknown_error             = 6
      header_not_allowed        = 7
      separator_not_allowed     = 8
      filesize_not_allowed      = 9
      header_too_long           = 10
      dp_error_create           = 11
      dp_error_send             = 12
      dp_error_write            = 13
      unknown_dp_error          = 14
      access_denied             = 15
      dp_out_of_memory          = 16
      disk_full                 = 17
      dp_timeout                = 18
      file_not_found            = 19
      dataprovider_exception    = 20
      control_flush_error       = 21
      not_supported_by_gui      = 22
      error_no_gui              = 23
      others                    = 24 ).

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.
