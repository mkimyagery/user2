*&---------------------------------------------------------------------*
*& Report ZCM_TEST_275
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_275.

START-OF-SELECTION.

  SELECT * FROM zcm_stravelag INTO TABLE @DATA(gt_table).

  "Abap 7.40 öncesi.
  READ TABLE gt_table INTO DATA(gs_str_1) WITH KEY agencynum = '00000061' name = 'Fly High'.
  IF sy-subrc IS INITIAL.
    WRITE: gs_str_1-agencynum, gs_str_1-name.
  ENDIF.

  "Abap 7.40 ile birlikte.
  TRY.
      DATA(gs_str_2) = gt_table[ agencynum = '00000061' name = 'Fly High' ].
    CATCH cx_sy_itab_line_not_found.
      BREAK-POINT.
  ENDTRY.

  IF gs_str_2 IS NOT INITIAL.
    WRITE: / gs_str_2-agencynum, gs_str_2-name.
  ENDIF.
