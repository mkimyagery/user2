*&---------------------------------------------------------------------*
*& Report ZCM_TEST_07
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_07.

DATA: gv_string TYPE string,
      gv_char TYPE c LENGTH 5.



gv_string = 'RRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRRR'.

WRITE: / gv_string.
