*&---------------------------------------------------------------------*
*& Report ZCM_TEST_129
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_129.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.

  PARAMETERS: p_scarr RADIOBUTTON GROUP abc,
              p_spfli RADIOBUTTON GROUP abc,
              p_sflght RADIOBUTTON GROUP abc.

SELECTION-SCREEN END OF BLOCK a1.

DATA: go_flight_data_modeling TYPE REF TO zflight_data_modeling.

START-OF-SELECTION.

CREATE OBJECT go_flight_data_modeling
  EXPORTING
    iv_scarr   = p_scarr
    iv_spfli   = p_spfli
    iv_sflight = p_sflght.

IF p_scarr IS NOT INITIAL.
  go_flight_data_modeling->show_alv_scarr( ).
ENDIF.

IF p_spfli IS NOT INITIAL.
  go_flight_data_modeling->show_alv_spfli( ).
ENDIF.

IF p_sflght IS NOT INITIAL.
  go_flight_data_modeling->show_alv_sflight( ).
ENDIF.
