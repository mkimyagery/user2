*&---------------------------------------------------------------------*
*& Report ZCM_TEST_276
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_276.

START-OF-SELECTION.

  SELECT * FROM zcm_stravelag INTO TABLE @DATA(gt_table).

  "Abap 7.40 öncesi.
  READ TABLE gt_table TRANSPORTING NO FIELDS WITH KEY agencynum = '00000061' name = 'Fly High'.
  IF sy-subrc IS INITIAL.
    DATA(gv_index_1) = sy-tabix.
  ENDIF.

  "Abap 7.40 ile birlikte.
  DATA(gv_index_2) = line_index( gt_table[ agencynum = '00000061' name = 'Fly High' ] ).

  BREAK-POINT.
