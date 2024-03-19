*&---------------------------------------------------------------------*
*& Report ZCM_TEST_1444
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_1444.

DATA: iv_number_01 TYPE i VALUE 10,
      iv_number_02 TYPE i VALUE 8.

DATA: lv_number TYPE i.

lv_number = iv_number_01.

DO ( iv_number_02 - 1 ) TIMES.
    lv_number = lv_number * iv_number_01.
ENDDO.
*lv_number = iv_number_01.

*DO iv_number_02 TIMES.
*  IF sy-index = 1.
*    lv_number = lv_number * lv_number.
*  ENDIF.
*ENDDO.

*DATA: num1   TYPE i VALUE 10,
*      num2   TYPE i VALUE 4,
*      result TYPE i,
*      total  TYPE i.
*
*DO num2 TIMES.
*  result = num1 * num1.
*  total = num1 * result.
*ENDDO.

BREAK-POINT.
