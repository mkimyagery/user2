*&---------------------------------------------------------------------*
*& Report ZCM_TEST_286
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_286.

DATA: gt_sflight TYPE TABLE OF sflight,
      gs_sflight TYPE sflight.

FIELD-SYMBOLS: <fs_sflight> TYPE zcm_tt_sflight2,
               <fs_str>     TYPE sflight.

START-OF-SELECTION.

  SELECT * FROM sflight INTO TABLE gt_sflight.

  ASSIGN gt_sflight TO <fs_sflight>.

  LOOP AT <fs_sflight> INTO gs_sflight.

    WRITE: gs_sflight-carrid, gs_sflight-connid, gs_sflight-fldate.
    SKIP.
  ENDLOOP.

  LOOP AT <fs_sflight> ASSIGNING <fs_str>.

    WRITE: <fs_str>-carrid, <fs_str>-connid, <fs_str>-fldate.
    SKIP.
  ENDLOOP.
