*&---------------------------------------------------------------------*
*& Report ZCM_TEST_1556
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_1556.

TABLES sscrfields.

SELECTION-SCREEN:
  BEGIN OF SCREEN 500 AS WINDOW TITLE title,
    PUSHBUTTON 2(10)  but1 USER-COMMAND cli1,
    PUSHBUTTON 12(30) but2 USER-COMMAND cli2
                           VISIBLE LENGTH 10,
  END OF SCREEN 500.

AT SELECTION-SCREEN.
  CASE sscrfields.
    WHEN 'CLI1'.
      ...
    WHEN 'CLI2'.
      ...
  ENDCASE.

START-OF-SELECTION.
  title  = 'Push button'.
  but1 = 'Button 1'.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name   = icon_information
      text   = 'Button 222222'
      info   = 'My quick info'
    IMPORTING
      RESULT = but2
    EXCEPTIONS
      OTHERS = 0.

  CALL SELECTION-SCREEN '0500' STARTING AT 10 10.

*TABLES: sscrfields.
*
*SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE text-001 NO INTERVALS.
*PARAMETERS: p1 TYPE i,
*            p2 TYPE i,
*            p3 TYPE i.
*SELECTION-SCREEN END OF BLOCK a1.
*
*SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME TITLE text-002 NO INTERVALS.
*PARAMETERS: das_res TYPE i.
*SELECTION-SCREEN END OF BLOCK a2.
*
*SELECTION-SCREEN FUNCTION KEY 1.
*SELECTION-SCREEN FUNCTION KEY 2.
*DATA: p4 TYPE i.
*
*INITIALIZATION.
*  sscrfields-functxt_01 = 'Hesapla'.
*  sscrfields-functxt_02 = 'Temizle'.
*
*AT SELECTION-SCREEN.
*  IF sscrfields-ucomm = 'FC01'.
*    PERFORM kalkulieren.
*  ELSEIF sscrfields-ucomm = 'FC02'.
*    PERFORM loschen.
*  ENDIF.
*
*START-OF-SELECTION.
*AT SELECTION-SCREEN OUTPUT.
*  PERFORM kalkulieren.
*  LOOP AT SCREEN.
*    IF screen-name = 'DAS_RES'.
*      das_res     = p4.
*    ENDIF.
*    MODIFY SCREEN.
*  ENDLOOP.
**&---------------------------------------------------------------------*
**&      Form  KALKULIEREN
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
**  -->  p1        text
**  <--  p2        text
**----------------------------------------------------------------------*
*FORM kalkulieren .
*  IF p1 > 0.
*    p4 = p1 * 3600.
*  ENDIF.
*  IF p2 > 0.
*    p4 = p4 + 60 * p2.
*  ENDIF.
*  IF p3 > 0.
*    p4 = p4 + p3.
*  ENDIF.
*ENDFORM.
**&---------------------------------------------------------------------*
**&      Form  LOSCHEN
**&---------------------------------------------------------------------*
**       text
**----------------------------------------------------------------------*
**  -->  p1        text
**  <--  p2        text
**----------------------------------------------------------------------*
*FORM loschen .
*  CLEAR: p1, p2, p3, p4, das_res.
*  MODIFY SCREEN.
*ENDFORM.
