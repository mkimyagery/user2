*&---------------------------------------------------------------------*
*& Report ZCM_TEST_315
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_3151.

*DATA: gt_stravelag TYPE SORTED TABLE OF zcm_stravelag WITH NON-UNIQUE KEY key1 COMPONENTS country.
DATA: gt_stravelag TYPE SORTED TABLE OF zcm_stravelag WITH NON-UNIQUE KEY primary_key COMPONENTS id.

START-OF-SELECTION.

  SELECT * FROM zcm_stravelag INTO TABLE gt_stravelag.

*  TRY.
*      DATA(gv_country) = gt_stravelag[ 10 ]-country.
*    CATCH cx_sy_itab_line_not_found.
*      MESSAGE 'Belirtilen satir bulunamadi' TYPE 'S' DISPLAY LIKE 'E'.
*      LEAVE PROGRAM.
*  ENDTRY.
*
*  DATA(gt_table) = FILTER zcm_tt_zcm_stravelag( gt_stravelag USING KEY   where country = gv_country ). "ZCM_TT_ZCM_STRAVELAG
*
*  BREAK-POINT.
