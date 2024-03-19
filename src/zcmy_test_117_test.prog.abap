*&---------------------------------------------------------------------*
*& Report ZCM_TEST_117_TEST
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_117_test.

DATA: gv_e_mail TYPE c LENGTH 80,
      gv_answer TYPE c LENGTH 1.


CALL FUNCTION 'ZCM_POPUP_GET_E_MAIL'
  IMPORTING
    ev_e_mail = gv_e_mail
    ev_answer = gv_answer.

BREAK-POINT.
