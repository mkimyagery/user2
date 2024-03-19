*&---------------------------------------------------------------------*
*& Report ZCM_TEST_314
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_314.

PARAMETERS: p_id  TYPE zcm_de_id,
            p_yil TYPE c LENGTH 4.

START-OF-SELECTION.

SELECT * FROM zcm_tablo_2 INTO TABLE @DATA(gt_tablo_2).

  DATA(gv_number) = REDUCE i( INIT x = 0
                              FOR gs_str
                              IN gt_tablo_2
                              WHERE ( id = p_id AND yil = p_yil )
                              NEXT x = x + gs_str-kul_izin ).

  BREAK-POINT.
