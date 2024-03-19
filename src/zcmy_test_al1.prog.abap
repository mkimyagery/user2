*&---------------------------------------------------------------------*
*& Report ZCM_TEST_AL1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_al1.

""""ACIKLAMALARI YAZALIM.

PARAMETERS: p_id TYPE zcm_de_id.

DATA: gv_toplam_izin TYPE n LENGTH 3,
      gv_yil_yeni(4).

START-OF-SELECTION.

  DATA(go_calisan) = NEW zcmcalisan_bilgileri_2( ).

  go_calisan->calisan_bilgilerini_al(
    EXPORTING
      iv_id                = p_id
    IMPORTING
      es_calisan_bilgileri = DATA(gs_calisan) ).

  go_calisan->izin_bilgilerini_al(
    EXPORTING
      iv_id   = p_id
    IMPORTING
      et_izin = DATA(gt_izin) ).

  SHIFT gs_calisan-id LEFT DELETING LEADING '0'.

  DATA(gv_string_1) = |{ gs_calisan-id }| & | | & |ID'sine sahip| & | | & |{ gs_calisan-ad }| & | | & |{ gs_calisan-soyad }|.

  LOOP AT gt_izin INTO DATA(gs_izin) GROUP BY ( yil = gs_izin-yil )
                                     INTO DATA(gt_group).

    LOOP AT GROUP gt_group INTO DATA(gs_group).
      DATA(gv_yil) = gs_group-yil.
      gv_toplam_izin = gv_toplam_izin + gs_group-kul_izin.
    ENDLOOP.

    SHIFT gv_toplam_izin LEFT DELETING LEADING '0'.

    gv_yil_yeni = gv_yil + 1.

    READ TABLE gt_izin WITH KEY yil = gv_yil_yeni TRANSPORTING NO FIELDS.
    IF sy-subrc IS INITIAL.
      DATA(gv_string_2) = |{ gv_yil }| & | | & |yilinda| & | | & |{ gv_toplam_izin }| & | | & |gün,|.
    ELSE.
      gv_string_2 = |{ gv_yil }| & | | & |yilinda| & | | & |{ gv_toplam_izin }| & | | & |gün|.
    ENDIF.

    gv_string_1 = |{ gv_string_1 }| & | | & |{ gv_string_2 }|.

    CLEAR: gv_toplam_izin.

  ENDLOOP.

  gv_string_1 = |{ gv_string_1 }| & | | & |izin kaydi yaptirmistir.|.

  MESSAGE gv_string_1 TYPE 'I'.
