*&---------------------------------------------------------------------*
*& Report ZABAP_CM_025
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_263.

PARAMETERS: p_i_bas TYPE sy-datum OBLIGATORY,
            p_i_bit TYPE sy-datum OBLIGATORY,
            p_id    TYPE zcm_de_id OBLIGATORY.

DATA: "go_yillik_izin     TYPE REF TO zcmtest_yillik_izin_class_tst,
  gv_calisan_mevcut  TYPE c LENGTH 1,
  gv_yil_1           TYPE char4,
  gv_yil_2           TYPE char4,
  gv_talep_izin_1    TYPE int1,
  gv_talep_izin_2    TYPE int1,
  gv_izin_alabilir_1 TYPE c LENGTH 1,
  gv_izin_alabilir_2 TYPE c LENGTH 1,
  gv_answer          TYPE c LENGTH 1.

START-OF-SELECTION.

*  CREATE OBJECT go_yillik_izin.
  DATA(go_yillik_izin) = NEW zcmtest_yillik_izin_class_tst( ).

  go_yillik_izin->log_hazirlik( ).

  go_yillik_izin->log_ekle(
    EXPORTING
      iv_msgty = 'S'
      iv_msgid = 'ZCM_MSG_CLASS_YI_T'
      iv_msgno = 0
      iv_msgv1 = CONV #( sy-datum )
      iv_msgv2 = CONV #( sy-uzeit )
      iv_msgv3 = CONV #( sy-uname ) ).

  go_yillik_izin->log_ekle(
    EXPORTING
      iv_msgty = 'S'
      iv_msgid = 'ZCM_MSG_CLASS_YI_T'
      iv_msgno = 1
      iv_msgv1 = CONV #( p_i_bas )
      iv_msgv2 = CONV #( p_i_bit )
      iv_msgv3 = CONV #( p_id ) ).


  IF p_i_bas > p_i_bit.

    go_yillik_izin->log_ekle(
      EXPORTING
        iv_msgty = 'W'
        iv_msgid = 'ZCM_MSG_CLASS_YI_T'
        iv_msgno = 2 ).

    go_yillik_izin->loglari_kaydet( ).
    EXIT.
  ENDIF.

  IF p_i_bas < sy-datum.
    go_yillik_izin->log_ekle(
      EXPORTING
        iv_msgty = 'W'
        iv_msgid = 'ZCM_MSG_CLASS_YI_T'
        iv_msgno = 3 ).

    go_yillik_izin->loglari_kaydet( ).
    EXIT.
  ENDIF.

  go_yillik_izin->id_kontrol(
    EXPORTING
      iv_id             = p_id
    IMPORTING
      ev_calisan_mevcut = gv_calisan_mevcut ).

  IF gv_calisan_mevcut = abap_false.

    go_yillik_izin->log_ekle(
      EXPORTING
        iv_msgty = 'W'
        iv_msgid = 'ZCM_MSG_CLASS_YI_T'
        iv_msgno = 4 ).

    go_yillik_izin->loglari_kaydet( ).
    EXIT.
  ELSE.
    go_yillik_izin->log_ekle(
      EXPORTING
        iv_msgty = 'S'
        iv_msgid = 'ZCM_MSG_CLASS_YI_T'
        iv_msgno = 5 ).
  ENDIF.

  go_yillik_izin->izin_kontrol(
    EXPORTING
      iv_id               = p_id
      iv_izin_baslangic   = p_i_bas
      iv_izin_bitis       = p_i_bit
    IMPORTING
      ev_yil_1            = gv_yil_1
      ev_talep_izin_1     = gv_talep_izin_1
      ev_izin_alabilir_1  = gv_izin_alabilir_1
      ev_yil_2            = gv_yil_2
      ev_talep_izin_2     = gv_talep_izin_2
      ev_izin_alabilir_2  = gv_izin_alabilir_2
    EXCEPTIONS
      sifir_is_gunu       = 1
      yetersiz_izin_hakki = 2
      mevcut_kayit        = 3
      OTHERS              = 4  ).

  IF sy-subrc = 1.
    go_yillik_izin->log_ekle(
      EXPORTING
        iv_msgty = 'W'
        iv_msgid = 'ZCM_MSG_CLASS_YI_T'
        iv_msgno = 6 ).

    go_yillik_izin->loglari_kaydet( ).
    EXIT.
  ELSEIF sy-subrc = 2.
    go_yillik_izin->log_ekle(
      EXPORTING
        iv_msgty = 'W'
        iv_msgid = 'ZCM_MSG_CLASS_YI_T'
        iv_msgno = 7 ).

    go_yillik_izin->loglari_kaydet( ).
    EXIT.
  ELSEIF sy-subrc = 3.
    go_yillik_izin->log_ekle(
      EXPORTING
        iv_msgty = 'W'
        iv_msgid = 'ZCM_MSG_CLASS_YI_T'
        iv_msgno = 8 ).

    go_yillik_izin->loglari_kaydet( ).
    EXIT.
  ENDIF.

  "Girilen 2 tarih arasinda is günü var mi?
  "Calisanin izin hakki var mi?
  "Girilen tarihler var olan tarihlerle kesisiyor mu?

  IF p_i_bas(4) NE p_i_bit(4).

    "Girilen tarihler farkli yillara ait.
    IF ( gv_izin_alabilir_1 IS INITIAL AND gv_izin_alabilir_2 IS NOT INITIAL ) OR
       ( gv_izin_alabilir_1 IS NOT INITIAL AND gv_izin_alabilir_2 IS INITIAL ).

      "Ya baslangic yili ya da bitis yili izin almaya müsait.
      "Kullaniciya soralim, kismi veri girisi yapilmasini onayliyor mu.
      CALL FUNCTION 'POPUP_TO_CONFIRM'
        EXPORTING
          text_question  = 'Kismi veri girisi yapilmasini onayliyormusunuz?'
          text_button_1  = 'Evet'
          text_button_2  = 'Hayir'
        IMPORTING
          answer         = gv_answer
        EXCEPTIONS
          text_not_found = 1
          OTHERS         = 2.

      IF sy-subrc IS NOT INITIAL.
        EXIT.
      ENDIF.

      "Kullanici kismi veri girisini onayladi.
      "Baslangic veya bitis yilindaki izni tabloya ekleyelim.
      IF gv_answer = 1.
        IF gv_izin_alabilir_1 IS NOT INITIAL.
          go_yillik_izin->izin_ekle(
            EXPORTING
              iv_id             = p_id
              iv_yil            = gv_yil_1
              iv_izin_baslangic = p_i_bas
              iv_izin_bitis     = p_i_bas(4) && '1231'  "20241215  -----> 20241231
              iv_kul_izin       = gv_talep_izin_1 ).
        ENDIF.

        IF gv_izin_alabilir_2 IS NOT INITIAL.
          go_yillik_izin->izin_ekle(
            EXPORTING
              iv_id             = p_id
              iv_yil            = gv_yil_2
              iv_izin_baslangic = p_i_bit(4) && '0101'
              iv_izin_bitis     = p_i_bit
              iv_kul_izin       = gv_talep_izin_2 ).
        ENDIF.
      ENDIF.
    ELSEIF gv_izin_alabilir_1 IS NOT INITIAL AND gv_izin_alabilir_2 IS NOT INITIAL.
      go_yillik_izin->izin_ekle(
        EXPORTING
          iv_id             = p_id
          iv_yil            = gv_yil_1
          iv_izin_baslangic = p_i_bas
          iv_izin_bitis     = p_i_bas(4) && '1231'
          iv_kul_izin       = gv_talep_izin_1 ).

      go_yillik_izin->izin_ekle(
        EXPORTING
          iv_id             = p_id
          iv_yil            = gv_yil_2
          iv_izin_baslangic = p_i_bit(4) && '0101'
          iv_izin_bitis     = p_i_bit
          iv_kul_izin       = gv_talep_izin_2 ).

    ENDIF.
  ELSE.
    "Girilen her iki tarih de ayni yila ait.
    IF gv_izin_alabilir_1 IS NOT INITIAL.
      go_yillik_izin->izin_ekle(
        EXPORTING
          iv_id             = p_id
          iv_yil            = gv_yil_1
          iv_izin_baslangic = p_i_bas
          iv_izin_bitis     = p_i_bit
          iv_kul_izin       = gv_talep_izin_1 ).
    ENDIF.
  ENDIF.
