*&---------------------------------------------------------------------*
*& Report ZCM_TEST_68
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_69.


DATA: gs_spfli TYPE zcm_spfli,
      gt_spfli TYPE TABLE OF zcm_spfli.

START-OF-SELECTION.

  SELECT * FROM spfli INTO TABLE gt_spfli.

  LOOP AT gt_spfli INTO gs_spfli.

    INSERT zcm_spfli FROM gs_spfli.

  ENDLOOP.
