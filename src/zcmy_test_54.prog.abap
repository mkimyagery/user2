*&---------------------------------------------------------------------*
*& Report ZCM_TEST_54
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_54.

DATA: gv_carr_id TYPE s_carr_id,
      gs_scarr   TYPE scarr,
      gt_scarr   TYPE TABLE OF scarr.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.

  SELECT-OPTIONS: so_carr FOR gv_carr_id.

SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  SELECT * FROM scarr INTO TABLE gt_scarr WHERE carrid IN so_carr.

  LOOP AT gt_scarr INTO gs_scarr.
    WRITE: gs_scarr-carrid, gs_scarr-carrname, gs_scarr-currcode, gs_scarr-url.
    CLEAR: gs_scarr.
    SKIP.
  ENDLOOP.
