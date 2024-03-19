*&---------------------------------------------------------------------*
*& Report ZABAP_CM_022
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_cmy_0221.

TABLES: sscrfields.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001."NO INTERVALS.
  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 1(5) TEXT-002."Saat:
    SELECTION-SCREEN POSITION 6.
    PARAMETERS : p_hour TYPE i.

    SELECTION-SCREEN COMMENT 25(7) TEXT-003."Dakika:
    SELECTION-SCREEN POSITION 32.
    PARAMETERS : p_mins TYPE i.

    SELECTION-SCREEN COMMENT 47(7) TEXT-004."Saniye:
    SELECTION-SCREEN POSITION 54.
    PARAMETERS : p_scnd TYPE i.

    SELECTION-SCREEN PUSHBUTTON 70(56) bt1 USER-COMMAND hsp.

  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK a1.

SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME TITLE TEXT-005 NO INTERVALS.
  PARAMETERS : p_rslt TYPE i.
SELECTION-SCREEN END OF BLOCK a2.

INITIALIZATION. "Selection screen gösterilmeden
  "önce yapilacak tüm islemler.
  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = icon_calculation
      text   = TEXT-006
      info   = TEXT-007
    IMPORTING
      result = bt1
    EXCEPTIONS
      OTHERS = 0.

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.
    IF p_rslt IS INITIAL.
      IF screen-name = 'P_RSLT' OR screen-name = '%_P_RSLT_%_APP_%-TEXT' .
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
    ELSE.
      IF screen-name = 'P_RSLT'.
        screen-input = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.

  ENDLOOP.

AT SELECTION-SCREEN.

  CLEAR: p_rslt.

  CASE sscrfields-ucomm.
    WHEN 'HSP'.
      IF p_hour > 0.
        p_rslt = p_hour * 3600.
      ENDIF.

      IF p_mins > 0.
        p_rslt = p_rslt + ( p_mins * 60 ).
      ENDIF.

      IF p_scnd > 0.
        p_rslt = p_rslt + p_scnd.
      ENDIF.
  ENDCASE.
