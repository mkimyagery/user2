*&---------------------------------------------------------------------*
*& Report ZCM_TEST_06
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_06.

DATA: gv_int_01   TYPE i,
      gv_int_02   TYPE i,
      gv_result   TYPE i,
      gv_num_p    TYPE p DECIMALS 6,
      gv_num_p_02 TYPE p DECIMALS 3.

gv_int_01 = 12347.
gv_int_02 = 3.

gv_result = gv_int_01 / gv_int_02.

gv_num_p = gv_int_01 / gv_int_02.

gv_num_p_02 = gv_int_01 / gv_int_02.

WRITE: gv_result, / gv_num_p, / gv_num_p_02.
