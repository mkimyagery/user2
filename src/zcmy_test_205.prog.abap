*&---------------------------------------------------------------------*
*& Report ZCM_TEST_205
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_205.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.

PARAMETERS: p_1 TYPE datum,
            p_2 TYPE datum.

SELECTION-SCREEN END OF BLOCK a1.


SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME TITLE TEXT-005 NO INTERVALS.
  PARAMETERS: p_gun TYPE i,
              p_orta TYPE datum.
SELECTION-SCREEN END OF BLOCK a2.

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.
    IF p_gun IS INITIAL.
      IF screen-name = 'P_GUN' OR screen-name = '%_P_GUN_%_APP_%-TEXT'.
        screen-active = '0'.
        MODIFY SCREEN.
      ENDIF.
    ELSE.
      IF screen-name = 'P_GUN'.
        screen-input = '0'.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.

    IF p_orta IS INITIAL.
      IF screen-name = 'P_ORTA' OR screen-name = '%_P_ORTA_%_APP_%-TEXT'.
        screen-active = '0'.
        MODIFY SCREEN.
      ENDIF.
    ELSE.
      IF screen-name = 'P_ORTA'.
        screen-input = '0'.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
  ENDLOOP.

AT SELECTION-SCREEN.


      IF p_1 IS NOT INITIAL AND p_2 IS NOT INITIAL AND p_1 < p_2.
        p_gun = p_2 - p_1.
        p_orta = p_1 + ( p_gun / 2 ).
      ENDIF.
