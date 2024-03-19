*&---------------------------------------------------------------------*
*& Report ZCM_TEST_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_05.

*DATA: gv_number_01 TYPE n LENGTH 6,
*      gv_number_02 TYPE n LENGTH 2,
*      gv_result    TYPE n LENGTH 5,
*      gv_number_03 TYPE n LENGTH 8.
*
*
*gv_number_01 = '100000'.
*gv_number_02 = 50.
*gv_result = gv_number_01 / gv_number_02.
*
*
*gv_number_03 = '128'.
*
*
*WRITE: gv_number_01, / gv_number_02, / gv_result, / gv_number_03.
