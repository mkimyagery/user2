*&---------------------------------------------------------------------*
*& Report ZCM_TEST_235
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_235.

DATA: gt_scarr TYPE TABLE OF scarr.

FIELD-SYMBOLS: <gs_scarr> TYPE scarr.

START-OF-SELECTION.

  SELECT * FROM scarr INTO TABLE gt_scarr.

  LOOP AT gt_scarr ASSIGNING <gs_scarr>.

    IF <gs_scarr>-currcode = 'EUR'.

      <gs_scarr>-currcode = 'USD'.

    ELSEIF <gs_scarr>-currcode = 'USD'.

      <gs_scarr>-currcode = 'EUR'.

    ENDIF.

  ENDLOOP.

  SORT gt_scarr BY carrid.

  BREAK-POINT.
