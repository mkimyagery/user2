*&---------------------------------------------------------------------*
*& Report ZCM_TEST_139
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_139.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_agnum TYPE s_agncynum OBLIGATORY,
              p_name  TYPE string LOWER CASE.

SELECTION-SCREEN END OF BLOCK a1.

DATA: gv_upd_ok TYPE c LENGTH 1.

START-OF-SELECTION.

*  zstravelag_update_name_2=>update_name(
*    EXPORTING
*      iv_agencynum = p_agnum
*      iv_name      = p_name
*    RECEIVING
*      rv_upd_ok    = gv_upd_ok ).


  CALL METHOD zstravelag_update_name_2=>update_name
    EXPORTING
      iv_agencynum = p_agnum
      iv_name      = p_name
    RECEIVING
      rv_upd_ok    = gv_upd_ok.

  IF gv_upd_ok IS NOT INITIAL.
    MESSAGE TEXT-002 TYPE 'S'.
  ENDIF.
