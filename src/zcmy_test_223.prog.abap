*&---------------------------------------------------------------------*
*& Report ZCM_TEST_223
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_223.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS: p_basari RADIOBUTTON GROUP abc,
              p_hata   RADIOBUTTON GROUP abc,
              p_uyari  RADIOBUTTON GROUP abc,
              p_bilgi  RADIOBUTTON GROUP abc.
SELECTION-SCREEN END OF BLOCK a1.

DATA: go_msg_types_cm TYPE REF TO zmessage_types_cm.

START-OF-SELECTION.

  CREATE OBJECT go_msg_types_cm.

  go_msg_types_cm->show_message(
    EXPORTING
      iv_success     = p_basari
      iv_error       = p_hata
      iv_warning     = p_uyari
      iv_information = p_bilgi ).
