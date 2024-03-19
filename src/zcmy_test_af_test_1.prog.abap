*&---------------------------------------------------------------------*
*& Report ZCM_TEST_AF_TEST_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_af_test_1.

DATA: gs_data     TYPE zcm_s_adobeform_test,
      gs_outparam TYPE sfpoutputparams,
      gv_funcname TYPE funcname,
      gt_fcat     TYPE lvc_t_fcat.

START-OF-SELECTION.

  SELECT SINGLE * FROM scarr INTO gs_data-scarr_str WHERE carrid = 'AA'.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SCARR'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

  gs_data-scarr_kolon_basliklari-kolon_carrid   = gt_fcat[ fieldname = 'CARRID'   ]-scrtext_m.
  gs_data-scarr_kolon_basliklari-kolon_carrname = gt_fcat[ fieldname = 'CARRNAME' ]-scrtext_m.
  gs_data-scarr_kolon_basliklari-kolon_currcode = gt_fcat[ fieldname = 'CURRCODE' ]-scrtext_m.
  gs_data-scarr_kolon_basliklari-kolon_url      = gt_fcat[ fieldname = 'URL'      ]-scrtext_m.

  CLEAR: gt_fcat.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SPFLI'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

  gs_data-spfli_kolon_basliklari-kolon_carrid    = gt_fcat[ fieldname = 'CARRID'   ]-scrtext_m.
  gs_data-spfli_kolon_basliklari-kolon_connid    = gt_fcat[ fieldname = 'CONNID'   ]-scrtext_m.
  gs_data-spfli_kolon_basliklari-kolon_countryfr = gt_fcat[ fieldname = 'COUNTRYFR' ]-scrtext_m.
  gs_data-spfli_kolon_basliklari-kolon_cityfrom  = gt_fcat[ fieldname = 'CITYFROM'  ]-scrtext_m.
  gs_data-spfli_kolon_basliklari-kolon_airpfrom  = gt_fcat[ fieldname = 'AIRPFROM'  ]-scrtext_m.
  gs_data-spfli_kolon_basliklari-kolon_countryto = gt_fcat[ fieldname = 'COUNTRYTO' ]-scrtext_m.
  gs_data-spfli_kolon_basliklari-kolon_cityto    = gt_fcat[ fieldname = 'CITYTO'    ]-scrtext_m.
  gs_data-spfli_kolon_basliklari-kolon_airpto    = gt_fcat[ fieldname = 'AIRPTO'    ]-scrtext_m.
  gs_data-spfli_kolon_basliklari-kolon_fltime    = gt_fcat[ fieldname = 'FLTIME'    ]-scrtext_m.
  gs_data-spfli_kolon_basliklari-kolon_deptime   = gt_fcat[ fieldname = 'DEPTIME'   ]-scrtext_m.
  gs_data-spfli_kolon_basliklari-kolon_arrtime   = gt_fcat[ fieldname = 'ARRTIME'   ]-scrtext_m.
  gs_data-spfli_kolon_basliklari-kolon_distance  = gt_fcat[ fieldname = 'DISTANCE'  ]-scrtext_m.
  gs_data-spfli_kolon_basliklari-kolon_distid    = gt_fcat[ fieldname = 'DISTID'    ]-scrtext_m.
  gs_data-spfli_kolon_basliklari-kolon_fltype    = gt_fcat[ fieldname = 'FLTYPE'    ]-scrtext_m.
  gs_data-spfli_kolon_basliklari-kolon_period    = gt_fcat[ fieldname = 'PERIOD'    ]-scrtext_m.

  SELECT * FROM spfli INTO TABLE gs_data-spfli_table WHERE carrid = 'AA'.
  SELECT * FROM sflight INTO TABLE gs_data-sflight_table WHERE carrid = 'AA'.

  CALL FUNCTION 'FP_JOB_OPEN'
    CHANGING
      ie_outputparams = gs_outparam.

  CALL FUNCTION 'FP_FUNCTION_MODULE_NAME'
    EXPORTING
      i_name     = 'ZCM_FDM_AF_TEST_3'
    IMPORTING
      e_funcname = gv_funcname.
  CALL FUNCTION '/1BCDWB/SM00000044'
    EXPORTING
      is_input_str   = gs_data
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
