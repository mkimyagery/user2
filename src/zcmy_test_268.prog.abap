*&---------------------------------------------------------------------*
*& Report ZCM_TEST_268
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_268.

PARAMETERS: p_1 RADIOBUTTON GROUP abc,
            p_2 RADIOBUTTON GROUP abc.

DATA: gt_scarr TYPE TABLE OF scarr,
      gt_spfli TYPE TABLE OF scarr.

FIELD-SYMBOLS: <fs_table> TYPE ANY TABLE.

START-OF-SELECTION.

  IF p_1 IS NOT INITIAL.
    ASSIGN gt_scarr TO <fs_table>.
    SELECT * FROM scarr INTO TABLE <fs_table>.
  ELSE.
    ASSIGN gt_spfli TO <fs_table>.
    SELECT * FROM scarr INTO TABLE <fs_table>.
  ENDIF.


  BREAK-POINT.
