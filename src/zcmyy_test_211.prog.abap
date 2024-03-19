*&---------------------------------------------------------------------*
*& Report ZCM_TEST_211
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmyy_test_211.

TYPES: BEGIN OF gty_table,
         id             TYPE zcm_de_id,
         ad             TYPE zcm_de_info_ad,
         soyad          TYPE zcm_de_info_sad,
         izin_baslangic TYPE datum,
         izin_bitis     TYPE datum,
       END OF gty_table.

DATA: gt_table_son TYPE TABLE OF gty_table.

START-OF-SELECTION.

  SELECT zcm_tablo_1~id, zcm_tablo_1~ad, zcm_tablo_1~soyad,
         zcm_tablo_2~izin_baslangic, zcm_tablo_2~izin_bitis
    INTO TABLE @gt_table_son
    FROM zcm_tablo_1
    INNER JOIN zcm_tablo_2
    ON zcm_tablo_1~id = zcm_tablo_2~id.

  SORT gt_table_son BY id.


    BREAK-POINT.
