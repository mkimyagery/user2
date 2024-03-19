*&---------------------------------------------------------------------*
*& Report ZCM_TEST_216
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_216.

DATA: gv_no     TYPE i,
      gv_return TYPE nrreturn.

DO 100 TIMES.

  CALL FUNCTION 'NUMBER_GET_NEXT'
    EXPORTING
      nr_range_nr             = '03'
      object                  = 'ZCM_NR_001'
    IMPORTING
      number                  = gv_no
      returncode              = gv_return
    EXCEPTIONS
      interval_not_found      = 1
      number_range_not_intern = 2
      object_not_found        = 3
      quantity_is_0           = 4
      quantity_is_not_1       = 5
      interval_overflow       = 6
      buffer_overflow         = 7
      OTHERS                  = 8.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

  BREAK-POINT.

ENDDO.
