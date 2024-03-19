*&---------------------------------------------------------------------*
*& Report ZCM_TEST_300
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_300.

TYPES: BEGIN OF gty_table,
         id       TYPE zcm_de_id,
         yil      TYPE c LENGTH 4,
         kul_izin TYPE int1,
       END OF gty_table.

DATA: gs_izin      TYPE gty_table,
      gs_izin_yeni TYPE gty_table,
      gs_tablo_2   TYPE zcm_tablo_2,
      gt_tablo_2   TYPE TABLE OF zcm_tablo_2.

START-OF-SELECTION.

  SELECT * FROM zcm_tablo_2 INTO TABLE gt_tablo_2.

  "Abap 7.40 öncesi:
  LOOP AT gt_tablo_2 INTO gs_tablo_2.
    MOVE-CORRESPONDING gs_tablo_2 TO gs_izin.
  ENDLOOP.

  "Abap 7.40 sonrasi:
  LOOP AT gt_tablo_2 INTO gs_tablo_2.
    gs_izin_yeni = CORRESPONDING #( gs_tablo_2 ).
  ENDLOOP.
