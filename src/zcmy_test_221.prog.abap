*&---------------------------------------------------------------------*
*& Report ZCM_TEST_219
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_221 MESSAGE-ID zcm_msg_class_1.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS: p_basari RADIOBUTTON GROUP abc,
              p_hata   RADIOBUTTON GROUP abc,
              p_uyari  RADIOBUTTON GROUP abc,
              p_bilgi  RADIOBUTTON GROUP abc.
SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  IF p_basari = abap_true.

    MESSAGE s000.

  ELSEIF p_hata = abap_true.

    MESSAGE e000.

  ELSEIF p_uyari = abap_true.

    MESSAGE w000.

  ELSEIF p_bilgi = abap_true.

    MESSAGE i000.

  ENDIF.
