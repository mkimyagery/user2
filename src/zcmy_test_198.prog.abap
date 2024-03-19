*&---------------------------------------------------------------------*
*& Report ZCM_TEST_198
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_198.

TABLES: sscrfields.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 1(5) TEXT-003 FOR FIELD p_saat.
    SELECTION-SCREEN POSITION 6.
    PARAMETERS: p_saat TYPE n LENGTH 5 AS LISTBOX VISIBLE LENGTH 5.

    SELECTION-SCREEN COMMENT 13(7) TEXT-004 FOR FIELD p_dakika.
    SELECTION-SCREEN POSITION 20.
    PARAMETERS: p_dakika TYPE n LENGTH 5 AS LISTBOX VISIBLE LENGTH 5.

    SELECTION-SCREEN COMMENT 27(7) TEXT-005 FOR FIELD p_saniye.
    SELECTION-SCREEN POSITION 34.
    PARAMETERS: p_saniye TYPE n LENGTH 5 AS LISTBOX VISIBLE LENGTH 5.

*    SELECTION-SCREEN COMMENT 41(7) text-006 for FIELD p_sonuc.
*    SELECTION-SCREEN POSITION 48.
*    PARAMETERS: p_sonuc TYPE n LENGTH 5.

    SELECTION-SCREEN PUSHBUTTON 43(49) btn1 USER-COMMAND hsp.

  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK a1.

SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME TITLE TEXT-002 NO INTERVALS.
  PARAMETERS: p_sonuc TYPE i.
SELECTION-SCREEN END OF BLOCK a2.

  DATA: gv_id     TYPE vrm_id,     "Tek hücreli degisken
        gt_values TYPE vrm_values, "Table type
        gs_value  TYPE vrm_value,
        gv_number TYPE i.

INITIALIZATION.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name                  = icon_calculation
      text                  = TEXT-007
      info                  = TEXT-008
    IMPORTING
      result                = btn1
    EXCEPTIONS
      icon_not_found        = 1
      outputfield_too_short = 2
      OTHERS                = 3.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

*  PERFORM dropdown_saat.
*  PERFORM dropdown_dakika.
*  PERFORM dropdown_saniye.

AT SELECTION-SCREEN OUTPUT.

*  CLEAR: p_sonuc.
*
*  IF p_saat IS NOT INITIAL.
*    p_sonuc = p_saat * 3600.
*  ENDIF.
*
*  IF p_dakika IS NOT INITIAL.
*    p_sonuc = p_sonuc + ( p_dakika * 60 ).
*  ENDIF.
*
*  IF p_saniye IS NOT INITIAL.
*    p_sonuc = p_sonuc + p_saniye.
*  ENDIF.

  LOOP AT SCREEN.
    IF p_sonuc IS INITIAL.
      IF screen-name = 'P_SONUC' OR screen-name = '%_P_SONUC_%_APP_%-TEXT'.
*      IF screen-name = 'P_SONUC' OR screen-name = '%F006011_1000'.
        screen-active = '0'.
        MODIFY SCREEN.
      ENDIF.
    ELSE.
      IF screen-name = 'P_SONUC'.
        screen-input = '0'.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
  ENDLOOP.

AT SELECTION-SCREEN.

  CLEAR: p_sonuc.

  CASE sscrfields-ucomm.
    WHEN 'HSP'.
      IF p_saat IS NOT INITIAL.
        p_sonuc = p_saat * 3600.
      ENDIF.

      IF p_dakika IS NOT INITIAL.
        p_sonuc = p_sonuc + ( p_dakika * 60 ).
      ENDIF.

      IF p_saniye IS NOT INITIAL.
        p_sonuc = p_sonuc + p_saniye.
      ENDIF.
  ENDCASE.

FORM dropdown_saat.

  CLEAR: gv_number, gs_value, gt_values.

  DO 23 TIMES.
    gv_number     = gv_number + 1.
    gs_value-key  = gv_number.
    gs_value-text = gv_number.

    APPEND gs_value TO gt_values.
    CLEAR: gs_value.
  ENDDO.

  gv_id = 'P_SAAT'.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id              = gv_id
      values          = gt_values
    EXCEPTIONS
      id_illegal_name = 1
      OTHERS          = 2.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.
ENDFORM.

FORM dropdown_dakika.

  CLEAR: gv_number, gs_value, gt_values.

  DO 59 TIMES.
    gv_number     = gv_number + 1.
    gs_value-key  = gv_number.
    gs_value-text = gv_number.

    APPEND gs_value TO gt_values.
    CLEAR: gs_value.
  ENDDO.

  gv_id = 'P_DAKIKA'.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id              = gv_id
      values          = gt_values
    EXCEPTIONS
      id_illegal_name = 1
      OTHERS          = 2.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.
ENDFORM.

FORM dropdown_saniye .

  CLEAR: gv_number, gs_value, gt_values.

  DO 59 TIMES.
    gv_number     = gv_number + 1.
    gs_value-key  = gv_number.
    gs_value-text = gv_number.

    APPEND gs_value TO gt_values.
    CLEAR: gs_value.
  ENDDO.

  gv_id = 'P_SANIYE'.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id              = gv_id
      values          = gt_values
    EXCEPTIONS
      id_illegal_name = 1
      OTHERS          = 2.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.
ENDFORM.
