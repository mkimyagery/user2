class ZYCMTEST_YILLIK_IZIN_CLASS definition
  public
  final
  create public .

public section.

  data GS_LOG_INFO type BAL_S_LOG .
  data GS_BAL_LOG type BAL_S_MSG .
  data GV_LOG_HANDLE type BALLOGHNDL .
  data GV_TIMESTAMP type TZNTSTMPS .
  constants GC_OBJECT type BALOBJ_D value 'ZCM_OBJ_1' ##NO_TEXT.
  constants GC_SUB_OBJECT type BALSUBOBJ value 'ZCM_SUB_1' ##NO_TEXT.

  methods ID_KONTROL
    importing
      !IV_ID type ZCM_DE_ID
    exporting
      !EV_CALISAN_MEVCUT type CHAR1 .
  methods IZIN_KONTROL
    importing
      !IV_ID type ZCM_DE_ID
      !IV_IZIN_BASLANGIC type SY-DATUM
      !IV_IZIN_BITIS type SY-DATUM
    exporting
      !EV_YIL_2 type CHAR4
      !EV_TALEP_IZIN_2 type INT1
      !EV_IZIN_ALABILIR_2 type CHAR1
      !EV_YIL_1 type CHAR4
      !EV_TALEP_IZIN_1 type INT1
      !EV_IZIN_ALABILIR_1 type CHAR1
    exceptions
      SIFIR_IS_GUNU
      YETERSIZ_IZIN_HAKKI
      MEVCUT_KAYIT .
  methods IZIN_EKLE
    importing
      !IV_ID type ZCM_DE_ID
      !IV_YIL type CHAR4
      !IV_IZIN_BASLANGIC type SY-DATUM
      !IV_IZIN_BITIS type SY-DATUM
      !IV_KUL_IZIN type INT1 .
  methods LOG_HAZIRLIK .
  methods LOG_EKLE
    importing
      !IV_MSGTY type SYMSGTY
      !IV_MSGID type SYMSGID
      !IV_MSGNO type SYMSGNO
      !IV_MSGV1 type SYMSGV optional
      !IV_MSGV2 type SYMSGV optional
      !IV_MSGV3 type SYMSGV optional
      !IV_MSGV4 type SYMSGV optional .
  methods LOG_KAYDET .
protected section.
private section.
ENDCLASS.



