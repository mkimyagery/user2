*&---------------------------------------------------------------------*
*& Report ZCM_TEST_250
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_250.

PARAMETERS: p_scarr  RADIOBUTTON GROUP abc,
            p_spfli  RADIOBUTTON GROUP abc,
            p_sflght RADIOBUTTON GROUP abc.

START-OF-SELECTION.

  IF p_scarr = abap_true.
    SELECT * FROM scarr INTO TABLE @DATA(gt_scarr).

    LOOP AT gt_scarr INTO DATA(gs_scarr).
      WRITE: gs_scarr-carrid,   gs_scarr-carrname,
             gs_scarr-currcode, gs_scarr-url.

      SKIP.
    ENDLOOP.
  ELSEIF p_spfli = abap_true.
    SELECT * FROM spfli INTO TABLE @DATA(gt_spfli).

    LOOP AT gt_spfli INTO DATA(gs_spfli).
      WRITE: gs_spfli-carrid,   gs_spfli-connid,
             gs_spfli-cityfrom, gs_spfli-cityto.

      SKIP.
    ENDLOOP.
  ELSEIF p_sflght = abap_true.
    SELECT * FROM sflight INTO TABLE @DATA(gt_sflight).

    LOOP AT gt_sflight INTO DATA(gs_sflight).
      WRITE: gs_sflight-carrid, gs_sflight-connid,
             gs_sflight-fldate, gs_sflight-planetype.

      SKIP.
    ENDLOOP.
  ENDIF.
