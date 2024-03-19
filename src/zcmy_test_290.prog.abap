*&---------------------------------------------------------------------*
*& Report ZCM_TEST_290
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_290.

PARAMETERS: p_tb1 RADIOBUTTON GROUP abc,
            p_tb2 RADIOBUTTON GROUP abc.

DATA: gt_table_1 TYPE TABLE OF zcm_tablo_1,
      gt_table_2 TYPE TABLE OF zcm_tablo_2,
      gv_tabname TYPE tabname.

FIELD-SYMBOLS: <fs_table> TYPE ANY TABLE.

START-OF-SELECTION.

  IF p_tb1 = abap_true.
    ASSIGN gt_table_1 TO <fs_table>.
    gv_tabname = 'ZCM_TABLO_1'.
  ELSE.
    ASSIGN gt_table_2 TO <fs_table>.
    gv_tabname = 'ZCM_TABLO_2'.
  ENDIF.

  SELECT * FROM (gv_tabname) INTO TABLE <fs_table>.

  BREAK-POINT.
