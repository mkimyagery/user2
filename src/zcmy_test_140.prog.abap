*&---------------------------------------------------------------------*
*& Report ZCM_TEST_140
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_140.

PARAMETERS: p_scarr  RADIOBUTTON GROUP abc,
            p_spfli  RADIOBUTTON GROUP abc,
            p_sflght RADIOBUTTON GROUP abc.

DATA: go_fdm TYPE REF TO zflight_data_modeling_2.

START-OF-SELECTION.

  CREATE OBJECT go_fdm
    EXPORTING
      iv_scarr   = p_scarr
      iv_spfli   = p_spfli
      iv_sflight = p_sflght.

  IF p_scarr IS NOT INITIAL.

    go_fdm->show_alv_scarr( ).

  ELSEIF p_spfli IS NOT INITIAL.

    go_fdm->show_alv_spfli( ).

  ELSE.

    go_fdm->show_alv_sflight( ).

  ENDIF.
