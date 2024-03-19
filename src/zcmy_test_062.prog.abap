*&---------------------------------------------------------------------*
*& Report ZCM_TEST_062
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_062.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS: p_num_01 TYPE i,
              p_num_02 TYPE i,
              p_topla  RADIOBUTTON GROUP abc,
              p_cikar  RADIOBUTTON GROUP abc,
              p_carp   RADIOBUTTON GROUP abc,
              p_bol    RADIOBUTTON GROUP abc.
SELECTION-SCREEN END OF BLOCK a1.

DATA: gv_kontrol_ok TYPE c LENGTH 1,
      gv_sonuc      TYPE p DECIMALS 2.

START-OF-SELECTION.

  PERFORM kontrol.

  IF gv_kontrol_ok = abap_true.
    IF p_topla = abap_true.
      PERFORM toplama.
    ELSEIF p_cikar = abap_true.
      PERFORM cikarma.
    ELSEIF p_carp = abap_true.
      PERFORM carpma.
    ELSEIF p_bol = abap_true.
      PERFORM bolme.
    ENDIF.

     WRITE: gv_sonuc.
  ELSE.
    MESSAGE TEXT-002 TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.

FORM kontrol.
  IF p_bol IS NOT INITIAL.
    IF p_num_02 NE 0.
      gv_kontrol_ok = abap_true.
    ENDIF.
  ENDIF.
ENDFORM.

FORM toplama.
  gv_sonuc = p_num_01 + p_num_02.
ENDFORM.

FORM cikarma.
  gv_sonuc = p_num_01 - p_num_02.
ENDFORM.

FORM carpma .
  gv_sonuc = p_num_01 * p_num_02.
ENDFORM.

FORM bolme .
  gv_sonuc = p_num_01 / p_num_02.
ENDFORM.
