*&---------------------------------------------------------------------*
*& Report ZABAP_CM_013
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_cmy_013.

PARAMETERS: p_number TYPE i,
            p_2 RADIOBUTTON GROUP abc,
            p_3 RADIOBUTTON GROUP abc.

DATA: go_test_001 TYPE REF TO zcmtest_001,
      gv_number TYPE i.

START-OF-SELECTION.

  CREATE OBJECT go_test_001.

  IF p_2 = abap_true.

      go_test_001->method_1(
    EXPORTING
      iv_number = p_number
      iv_rdbutton = '2'
    IMPORTING
      ev_number = gv_number ).

  ELSE.

      go_test_001->method_1(
    EXPORTING
      iv_number = p_number
      iv_rdbutton = '3'
    IMPORTING
      ev_number = gv_number ).
  ENDIF.

  WRITE: gv_number.
