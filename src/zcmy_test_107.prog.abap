*&---------------------------------------------------------------------*
*& Report ZCM_TEST_107
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_107.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_num_01 TYPE i,
              p_num_02 TYPE i,
              p_sembol TYPE c LENGTH 1.
SELECTION-SCREEN END OF BLOCK a1.

DATA: go_calculator TYPE REF TO zcalculator_cm_02,
      gv_sonuc      TYPE i.

START-OF-SELECTION.

  CREATE OBJECT go_calculator.

  go_calculator->hesapla(
    EXPORTING
      iv_num_01           = p_num_01
      iv_num_02           = p_num_02
      iv_sembol           = p_sembol
    IMPORTING
      ev_sonuc            = gv_sonuc
    EXCEPTIONS
      gecersiz_islem_kodu = 1
      OTHERS              = 2 ).

  IF sy-subrc = 1.
    MESSAGE text-002 TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  WRITE: gv_sonuc.
