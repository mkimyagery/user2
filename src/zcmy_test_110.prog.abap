*&---------------------------------------------------------------------*
*& Report ZCM_TEST_110
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_110.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_carrid  TYPE s_carr_id,
              p_scarr   RADIOBUTTON GROUP abc,
              p_spfli   RADIOBUTTON GROUP abc,
              p_sflght RADIOBUTTON GROUP abc,
              p_all     RADIOBUTTON GROUP abc.
SELECTION-SCREEN END OF BLOCK a1.

DATA: gt_scarr   TYPE TABLE OF scarr,
      gt_spfli   TYPE TABLE OF spfli,
      gt_sflight TYPE TABLE OF sflight.

START-OF-SELECTION.

  IF p_scarr IS NOT INITIAL.

    zflight_data_cm=>get_scarr(
      EXPORTING
        iv_carrid = p_carrid
      IMPORTING
        et_scarr  = gt_scarr ).

  ELSEIF p_spfli IS NOT INITIAL.

    zflight_data_cm=>get_spfli(
      EXPORTING
        iv_carrid = p_carrid
      IMPORTING
        et_spfli  = gt_spfli ).

  ELSEIF p_sflght IS NOT INITIAL.

    zflight_data_cm=>get_sflight(
      EXPORTING
        iv_carrid  = p_carrid
      IMPORTING
        et_sflight = gt_sflight ).

  ELSEIF p_all IS NOT INITIAL.

    zflight_data_cm=>get_all(
      EXPORTING
        iv_carrid  = p_carrid
      importing
        et_scarr   = gt_scarr
        et_spfli   = gt_spfli
        et_sflight = gt_sflight ).
  ENDIF.BREAK-POINT.

"""Devaminda ekrana yazdirma veya ALV alma islemi yapabilirsiniz.
