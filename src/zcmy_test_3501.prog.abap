*&---------------------------------------------------------------------*
*& Report ZCM_TEST_350
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_3501.

DATA : gs_data      TYPE zcm_s_adobeform_fdm2,
       gs_outparams TYPE sfpoutputparams,
       gv_funcname  TYPE funcname.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS : p_carrid TYPE s_carr_id.
SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  SELECT SINGLE * FROM scarr   INTO gs_data-scarr         WHERE carrid = p_carrid.
  SELECT *        FROM spfli   INTO TABLE gs_data-spfli   WHERE carrid = p_carrid.
  SELECT *        FROM sflight INTO TABLE gs_data-sflihgt WHERE carrid = p_carrid.

  "LP01 penceresinden kurtul.
  gs_outparams-dest     = 'LP01'.
  gs_outparams-nodialog = abap_true.
  gs_outparams-preview  = abap_true.

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
      is_input       = gs_data
    EXCEPTIONS
      usage_error    = 1
      system_error   = 2
      internal_error = 3
      OTHERS         = 4.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

  CALL FUNCTION 'FP_JOB_CLOSE'
    EXCEPTIONS
      usage_error    = 1
      system_error   = 2
      internal_error = 3
      OTHERS         = 4.
