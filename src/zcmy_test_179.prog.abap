*&---------------------------------------------------------------------*
*& Report ZCM_TEST_179
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_179.

DATA: gv_text TYPE string VALUE 'Abap programlama dili ögreniyorum.'.

IF gv_text NS 'SAP'.
  WRITE: '"SAP" texti gv_text degiskeni icerisinde yer almamaktadir.'.
ENDIF.
