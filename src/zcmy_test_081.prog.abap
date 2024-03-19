*&---------------------------------------------------------------------*
*& Report ZCM_TEST_081
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_081.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_text_1 TYPE c LENGTH 40 LOWER CASE,
              p_text_2 TYPE c LENGTH 40 LOWER CASE.
SELECTION-SCREEN END OF BLOCK a1.

DATA: gv_text TYPE c LENGTH 80.

START-OF-SELECTION.

  CALL FUNCTION 'ZCM_FUNCTION_02'
    EXPORTING
      iv_text_01   = p_text_1
      iv_text_02   = p_text_2
      iv_uppercase = abap_true
    IMPORTING
      ev_text      = gv_text.

  WRITE: gv_text.
