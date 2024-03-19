*&---------------------------------------------------------------------*
*& Report ZCM_TEST_139
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_225.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_agnum TYPE s_agncynum OBLIGATORY,
              p_name  TYPE string LOWER CASE.
SELECTION-SCREEN END OF BLOCK a1.

DATA: gs_log_info       TYPE bal_s_log,
      gs_bal_log        TYPE bal_s_msg,
      gv_log_handle     TYPE balloghndl,
      gv_timestamp      TYPE tzntstmps,
      gs_stravelag      TYPE zcm_stravelag,
      gv_number_of_char TYPE i.

CONSTANTS: gc_object     TYPE balobj_d  VALUE 'ZCM_OBJ_1',
           gc_sub_object TYPE balsubobj VALUE 'ZCM_SUB_1'.

START-OF-SELECTION.

  PERFORM prep_log.
  PERFORM first_log.
  PERFORM check_id.
  PERFORM check_name.
  PERFORM update.
  PERFORM save_log.

FORM prep_log.
  "Olusturulacak log kaydinda kullanilmak üzere tarih ve saat bilgisini hazirliyoruz.
  "Olusturulacak gv_timestamp isimli degisken YYYYMMDDHHMMSS seklinde olacaktir.
  CONVERT DATE sy-datum TIME sy-uzeit INTO TIME STAMP gv_timestamp TIME ZONE sy-zonlo.

  "Log kaydi olusturabilmek icin önce bir sira numarasi almamiz gerekiyor.
  "Bu sira numarasini alabilmek alttaki satiri hazirlamamiz gerekiyor.
  "Bu satiri hazirlarken önceden olusturdugumuz obje, alt-obje ve timestamp'i kullaniyoruz.
  gs_log_info-object    = gc_object.
  gs_log_info-subobject = gc_sub_object.
  gs_log_info-extnumber = gv_timestamp.
  CONDENSE gs_log_info-extnumber.

  "Olusturacagimiz kaydin 2 hafta otomatik olarak silinmesini istiyoruz.
  "Bu nedenle bugünün tarihinin 2 hafta sonrasini bularak hazirladigimiz satirin
  "aldate_del hücresi icine kaydediyoruz.
  CALL FUNCTION 'ADD_TIME_TO_DATE'
    EXPORTING
      i_idate               = sy-datum
      i_time                = 2   "2 tane
      i_iprkz               = '1' "Hafta
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

  "Hazirladigimiz satiri kullanarak sira numarasi olusturuyoruz.
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

FORM first_log.

  "Ilk log kaydi icin satiri dolduruyoruz.
  gs_bal_log-msgty = 'S'.
  gs_bal_log-msgid = 'ZCM_MSG_CLASS_1'.
  gs_bal_log-msgno = 12.
  gs_bal_log-msgv1 = sy-datum.
  gs_bal_log-msgv2 = sy-uzeit.
  gs_bal_log-msgv3 = sy-uname.

  "Ilk log kaydini ekliyoruz.
  PERFORM add_log.

  "Ikinci log kaydi icin satiri dolduruyoruz.
  gs_bal_log-msgty = 'S'.
  gs_bal_log-msgid = 'ZCM_MSG_CLASS_1'.
  gs_bal_log-msgno = 13.
  gs_bal_log-msgv1 = p_agnum.
  gs_bal_log-msgv2 = p_name.

  "Ikinci log kaydini ekliyoruz.
  PERFORM add_log.

ENDFORM.

