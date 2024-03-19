*&---------------------------------------------------------------------*
*& Report ZCM_TEST_300
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_301.

PARAMETERS: p_id_1 TYPE zcm_de_id,
            p_id_2 TYPE zcm_de_id.

TYPES: BEGIN OF gty_table,
         id       TYPE zcm_de_id,
         yil      TYPE c LENGTH 4,
         kul_izin TYPE int1,
       END OF gty_table.

DATA: gt_izin      TYPE TABLE OF gty_table,
      gt_izin_yeni TYPE TABLE OF gty_table,
      gt_tablo_2   TYPE TABLE OF zcm_tablo_2.

START-OF-SELECTION.

  SELECT * FROM zcm_tablo_2 INTO TABLE gt_tablo_2 WHERE id = p_id_1.

  "Abap 7.40 öncesi:
  MOVE-CORRESPONDING gt_tablo_2 TO gt_izin.

  "Abap 7.40 sonrasi:
  gt_izin_yeni = CORRESPONDING #( gt_tablo_2 ).

  SELECT * FROM zcm_tablo_2 INTO TABLE gt_tablo_2 WHERE id = p_id_2.

  "Abap 7.40 öncesi:
  MOVE-CORRESPONDING gt_tablo_2 TO gt_izin KEEPING TARGET LINES.

  "Abap 7.40 sonrasi:
  gt_izin_yeni = CORRESPONDING #( BASE ( gt_izin_yeni ) gt_tablo_2 ).

  BREAK-POINT.
