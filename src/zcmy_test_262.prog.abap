*&---------------------------------------------------------------------*
*& Report ZCM_TEST_262
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_262.

DATA: gt_scarr TYPE TABLE OF scarr.

FIELD-SYMBOLS: <fs_scarr> TYPE scarr.

START-OF-SELECTION.

SELECT * FROM scarr INTO TABLE gt_scarr.

  LOOP AT gt_scarr ASSIGNING <fs_scarr>.

    IF <fs_scarr>-currcode = 'USD'.
      <fs_scarr>-currcode = 'EUR'.
    ELSEIF <fs_scarr>-currcode = 'EUR'.
      <fs_scarr>-currcode = 'USD'.
    ENDIF.

  ENDLOOP.

  BREAK-POINT.
