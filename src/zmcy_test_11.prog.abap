*&---------------------------------------------------------------------*
*& Report ZMC_TEST_11
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmcy_test_11.

PARAMETERS: p_number TYPE n LENGTH 3.

IF p_number < 100.

  MESSAGE TEXT-001 TYPE 'I'.

ELSEIF p_number = 100.

  MESSAGE TEXT-002 TYPE 'I'.

ELSEIF p_number > 100.

  MESSAGE TEXT-003 TYPE 'I'.

ENDIF.
