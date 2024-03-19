*&---------------------------------------------------------------------*
*& Report ZCM_TEST_AF_TEST_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_af_overview.

DATA: gs_data     TYPE zcm_s_adobeform_fdm,
      gs_outparam TYPE sfpoutputparams,
      gv_funcname TYPE funcname.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS: p_carrid TYPE s_carr_id.
SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  "Databaseden veriyi oku ve gerekli yerlere kaydet.
  SELECT SINGLE * FROM scarr   INTO       gs_data-scarr   WHERE carrid = p_carrid.
  SELECT *        FROM spfli   INTO TABLE gs_data-spfli   WHERE carrid = p_carrid.
  SELECT *        FROM sflight INTO TABLE gs_data-sflight WHERE carrid = p_carrid.

  "PDF'in otomatik acilmasi icin alttaki degerleri gir.
  gs_outparam-dest     = 'LP01'.
  gs_outparam-nodialog = abap_true.
  gs_outparam-preview  = abap_true.

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

  "Adobe Formun fonksiyonunu cagir.
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

  "PDF olusturma islemi tamamlandi. JOB kapat.
  CALL FUNCTION 'FP_JOB_CLOSE'
    EXCEPTIONS
      usage_error    = 1
      system_error   = 2
      internal_error = 3
      OTHERS         = 4.
