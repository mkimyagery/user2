*&---------------------------------------------------------------------*
*& Report ZCM_TEST_AF_TEST_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_af_test.

DATA: gs_data     TYPE zcm_s_adobeform_fdm,
      gs_outparam TYPE sfpoutputparams,
      gv_funcname TYPE funcname.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS: p_carrid TYPE s_carr_id.
SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  SELECT SINGLE * FROM scarr INTO gs_data-scarr WHERE carrid    = p_carrid.
  SELECT * FROM spfli   INTO TABLE gs_data-spfli WHERE carrid   = p_carrid.
  SELECT * FROM sflight INTO TABLE gs_data-sflight WHERE carrid = p_carrid.

  CALL FUNCTION 'FP_JOB_OPEN'
    CHANGING
      ie_outputparams = gs_outparam.

  CALL FUNCTION 'FP_FUNCTION_MODULE_NAME'
    EXPORTING
      i_name     = 'ZCM_ADOBE_FORM_FDM'
    IMPORTING
      e_funcname = gv_funcname.

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
