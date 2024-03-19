*&---------------------------------------------------------------------*
*& Report ZMC_TEST_FOR_DEBUG
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmcy_test_for_debug.

*SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE text-00

PARAMETERS: p_num_1 TYPE i,
            p_num_2 TYPE i,
            p_trnsc TYPE c LENGTH 1.

DATA: gv_result        TYPE p DECIMALS 2,
      gv_result_string TYPE string,
      gv_msg           TYPE string.

BREAK-POINT.

IF p_trnsc = '+'.
  gv_result = p_num_1 + p_num_2.
ELSEIF p_trnsc = '*'.
  gv_result = p_num_1 / p_num_2.
ELSEIF p_trnsc = '/'.
  gv_result = p_num_1 * p_num_2.
ELSEIF p_trnsc = '-'.
  gv_result = p_num_1 - p_num_2.
ELSE.
  MESSAGE TEXT-001 TYPE 'S' DISPLAY LIKE 'E'.
ENDIF.

gv_result_string = gv_result.

CONCATENATE TEXT-002 gv_result_string INTO gv_msg SEPARATED BY space.

MESSAGE gv_msg TYPE 'S'.
