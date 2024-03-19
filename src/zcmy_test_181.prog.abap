*&---------------------------------------------------------------------*
*& Report ZCM_TEST_181
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_181.

DATA: gv_text TYPE string VALUE 'euroTech Study'.

IF gv_text NP 'TR*'.
  WRITE: 'gv_text degiskeni "TR" texti ile baslamamaktadir.'.
ENDIF.

IF gv_text NP '*DE'.
  WRITE: / 'gv_text degiskeni "DE" texti ile bitmemektedir.'.
ENDIF.
