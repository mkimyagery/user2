*&---------------------------------------------------------------------*
*& Report ZCM_TEST_183
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_183.
*https://abapblog.com/articles/for-beginners/42-selection-screen-part1-parameters
SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 1(5) TEXT-002. "Saat:
    SELECTION-SCREEN POSITION 6.
    PARAMETERS: p_hour TYPE int2.

    SELECTION-SCREEN COMMENT 15(7) TEXT-003. "Dakika:
    SELECTION-SCREEN POSITION 22.
    PARAMETERS: p_mins TYPE int2.

    SELECTION-SCREEN COMMENT 31(7) TEXT-004. "Saniye:
    SELECTION-SCREEN POSITION 38.
    PARAMETERS: p_scnd TYPE int2.

  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK a1.

SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME TITLE TEXT-005 NO INTERVALS.
  PARAMETERS: p_rslt TYPE i.
SELECTION-SCREEN END OF BLOCK a2.

AT SELECTION-SCREEN OUTPUT.

  CLEAR: p_rslt.

  IF p_hour > 0.
    p_rslt = p_hour * 3600.
  ENDIF.

  IF p_mins > 0.
    p_rslt = p_rslt + ( p_mins * 60 ).
  ENDIF.

  IF p_scnd > 0.
    p_rslt = p_rslt + p_scnd.
  ENDIF.

  LOOP AT SCREEN.
    IF p_rslt IS INITIAL.
      IF screen-name = 'P_RSLT' OR screen-name = '%_P_RSLT_%_APP_%-TEXT'.
        screen-active = '0'.
        MODIFY SCREEN.
      ENDIF.
    ELSE.
      IF screen-name = 'P_RSLT'.
        screen-input = '0'.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
  ENDLOOP.
