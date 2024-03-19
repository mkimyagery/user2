*&---------------------------------------------------------------------*
*& Report ZCM_TEST_085
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_085.

DATA: gv_date TYPE sy-datum.

CALL FUNCTION 'ZMC_FM_0002'
  EXPORTING
    iv_no_days = 10
    iv_before  = abap_true
*   iv_after   =
  IMPORTING
    ev_date    = gv_date.




BREAK-POINT.
