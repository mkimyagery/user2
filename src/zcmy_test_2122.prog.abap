*&---------------------------------------------------------------------*
*& Report ZCM_TEST_2122
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_2122.



*DATA: gv_no         TYPE i,
*      gv_returncode TYPE nrreturn.
*
*DO.
*  CALL FUNCTION 'NUMBER_GET_NEXT'
*    EXPORTING
*      nr_range_nr             = '01'
*      object                  = 'ZCM_TEST5'
**     QUANTITY                = '1'
**     SUBOBJECT               = ' '
**     TOYEAR                  = '0000'
**     IGNORE_BUFFER           = ' '
*    IMPORTING
*      number                  = gv_no
**     QUANTITY                =
*      returncode              = gv_returncode
*    EXCEPTIONS
*      interval_not_found      = 1
*      number_range_not_intern = 2
*      object_not_found        = 3
*      quantity_is_0           = 4
*      quantity_is_not_1       = 5
*      interval_overflow       = 6
*      buffer_overflow         = 7
*      OTHERS                  = 8.
*  IF sy-subrc <> 0.
** Implement suitable error handling here
*  ENDIF.
*ENDDO.


DATA: gv_1 TYPE i,
      gv_res TYPE i.

PARAMETERS: p_1 TYPE i,
            p_2 TYPE i.



INITIALIZATION.

  gv_1 = gv_1 + 1.
*  BREAK-POINT.

START-OF-SELECTION.


gv_res = p_1 + p_2.

MESSAGE e001(Z_VALIDATION) DISPLAY LIKE 'E'.

  BREAK-POINT.
