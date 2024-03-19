*&---------------------------------------------------------------------*
*& Report ZCM_TEST_257
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_257.


PARAMETERS: p_agnum TYPE s_agncynum OBLIGATORY,
            p_name  TYPE string LOWER CASE.

DATA: gs_stravelag TYPE zcm_stravelag,
      gv_number    TYPE i.

DATA: gs_bal_log    TYPE bal_s_msg,
      gs_log_info   TYPE bal_s_log,
      gv_log_handle TYPE balloghndl,
      gv_timestamp  TYPE tzntstmps.

CONSTANTS: gc_obj TYPE balobj_d VALUE 'ZCM_OBJ_1',
           gc_sub TYPE balsubobj VALUE 'ZCM_SUB_1'.

START-OF-SELECTION.

  PERFORM prep_log.
  PERFORM start.
  PERFORM check_id.
  PERFORM check_name.
  PERFORM update.

FORM prep_log .

  CONVERT DATE sy-datum TIME sy-uzeit
  INTO TIME STAMP gv_timestamp
  TIME ZONE sy-zonlo.

  gs_log_info-object    = gc_obj.
  gs_log_info-subobject = gc_sub.
  gs_log_info-extnumber = gv_timestamp.
  CONDENSE gs_log_info-extnumber.

  CALL FUNCTION 'ADD_TIME_TO_DATE'
    EXPORTING
      i_idate               = sy-datum
      i_time                = 2
      i_iprkz               = '1'
    IMPORTING
      o_idate               = gs_log_info-aldate_del
    EXCEPTIONS
      invalid_period        = 1
      invalid_round_up_rule = 2
      internal_error        = 3
      OTHERS                = 4.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

  CALL FUNCTION 'BAL_LOG_CREATE'
    EXPORTING
      i_s_log                 = gs_log_info
    IMPORTING
      e_log_handle            = gv_log_handle
    EXCEPTIONS
      log_header_inconsistent = 1
      OTHERS                  = 2.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

ENDFORM.


FORM start.

  gs_bal_log-msgty = 'S'.
  gs_bal_log-msgid = 'ZCM_MSG_CLASS_1'.
  gs_bal_log-msgno = 12.
  gs_bal_log-msgv1 = sy-datum.
  gs_bal_log-msgv2 = sy-uzeit.
  gs_bal_log-msgv3 = sy-uname.

  PERFORM add_log.

  gs_bal_log-msgty = 'S'.
  gs_bal_log-msgid = 'ZCM_MSG_CLASS_2'.
  gs_bal_log-msgno = 13.
  gs_bal_log-msgv1 = p_agnum.
  gs_bal_log-msgv2 = p_name.

  PERFORM add_log.
ENDFORM.

FORM check_id.
  SELECT SINGLE * FROM zcm_stravelag
    INTO gs_stravelag
    WHERE agencynum = p_agnum.

  IF gs_stravelag IS INITIAL.

    gs_bal_log-msgty = 'W'.
    gs_bal_log-msgid = 'ZCM_MSG_CLASS_2'.
    gs_bal_log-msgno = 14.
    gs_bal_log-msgv1 = p_agnum.

    PERFORM add_log.
    PERFORM save_log.
    LEAVE PROGRAM.
  ELSE.

    gs_bal_log-msgty = 'S'.
    gs_bal_log-msgid = 'ZCM_MSG_CLASS_2'.
    gs_bal_log-msgno = 15.
    gs_bal_log-msgv1 = p_agnum.

    PERFORM add_log.

  ENDIF.

ENDFORM.

FORM check_name .
  IF p_name IS INITIAL.
    gs_bal_log-msgty = 'W'.
    gs_bal_log-msgid = 'ZCM_MSG_CLASS_2'.
    gs_bal_log-msgno = 16.

    PERFORM add_log.
    PERFORM save_log.
    LEAVE PROGRAM.
  ELSE.
    gs_bal_log-msgty = 'S'.
    gs_bal_log-msgid = 'ZCM_MSG_CLASS_2'.
    gs_bal_log-msgno = 17.
    gs_bal_log-msgv1 = p_name.

    PERFORM add_log.
  ENDIF.

  gv_number = strlen( p_name ).

  IF gv_number > 25.
    gs_bal_log-msgty = 'W'.
    gs_bal_log-msgid = 'ZCM_MSG_CLASS_2'.
    gs_bal_log-msgno = 18.
    gs_bal_log-msgv1 = p_name.

    PERFORM add_log.
    PERFORM save_log.
    LEAVE PROGRAM.
  ELSE.
    gs_bal_log-msgty = 'S'.
    gs_bal_log-msgid = 'ZCM_MSG_CLASS_2'.
    gs_bal_log-msgno = 19.
    gs_bal_log-msgv1 = p_name.

    PERFORM add_log.
  ENDIF.
ENDFORM.

FORM update .
  UPDATE zcm_stravelag SET name = p_name
                       WHERE agencynum = p_agnum.

  IF sy-subrc IS NOT INITIAL.
    gs_bal_log-msgty = 'W'.
    gs_bal_log-msgid = 'ZCM_MSG_CLASS_2'.
    gs_bal_log-msgno = 20.

    PERFORM add_log.
    PERFORM save_log.
    LEAVE PROGRAM.
  ELSE.
    gs_bal_log-msgty = 'S'.
    gs_bal_log-msgid = 'ZCM_MSG_CLASS_2'.
    gs_bal_log-msgno = 21.

    PERFORM add_log.
    PERFORM save_log.
  ENDIF.
ENDFORM.

FORM add_log .
  CALL FUNCTION 'BAL_LOG_MSG_ADD'
    EXPORTING
      i_log_handle     = gv_log_handle
      i_s_msg          = gs_bal_log
    EXCEPTIONS
      log_not_found    = 1
      msg_inconsistent = 2
      log_is_full      = 3
      OTHERS           = 4.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

  CLEAR: gs_bal_log.
ENDFORM.

FORM save_log .
  CALL FUNCTION 'BAL_DB_SAVE'
    EXPORTING
      i_save_all       = abap_true
    EXCEPTIONS
      log_not_found    = 1
      save_not_allowed = 2
      numbering_error  = 3
      OTHERS           = 4.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

*  LEAVE PROGRAM.
ENDFORM.
