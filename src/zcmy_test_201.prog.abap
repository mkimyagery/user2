*&---------------------------------------------------------------------*
*& Report ZCM_TEST_201
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_201.

PARAMETERS: p_name TYPE c LENGTH 30.

DATA: gv_letter,
      gv_number TYPE i.


DATA(gv_no) = strlen( p_name ).

DO gv_no TIMES.
  gv_letter = p_name+gv_number(1).

  IF gv_letter IS INITIAL.
    SKIP.
  ELSE.
    WRITE: / gv_letter.
  ENDIF.

  gv_number = gv_number + 1.

ENDDO.


SKIP.

CLEAR: gv_number.

 gv_number = strlen( p_name ) - 1.

DO gv_no TIMES.

  gv_letter = p_name+gv_number(1).

  IF gv_letter IS INITIAL.
WRITE: gv_letter .
  ELSE.
    WRITE: gv_letter  NO-GAP.
  ENDIF.

  gv_number = gv_number - 1.

ENDDO.
