*&---------------------------------------------------------------------*
*& Report ZCM_TEST_307
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_307.

START-OF-SELECTION.

  SELECT * FROM stravelag INTO TABLE @DATA(gt_table).

  "Abap 7.40 öncesi:
  READ TABLE gt_table INTO DATA(gs_table) INDEX 100.
  IF sy-subrc IS INITIAL.
    WRITE: gs_table-agencynum.
  ENDIF.

  "Abap 7.40 sonrasi:
  TRY.
      DATA(gs_str) = gt_table[ 500 ].
    CATCH cx_sy_itab_line_not_found.
      MESSAGE 'Girilen index numarasi bulunmamaktadir' TYPE 'S' DISPLAY LIKE 'E'.
  ENDTRY.

  DESCRIBE TABLE gt_table LINES DATA(gv_no_lines).

  IF gv_no_lines >= 5 .
    DATA(gs_str_2) = gt_table[ 5 ].
  ENDIF.
