*&---------------------------------------------------------------------*
*& Report ZCM_TEST_199
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_199.

TYPES: BEGIN OF gty_tablo,
         id             TYPE zcm_de_id,
         ad             TYPE zcm_de_info_ad,
         soyad          TYPE zcm_de_info_sad,
         izin_baslangic TYPE datum,
         izin_bitis     TYPE datum,
       END OF gty_tablo.

DATA: gt_tablo_1   TYPE TABLE OF zcm_tablo_1,
      gt_tablo_2   TYPE TABLE OF zcm_tablo_2,
      gs_tablo_1   TYPE zcm_tablo_1,
      gs_tablo_2   TYPE zcm_tablo_2,
      gt_tablo_son TYPE TABLE OF  gty_tablo,
      gs_tablo_son TYPE gty_tablo.

START-OF-SELECTION.

  SELECT * FROM zcm_tablo_1
    INTO TABLE gt_tablo_1.

  SELECT * FROM zcm_tablo_2
    INTO TABLE gt_tablo_2.

  LOOP AT gt_tablo_1 INTO gs_tablo_1.

    gs_tablo_son-id = gs_tablo_1-id.
    gs_tablo_son-ad = gs_tablo_1-ad.
    gs_tablo_son-soyad = gs_tablo_1-soyad.

    LOOP AT gt_tablo_2 INTO gs_tablo_2 WHERE id = gs_tablo_1-id.

      gs_tablo_son-izin_baslangic = gs_tablo_2-izin_baslangic.
      gs_tablo_son-izin_bitis = gs_tablo_2-izin_bitis.

      APPEND gs_tablo_son TO gt_tablo_son.

    ENDLOOP.

    CLEAR: gs_tablo_son.
  ENDLOOP.

  BREAK-POINT.