FORM check_id.
  SELECT SINGLE * FROM zcm_stravelag
    INTO gs_stravelag
    WHERE agencynum = p_agnum.

  IF gs_stravelag IS INITIAL.
    "Aranan satirin bulunamadigina dair log kaydini dolduruyoruz.
    gs_bal_log-msgty = 'E'.
    gs_bal_log-msgid = 'ZCM_MSG_CLASS_1'.
    gs_bal_log-msgno = 14.
    gs_bal_log-msgv1 = p_agnum.

    "Log kaydini ekliyoruz.
    PERFORM add_log.

    "Eklenen log kayitlarini sisteme kaydedip cikiyoruz.
    PERFORM save_log.
    LEAVE PROGRAM.
  ELSE.
    "Aranan satirin bulunaduguna dair log kaydini dolduruyoruz.
    gs_bal_log-msgty = 'S'.
    gs_bal_log-msgid = 'ZCM_MSG_CLASS_1'.
    gs_bal_log-msgno = 15.
    gs_bal_log-msgv1 = p_agnum.

    "Log kaydini ekliyoruz.
    PERFORM add_log.
  ENDIF.
ENDFORM.

FORM check_name.
  IF p_name IS INITIAL.
    "Girilen yeni ismin bos olduguna dair log kaydini dolduruyoruz.
    gs_bal_log-msgty = 'E'.
    gs_bal_log-msgid = 'ZCM_MSG_CLASS_1'.
    gs_bal_log-msgno = 16.

    "Log kaydini ekliyoruz.
    PERFORM add_log.

    "Eklenen log kayitlarini sisteme kaydedip cikiyoruz.
    PERFORM save_log.
    LEAVE PROGRAM.
  ELSE.
    "Girilen yeni ismin bos olmadigina dair log kaydini dolduruyoruz.
    gs_bal_log-msgty = 'S'.
    gs_bal_log-msgid = 'ZCM_MSG_CLASS_1'.
    gs_bal_log-msgno = 17.

    "Log kaydini ekliyoruz.
    PERFORM add_log.
  ENDIF.

  gv_number_of_char = strlen( p_name ).

  IF gv_number_of_char > 25.
    "Girilen yeni ismin 25 karakterden büyük olduguna dair log kaydini dolduruyoruz.
    gs_bal_log-msgty = 'E'.
    gs_bal_log-msgid = 'ZCM_MSG_CLASS_1'.
    gs_bal_log-msgno = 18.
    gs_bal_log-msgv1 = p_name.

    "Log kaydini ekliyoruz.
    PERFORM add_log.

    "Eklenen log kayitlarini sisteme kaydedip cikiyoruz.
    PERFORM save_log.
    LEAVE PROGRAM.
  ELSE.
    "Girilen yeni ismin 25 karakterden büyük olmadigina dair log kaydini dolduruyoruz.
    gs_bal_log-msgty = 'S'.
    gs_bal_log-msgid = 'ZCM_MSG_CLASS_1'.
    gs_bal_log-msgno = 19.
    gs_bal_log-msgv1 = p_name.

    "Log kaydini ekliyoruz.
    PERFORM add_log.
  ENDIF.
ENDFORM.

FORM update.
  UPDATE zcm_stravelag SET   name      = p_name
                       WHERE agencynum = p_agnum.

  IF sy-subrc IS NOT INITIAL.
    "Update isleminin basarili olmadigina dair log kaydini dolduruyoruz.
    gs_bal_log-msgty = 'E'.
    gs_bal_log-msgid = 'ZCM_MSG_CLASS_1'.
    gs_bal_log-msgno = 20.

    "Log kaydini ekliyoruz.
    PERFORM add_log.

    "Eklenen log kayitlarini sisteme kaydedip cikiyoruz.
    PERFORM save_log.
    LEAVE PROGRAM.
  ELSE.
    "Update isleminin basarili olduguna dair log kaydini dolduruyoruz.
    gs_bal_log-msgty = 'S'.
    gs_bal_log-msgid = 'ZCM_MSG_CLASS_1'.
    gs_bal_log-msgno = 21.

    "Log kaydini ekliyoruz.
    PERFORM add_log.
  ENDIF.
ENDFORM.

FORM add_log.
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

FORM save_log.
  "Program icinde eklenmis tüm log kayitlarini sisteme kaydediyoruz.
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
ENDFORM.
