*&---------------------------------------------------------------------*
*& Report ZCM_TEST_249
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_249.

DATA: gt_scarr TYPE TABLE OF scarr.

START-OF-SELECTION.

  SELECT * FROM scarr INTO TABLE gt_scarr.

  LOOP AT gt_scarr INTO DATA(gs_scarr).

    WRITE: gs_scarr-carrid,   gs_scarr-carrname,
           gs_scarr-currcode, gs_scarr-url.

  ENDLOOP.
