*&---------------------------------------------------------------------*
*& Report ZCM_TEST_180
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_180.

DATA: gv_text TYPE string VALUE 'Comparison Operatörleri'.

IF gv_text CP 'COM*'.
  WRITE: 'gv_text degiskeni "COM" texti ile baslamaktadir.'.
ENDIF.

IF gv_text CP '*leri'.
  WRITE: / 'gv_text degiskeni "leri" texti ile bitmektedir.'.
ENDIF.
