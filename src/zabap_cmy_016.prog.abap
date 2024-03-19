*&---------------------------------------------------------------------*
*& Report ZABAP_CM_016
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_cmy_016.

PARAMETERS: p_i_bas TYPE sy-datum OBLIGATORY,
            p_i_bit TYPE sy-datum OBLIGATORY,
            p_id    TYPE zcm_de_id OBLIGATORY.

DATA: go_izin              TYPE REF TO zcmtest_yillik_izin,
      gv_calisan_mevcut,
      gv_izin_alabilir_1,
      gv_izin_alabilir_2,
      gv_yil_1(4),
      gv_yil_2(4),
      gv_kullanilan_izin_1 TYPE int1,
      gv_kullanilan_izin_2 TYPE int1,
      gv_answer.

START-OF-SELECTION.

  IF p_i_bas > p_i_bit.
    MESSAGE 'Izin baslangic tarihi izin bitis tarihinden büyük olamaz.' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  IF p_i_bas < sy-datum.
    MESSAGE 'Izin baslangic tarihi bugünün tarihinden kücük olamaz.' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  CREATE OBJECT go_izin.

  go_izin->id_kontrol(
    EXPORTING
      iv_id             = p_id
    IMPORTING
      ev_calisan_mevcut = gv_calisan_mevcut ).

  IF gv_calisan_mevcut IS NOT INITIAL.

    go_izin->izin_kontrol(
      EXPORTING
        iv_id             = p_id
        iv_izin_baslangic = p_i_bas
        iv_izin_bitis     = p_i_bit
      IMPORTING
        ev_yil_1             = gv_yil_1
        ev_yil_2             = gv_yil_2
        ev_kullanilan_izin_1 = gv_kullanilan_izin_1
        ev_kullanilan_izin_2 = gv_kullanilan_izin_2
        ev_izin_alabilir_1   = gv_izin_alabilir_1
        ev_izin_alabilir_2   = gv_izin_alabilir_2
      EXCEPTIONS
        sifir_is_gunu       = 1
        yetersiz_izin_hakki = 2
        mevcut_kayit        = 3 ).

    IF sy-subrc = 1.
      MESSAGE 'Girilen tarih araliginda is günü bulunmamaktadir.' TYPE 'S' DISPLAY LIKE 'E'.
      EXIT.
    ELSEIF  sy-subrc = 2.
      MESSAGE 'Yeterli izin hakki bulunmamaktadir.' TYPE 'S' DISPLAY LIKE 'E'.
      EXIT.
    ELSEIF  sy-subrc = 3.
      MESSAGE 'Girilen tarih araliginda mevcut kayit bulunmaktadir.' TYPE 'S' DISPLAY LIKE 'E'.
      EXIT.
    ENDIF.

    IF p_i_bas(4) NE p_i_bit(4).
      "Girilen tarihler farkli yillara ait.
      IF ( gv_izin_alabilir_1 IS INITIAL     AND gv_izin_alabilir_2 IS NOT INITIAL ) OR
         ( gv_izin_alabilir_1 IS NOT INITIAL AND gv_izin_alabilir_2 IS INITIAL ).

        "Ya baslangic yili ya da bitis yili izin almaya müsait.
        "Kullaniciya soralim, kismi veri girisi yapilmasini onayliyor mu.
        CALL FUNCTION 'POPUP_TO_CONFIRM'
          EXPORTING
            text_question  = 'Kismi veri girisi yapilmasini onayliyor musunuz?'
            text_button_1  = 'Evet'
            text_button_2  = 'Hayir'(002)
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
            go_izin->izin_ekle(
              EXPORTING
                iv_id             = p_id
                iv_yil            = gv_yil_1
                iv_izin_baslangic = p_i_bas
                iv_izin_bitis     = p_i_bas(4) && '1231'
                iv_kul_izin       = gv_kullanilan_izin_1 ).
          ENDIF.

          IF gv_izin_alabilir_2 IS NOT INITIAL.
            go_izin->izin_ekle(
              EXPORTING
                iv_id             = p_id
                iv_yil            = gv_yil_2
                iv_izin_baslangic = p_i_bit(4) && '0101'
                iv_izin_bitis     = p_i_bit
                iv_kul_izin       = gv_kullanilan_izin_2 ).
          ENDIF.
        ENDIF.

      "Hem baslangic yili hem de bitis izin almaya müsait.
      "Her ikisini de ekleyelim.
      ELSEIF gv_izin_alabilir_1 IS NOT INITIAL AND gv_izin_alabilir_2 IS NOT INITIAL.
        go_izin->izin_ekle(
          EXPORTING
            iv_id             = p_id
            iv_yil            = gv_yil_1
            iv_izin_baslangic = p_i_bas
            iv_izin_bitis     = p_i_bas(4) && '1231'
            iv_kul_izin       = gv_kullanilan_izin_1 ).

        go_izin->izin_ekle(
          EXPORTING
            iv_id             = p_id
            iv_yil            = gv_yil_2
            iv_izin_baslangic = p_i_bit(4) && '0101'
            iv_izin_bitis     = p_i_bit
            iv_kul_izin       = gv_kullanilan_izin_2 ).
      ENDIF.
    ELSE.

      "Girilen her iki tarih de ayni yila ait.
      IF gv_izin_alabilir_1 IS NOT INITIAL.
        go_izin->izin_ekle(
          EXPORTING
            iv_id             = p_id
            iv_yil            = gv_yil_1
            iv_izin_baslangic = p_i_bas
            iv_izin_bitis     = p_i_bit
            iv_kul_izin       = gv_kullanilan_izin_1 ).
      ENDIF.
    ENDIF.
  ENDIF.