CLASS ZYCMTEST_YILLIK_IZIN_CLASS IMPLEMENTATION.


  METHOD ID_KONTROL.

    DATA: ls_tablo_1 TYPE zcm_tablo_1.

    SELECT SINGLE * FROM zcm_tablo_1
      INTO ls_tablo_1
      WHERE id = iv_id.

    IF ls_tablo_1 IS NOT INITIAL.
      ev_calisan_mevcut = abap_true.
    ENDIF.

  ENDMETHOD.


  METHOD IZIN_EKLE.

    DATA: ls_tablo_2 TYPE zcm_tablo_2.

    ls_tablo_2-id = iv_id.
    ls_tablo_2-yil = iv_yil.
    ls_tablo_2-izin_baslangic = iv_izin_baslangic.
    ls_tablo_2-izin_bitis = iv_izin_bitis.
    ls_tablo_2-kul_izin = iv_kul_izin.

    INSERT zcm_tablo_2 FROM ls_tablo_2.

    IF sy-subrc IS INITIAL.
      log_ekle(
        EXPORTING
          iv_msgty = 'S'
          iv_msgid = 'ZCM_MSG_CLASS_3'
          iv_msgno = 9 ).
    ELSE.
      log_ekle(
        EXPORTING
          iv_msgty = 'W'
          iv_msgid = 'ZCM_MSG_CLASS_3'
          iv_msgno = 10 ).
    ENDIF.

    log_kaydet( ).

    MESSAGE 'Islem sona erdi, lütfen loglari kontrol ediniz.' TYPE 'I'.
  ENDMETHOD.


  METHOD IZIN_KONTROL.

    DATA: lv_is_gunu    TYPE i,
          ls_tablo_1    TYPE zcm_tablo_1,
          lt_tablo_2    TYPE TABLE OF zcm_tablo_2,
          ls_tablo_2    TYPE zcm_tablo_2,
          lv_kul_izin   TYPE i,
          lv_izin_bas   TYPE sy-datum,
          lv_izin_bitis TYPE sy-datum,
          lv_yetersiz_izin TYPE c LENGTH 1.

    CALL FUNCTION 'HR_RO_WORKDAYS_IN_INTERVAL'
      EXPORTING
        begda   = iv_izin_baslangic
        endda   = iv_izin_bitis
        mofid   = '08'
      CHANGING
        wrkdays = lv_is_gunu.

    IF lv_is_gunu = 0.
      RAISE sifir_is_gunu.
    ENDIF.

    IF iv_izin_baslangic(4) = iv_izin_bitis(4).   "YYYYMMDD

      SELECT SINGLE * FROM zcm_tablo_1
        INTO ls_tablo_1
        WHERE id = iv_id.

      SELECT * FROM zcm_tablo_2
        INTO TABLE lt_tablo_2
        WHERE id = iv_id AND
              yil = iv_izin_baslangic(4).

      LOOP AT lt_tablo_2 INTO ls_tablo_2.
        lv_kul_izin = lv_kul_izin + ls_tablo_2-kul_izin.

        IF iv_izin_baslangic BETWEEN ls_tablo_2-izin_baslangic AND ls_tablo_2-izin_bitis OR
           iv_izin_bitis     BETWEEN ls_tablo_2-izin_baslangic AND ls_tablo_2-izin_bitis.
          RAISE mevcut_kayit.
        ENDIF.
      ENDLOOP.

      IF lv_is_gunu > ls_tablo_1-izin_hakki - lv_kul_izin.
        RAISE yetersiz_izin_hakki.
      ENDIF.

      ev_izin_alabilir_1 = abap_true.
      ev_yil_1 = iv_izin_baslangic(4).
      ev_talep_izin_1 = lv_is_gunu.

    ELSE.

      lv_izin_bitis = iv_izin_baslangic(4) && '1231'.

      CALL FUNCTION 'HR_RO_WORKDAYS_IN_INTERVAL'
        EXPORTING
          begda   = iv_izin_baslangic
          endda   = lv_izin_bitis
          mofid   = '08'
        CHANGING
          wrkdays = lv_is_gunu.

      IF lv_is_gunu IS NOT INITIAL.

        SELECT SINGLE * FROM zcm_tablo_1
          INTO ls_tablo_1
          WHERE id = iv_id.

        SELECT * FROM zcm_tablo_2
          INTO TABLE lt_tablo_2
          WHERE id = iv_id AND
                yil = iv_izin_baslangic(4).

        LOOP AT lt_tablo_2 INTO ls_tablo_2.
          lv_kul_izin = lv_kul_izin + ls_tablo_2-kul_izin.

          IF iv_izin_baslangic BETWEEN ls_tablo_2-izin_baslangic AND ls_tablo_2-izin_bitis OR
             lv_izin_bitis BETWEEN ls_tablo_2-izin_baslangic AND ls_tablo_2-izin_bitis.
          ENDIF.
        ENDLOOP.

        IF lv_is_gunu <= ls_tablo_1-izin_hakki - lv_kul_izin.
          ev_izin_alabilir_1 = abap_true.
          ev_yil_1 = iv_izin_baslangic(4).
          ev_talep_izin_1 = lv_is_gunu.
        ELSE.
          lv_yetersiz_izin = abap_true.
        ENDIF.
      ENDIF.

      lv_izin_bas = iv_izin_bitis(4) && '0101'.

      CALL FUNCTION 'HR_RO_WORKDAYS_IN_INTERVAL'
        EXPORTING
          begda   = lv_izin_bas
          endda   = iv_izin_bitis
          mofid   = '08'
        CHANGING
          wrkdays = lv_is_gunu.

      IF lv_is_gunu IS NOT INITIAL.
        SELECT SINGLE * FROM zcm_tablo_1
          INTO ls_tablo_1
          WHERE id = iv_id.

        SELECT * FROM zcm_tablo_2
          INTO TABLE lt_tablo_2
          WHERE id = iv_id AND
                yil = iv_izin_bitis(4).

        CLEAR: lv_kul_izin.

        LOOP AT lt_tablo_2 INTO ls_tablo_2.
          lv_kul_izin = lv_kul_izin + ls_tablo_2-kul_izin.

          IF lv_izin_bas BETWEEN ls_tablo_2-izin_baslangic AND ls_tablo_2-izin_bitis OR
             iv_izin_bitis BETWEEN ls_tablo_2-izin_baslangic AND ls_tablo_2-izin_bitis.
            RAISE mevcut_kayit.
          ENDIF.
        ENDLOOP.

        IF lv_is_gunu <= ls_tablo_1-izin_hakki - lv_kul_izin.
          ev_yil_2 = iv_izin_bitis(4).
          ev_talep_izin_2 = lv_is_gunu.
          ev_izin_alabilir_2 = abap_true.
        ELSE.
          IF lv_yetersiz_izin IS NOT INITIAL.
            RAISE yetersiz_izin_hakki.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.


  METHOD LOG_EKLE.

    gs_bal_log-msgty = iv_msgty.
    gs_bal_log-msgid = iv_msgid.
    gs_bal_log-msgno = iv_msgno.
    gs_bal_log-msgv1 = iv_msgv1.
    gs_bal_log-msgv2 = iv_msgv2.
    gs_bal_log-msgv3 = iv_msgv3.
    gs_bal_log-msgv4 = iv_msgv4.

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
  ENDMETHOD.


  METHOD LOG_HAZIRLIK.

    CONVERT DATE sy-datum TIME sy-uzeit
    INTO TIME STAMP gv_timestamp TIME ZONE sy-zonlo.

    gs_log_info-object    = gc_object.
    gs_log_info-subobject = gc_sub_object.
    gs_log_info-extnumber = gv_timestamp.

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
  ENDMETHOD.


  METHOD LOG_KAYDET.

    CALL FUNCTION 'BAL_DB_SAVE'
      EXPORTING
        i_save_all       = abap_true
      EXCEPTIONS
        log_not_found    = 1
        save_not_allowed = 2
        numbering_error  = 3
        OTHERS           = 4.

    IF sy-subrc IS not INITIAL.
      LEAVE PROGRAM.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
