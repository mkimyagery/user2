*&---------------------------------------------------------------------*
*& Report ZCM_TEST_060
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_060.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_num_01 TYPE i,
              p_num_02 TYPE i.
SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  PERFORM sum.

FORM sum.
  DATA: lv_result TYPE i.
  lv_result = p_num_01 + p_num_02.
  WRITE: lv_result.
ENDFORM.
