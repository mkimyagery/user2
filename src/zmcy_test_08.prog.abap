*&---------------------------------------------------------------------*
*& Report ZMC_TEST_08
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMCY_TEST_08.


*MESSAGE 'jfh' TYPE 'W' DISPLAY LIKE 'I'.
*MESSAGE 'Warning' TYPE 'W'.
*
*BREAK-POINT.
*WRITE: 'Warningten sonra devam'.
MESSAGE 'Error' TYPE 'E'.

BREAK-POINT.

WRITE: 'errordan sonra devam'.
