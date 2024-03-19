*&---------------------------------------------------------------------*
*& Report ZCM_TEST_129
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_134.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.

  PARAMETERS: p_scarr  RADIOBUTTON GROUP abc,
              p_spfli  RADIOBUTTON GROUP abc,
              p_sflght RADIOBUTTON GROUP abc.

SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  IF p_scarr IS NOT INITIAL.
    zflight_data_modeling_static=>show_alv_scarr( ).
  ENDIF.

  IF p_spfli IS NOT INITIAL.
    zflight_data_modeling_static=>show_alv_spfli( ).
  ENDIF.

  IF p_sflght IS NOT INITIAL.
    zflight_data_modeling_static=>show_alv_sflight( ).
  ENDIF.
