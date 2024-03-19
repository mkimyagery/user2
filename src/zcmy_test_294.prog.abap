*&---------------------------------------------------------------------*
*& Report ZCM_TEST_293
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_294.

PARAMETERS: p_1     RADIOBUTTON GROUP bnm,
            p_2     RADIOBUTTON GROUP bnm,
            p_3     RADIOBUTTON GROUP bnm,
            p_index TYPE i.



START-OF-SELECTION.

  IF p_1 = abap_true.
    SELECT * FROM scarr INTO TABLE @DATA(gt_scarr).

    READ TABLE gt_scarr INTO DATA(gs_scarr) INDEX p_index.
    IF sy-subrc IS INITIAL.
      WRITE: gs_scarr-carrid, gs_scarr-carrname,
             gs_scarr-currcode, gs_scarr-url.
    ENDIF.

  ELSEIF p_2 = abap_true.

    SELECT * FROM spfli INTO TABLE @DATA(gt_spfli).

    READ TABLE gt_spfli INTO DATA(gs_spfli) INDEX p_index.
    IF sy-subrc IS INITIAL.
      WRITE: gs_spfli-carrid, gs_spfli-connid, gs_spfli-cityfrom.
    ENDIF.

  ELSE.

    SELECT * FROM sflight INTO TABLE @DATA(gt_sflight).

    READ TABLE gt_sflight INTO DATA(gs_sflight) INDEX p_index.
    IF sy-subrc IS INITIAL.
      WRITE: gs_sflight-carrid, gs_sflight-connid, gs_sflight-fldate.
    ENDIF.

  ENDIF.
