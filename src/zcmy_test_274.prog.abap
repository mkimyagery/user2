*&---------------------------------------------------------------------*
*& Report ZCM_TEST_274
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_274.

DATA: gv_index TYPE i.

START-OF-SELECTION.
  SELECT * FROM zcm_stravelag INTO TABLE @DATA(gt_table).

  "Abap 7.40 öncesi.
  READ TABLE gt_table INTO DATA(gs_str_1) INDEX 5.
  IF sy-subrc IS INITIAL.
    WRITE: gs_str_1-agencynum, gs_str_1-name.
  ENDIF.

  "Abap 7.40 ile birlikte.
  TRY.
      DATA(gs_str_2) = gt_table[ 5 ].
    CATCH cx_sy_itab_line_not_found.
      BREAK-POINT.
  ENDTRY.

  IF gs_str_2 IS NOT INITIAL.
    WRITE: / gs_str_2-agencynum, gs_str_2-name.
  ENDIF.

  "Ya da,
  DESCRIBE TABLE gt_table LINES DATA(gv_no_lines).
  gv_index = 5.

  IF gv_index <= gv_no_lines.
    DATA(gs_str_3) = gt_table[ 5 ].
    WRITE: / gs_str_3-agencynum, gs_str_3-name.
  ENDIF.
