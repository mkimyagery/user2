class ZYCMTEST_YILLIK_IZIN_2 definition
  public
  final
  create public .

public section.

  methods IZIN_EKLE
    importing
      !IV_ID type ZCM_DE_ID
      !IV_IZIN_BASLANGIC type SY-DATUM
      !IV_IZIN_BITIS type SY-DATUM
    exporting
      !EV_OK type CHAR1 .
protected section.

  methods ID_KONTROL
    importing
      !IV_ID type ZCM_DE_ID
    exporting
      !EV_OK type CHAR1 .
  methods IZIN_KONTROL
    importing
      !IV_ID type ZCM_DE_ID
      !IV_IZIN_BASLANGIC type SY-DATUM
      !IV_IZIN_BITIS type SY-DATUM
    exporting
      !EV_IZIN_OK type CHAR1 .
private section.
ENDCLASS.



CLASS ZYCMTEST_YILLIK_IZIN_2 IMPLEMENTATION.


  METHOD ID_KONTROL.

    DATA: ls_tablo_1 TYPE ZCM_TABLO_1.

    SELECT SINGLE id from zcm_tablo_1 INTO ls_tablo_1 WHERE id = iv_id.

      IF ls_tablo_1 IS NOT INITIAL.
        ev_ok = abap_true.
      ENDIF.
  ENDMETHOD.


  method IZIN_EKLE.

    DATA: lv_ok.
*
*    id_kontrol(
*      EXPORTING
*        iv_id = iv_id
*      IMPORTING
*        ev_ok = lv_ok ).
*
*    IF lv_ok = abap_true.
*
*      izin_kontrol(
*        EXPORTING
*          iv_id         = iv_id
*          iv_yil        = iv_yil
*        IMPORTING
*          ev_kalan_izin =
*      ).

*    ENDIF.
  endmethod.


  METHOD IZIN_KONTROL.

    DATA: lt_tablo_2      TYPE TABLE OF zcm_tablo_2,
          ls_tablo_2      TYPE zcm_tablo_2,
          lv_kul_izin     TYPE i,
          lv_toplam_izin  TYPE i,
          lv_yil          TYPE c LENGTH 4,
          lv_work         TYPE i,
          lv_work_bu_yil  TYPE i,
          lv_work_sonraki TYPE i.



*    IF iv_izin_baslangic(4) = iv_izin_bitis(4).
*
*      CALL FUNCTION 'HR_RO_WORKDAYS_IN_INTERVAL'
*        EXPORTING
*          begda   = iv_izin_baslangic - 1
*          endda   = iv_izin_bitis + 1
*          mofid   = '08'
**       TABLES
**         I2003   =
*        CHANGING
*          wrkdays = lv_work.
**       HOLIDAYS       = .
*
*      lv_yil = iv_izin_baslangic(4).
*
*      SELECT * FROM zcm_tablo_2 INTO TABLE lt_tablo_2 WHERE id = iv_id AND yil = lv_yil.
*
*      LOOP AT lt_tablo_2 INTO ls_tablo_2.
*        lv_kul_izin = lv_kul_izin + ls_tablo_2-kul_izin.
*        IF lv_toplam_izin IS INITIAL.
*          lv_toplam_izin = ls_tablo_2-toplam_izin.
*        ENDIF.
*      ENDLOOP.
*
*      IF lv_work <= ( lv_toplam_izin - lv_kul_izin ) .
*        ev_izin_ok = abap_true.
*        RETURN.
*      ENDIF.
*
*    ELSE.
*
*      CALL FUNCTION 'HR_RO_WORKDAYS_IN_INTERVAL'
*        EXPORTING
*          begda   = iv_izin_baslangic - 1
*          endda   = '20241231'
*          mofid   = '08'
**       TABLES
**         I2003   =
*        CHANGING
*          wrkdays = lv_work_bu_yil.
**       HOLIDAYS       = .
*
*      lv_yil = iv_izin_baslangic(4).
*
*      SELECT * FROM zcm_tablo_2 INTO TABLE lt_tablo_2 WHERE id = iv_id AND yil = lv_yil.
*
*      LOOP AT lt_tablo_2 INTO ls_tablo_2.
*        lv_kul_izin = lv_kul_izin + ls_tablo_2-kul_izin.
*        IF lv_toplam_izin IS INITIAL.
*          lv_toplam_izin = ls_tablo_2-toplam_izin.
*        ENDIF.
*      ENDLOOP.
*
*      IF lv_work_bu_yil <= lv_toplam_izin - lv_kul_izin.
*
*        CALL FUNCTION 'HR_RO_WORKDAYS_IN_INTERVAL'
*          EXPORTING
*            begda   = '20250101'
*            endda   = iv_izin_bitis
*            mofid   = '08'
**       TABLES
**           I2003   =
*          CHANGING
*            wrkdays = lv_work_sonraki.
**       HOLIDAYS       = .
*
*        lv_yil = iv_izin_bitis(4).
*
*        SELECT * FROM zcm_tablo_2 INTO TABLE lt_tablo_2 WHERE id = iv_id AND yil = lv_yil.
*
*
*      ENDIF.
*
*
*
*    ENDIF.

  ENDMETHOD.
ENDCLASS.
