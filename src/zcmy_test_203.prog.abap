*&---------------------------------------------------------------------*
*& Report ZCM_TEST_203
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_203.

PARAMETERS: p_email TYPE string.

DATA: gv_sol TYPE string,
      gv_sag TYPE string.

START-OF-SELECTION.


IF p_email NA '@'.
  BREAK-POINT.
ENDIF.

IF p_email CA 'çşığüö '.
  BREAK-POINT.
ENDIF.

SPLIT p_email AT '@' INTO gv_sol gv_sag.

IF gv_sol IS INITIAL.
  BREAK-POINT.
ELSE.
  IF gv_sol CA '@'.
    BREAK-POINT.
  ENDIF.
ENDIF.

IF gv_sag IS INITIAL.
  BREAK-POINT.
ELSE.
  IF gv_sag CA '@'.
    BREAK-POINT.
  ENDIF.
ENDIF.

IF p_email NP '*.com'.
  BREAK-POINT.
ENDIF.

WRITE: 'E-mail adresi gecerli.'.
