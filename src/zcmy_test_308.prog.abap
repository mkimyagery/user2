*&---------------------------------------------------------------------*
*& Report ZCM_TEST_308
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_308.

START-OF-SELECTION.

  SELECT * FROM stravelag INTO TABLE @DATA(gt_table).

  "Abap 7.40 öncesi:
  READ TABLE gt_table INTO DATA(gs_table) WITH KEY agencynum = '00000061' name = 'Fly High'.
  IF sy-subrc IS INITIAL.
    WRITE: gs_table-agencynum.
  ENDIF.

"Abap 7.40 sonrasi:
  TRY.
    DATA(gs_str) = gt_table[ agencynum = '00000061' name = 'Fly High' ].
  CATCH cx_sy_itab_line_not_found.
    MESSAGE 'Satir bulunamadi' TYPE 'I'.
    EXIT.
  ENDTRY.

  WRITE: gs_str-city.
