*&---------------------------------------------------------------------*
*& Report ZCM_TEST_296
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_297.

PARAMETERS: p_yil TYPE c LENGTH 4,
            p_id  TYPE zcm_de_id.

DATA: gv_no TYPE i.

START-OF-SELECTION.

  SELECT * FROM zcm_tablo_2 INTO TABLE @DATA(gt_tablo_2).

  "Abap 7.40 öncesi:
  LOOP AT gt_tablo_2  INTO DATA(gs_tablo_2) WHERE id = p_id AND yil = p_yil.
    gv_no = gv_no + gs_tablo_2-kul_izin.
  ENDLOOP.

  "Abap 7.40 sonrasi:
  DATA(gv_number) = REDUCE i( INIT x = 0
                              FOR gs_str
                              IN gt_tablo_2
                              WHERE ( id = p_id AND yil = p_yil )
                              NEXT x = x + gs_str-kul_izin ).

  BREAK-POINT.
