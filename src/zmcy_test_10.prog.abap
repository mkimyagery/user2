*&---------------------------------------------------------------------*
*& Report ZMC_TEST_10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmcy_test_10.


PARAMETERS: p_num_1 TYPE i.

DATA: gv_counter TYPE n LENGTH 3,
      gv_msg     TYPE string.

IF p_num_1 >= 500.
  MESSAGE TEXT-001 TYPE 'S' DISPLAY LIKE 'E'.
ENDIF.

WHILE p_num_1 < 500.

  p_num_1 = p_num_1 + 10.

  gv_counter = gv_counter + 1.

ENDWHILE.

CONCATENATE TEXT-002 gv_counter TEXT-003 INTO gv_msg SEPARATED BY space.

MESSAGE gv_msg TYPE 'I'.
