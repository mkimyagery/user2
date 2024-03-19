*&---------------------------------------------------------------------*
*& Report ZCM_TEST_138
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_138.

PARAMETERS: p_carrid TYPE s_carr_id,
            p_scarr  RADIOBUTTON GROUP abc,
            p_spfli  RADIOBUTTON GROUP abc,
            p_sflght RADIOBUTTON GROUP abc,
            p_hepsi  RADIOBUTTON GROUP abc.

DATA: gt_scarr   TYPE TABLE OF scarr,
      gt_spfli   TYPE TABLE OF spfli,
      gt_sflight TYPE TABLE OF sflight.

START-OF-SELECTION.

  IF p_scarr IS NOT INITIAL.
    zflight_data_select=>get_scarr(
      EXPORTING
        iv_carrid = p_carrid
      IMPORTING
        et_scarr  = gt_scarr ).

  ELSEIF p_spfli IS NOT INITIAL.

    zflight_data_select=>get_spfli(
      EXPORTING
        iv_carrid = p_carrid
      IMPORTING
        et_spfli  = gt_spfli ).

  ELSEIF p_sflght IS NOT INITIAL.

    zflight_data_select=>get_sflight(
      EXPORTING
        iv_carrid  = p_carrid
      IMPORTING
        et_sflight = gt_sflight ).

  ELSEIF p_hepsi IS NOT INITIAL.

    zflight_data_select=>get_all(
      EXPORTING
        iv_carrid  = p_carrid
      IMPORTING
        et_scarr   = gt_scarr
        et_spfli   = gt_spfli
        et_sflight = gt_sflight ).
  ENDIF.


  BREAK-POINT.
