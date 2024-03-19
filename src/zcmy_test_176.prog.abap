*&---------------------------------------------------------------------*
*& Report ZCM_TEST_176
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_176.

DATA: gv_text TYPE string VALUE 'Tükenmez Kalem'.

IF gv_text CA 'çığöşü'.
  WRITE: 'gv_text degiskeni Türkce karakter icermektedir.'.
ENDIF.
