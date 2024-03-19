*&---------------------------------------------------------------------*
*& Report ZCM_TEST_243
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_243.

DATA: gt_table TYPE zcm_tt_sfl.

START-OF-SELECTION.

  SELECT * FROM sflight
    INTO CORRESPONDING FIELDS OF TABLE gt_table.

    BREAK-POINT.
