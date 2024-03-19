*&---------------------------------------------------------------------*
*& Report ZCM_TEST_309
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_309.

START-OF-SELECTION.

  SELECT * FROM stravelag INTO TABLE @DATA(gt_table).

"7.40 öncesi:
  READ TABLE gt_table INTO DATA(gs_str) WITH KEY agencynum = '00000061' name = 'Fly High'.
  IF sy-subrc IS INITIAL.
    BREAK-POINT.
  ENDIF.

"7.40 sonrasi:
  DATA(gv_index) = line_index( gt_table[ agencynum = '00000061' name = 'Fly High' ] ).
  BREAK-POINT.
