*&---------------------------------------------------------------------*
*& Report ZCM_TEST_178
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_178.

DATA: gv_text TYPE string VALUE 'Abap programlama dili ögreniyorum.'.

IF gv_text CS 'PRO'.
  WRITE: '"PRO" texti gv_text degiskeni icerisinde yer almaktadir.'.
ENDIF.
