*&---------------------------------------------------------------------*
*& Report ZCM_TEST_077
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_077.


DATA: gv_num1 TYPE i,
      gv_num2 TYPE i.

START-OF-SELECTION.

  gv_num1 = 2.
  gv_num1 = 4.

  PERFORM sum.

FORM sum.
  DATA: lv_sum TYPE i.

  lv_sum = gv_num1 + gv_num2.

  PERFORM write USING lv_sum.
ENDFORM.

FORM write  USING p_lv_sum.
  WRITE: TEXT-001, p_lv_sum.
ENDFORM.
