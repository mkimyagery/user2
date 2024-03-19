*&---------------------------------------------------------------------*
*& Report ZCM_TEST_177
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_177.

DATA: gv_text TYPE string VALUE 'Dolma Kalem'.

IF gv_text NA 'çığöşü'.
  WRITE: 'gv_text degiskeni Türkce karakter icermemektedir.'.
ENDIF.
