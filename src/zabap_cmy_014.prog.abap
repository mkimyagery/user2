*&---------------------------------------------------------------------*
*& Report ZABAP_CM_013
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_cmy_014.

PARAMETERS: p_number TYPE i,
            p_2      RADIOBUTTON GROUP abc,
            p_3      RADIOBUTTON GROUP abc.

DATA: gv_number TYPE i.

START-OF-SELECTION.

  IF p_2 = abap_true.

    zcmtest_001_static=>method_1(
      EXPORTING
        iv_number   = p_number
        iv_rdbutton = '2'
      IMPORTING
        ev_number   = gv_number ).

  ELSE.

    zcmtest_001_static=>method_1(
      EXPORTING
        iv_number   = p_number
        iv_rdbutton = '3'
      IMPORTING
        ev_number   = gv_number ).
  ENDIF.

  WRITE: gv_number.
