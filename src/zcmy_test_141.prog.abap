*&---------------------------------------------------------------------*
*& Report ZCM_TEST_141
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_141.

PARAMETERS: p_scarr  RADIOBUTTON GROUP abc,
            p_spfli  RADIOBUTTON GROUP abc,
            p_sflght RADIOBUTTON GROUP abc.

START-OF-SELECTION.

  IF p_scarr IS NOT INITIAL.

    zflight_data_modeling_static_2=>show_alv_scarr( ).

  ELSEIF p_spfli IS NOT INITIAL.

    zflight_data_modeling_static_2=>show_alv_spfli( ).

  ELSE.

    zflight_data_modeling_static_2=>show_alv_sflight( ).

  ENDIF.
