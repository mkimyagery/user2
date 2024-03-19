*&---------------------------------------------------------------------*
*& Report ZCM_TEST_296
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_296.

DATA: gv_no TYPE i.

START-OF-SELECTION.

  SELECT * FROM zcm_stravelag INTO TABLE @DATA(gt_stravelag).

  "Abap 7.40 öncesi:
  LOOP AT gt_stravelag  INTO DATA(gs_stravelag) WHERE country = 'DE'.
    gv_no = gv_no + 1.
  ENDLOOP.

  "Abap 7.40 sonrasi:
  DATA(gv_number) = REDUCE i( INIT x = 0
                              FOR gs_str
                              IN gt_stravelag
                              WHERE ( country = 'DE' )
                              NEXT x = x + 1 ).

  BREAK-POINT.
