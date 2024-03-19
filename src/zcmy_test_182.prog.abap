*&---------------------------------------------------------------------*
*& Report ZCM_TEST_1555
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_182.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.

  PARAMETERS: p_hour TYPE int2,
              p_mins TYPE int2,
              p_scnd TYPE int2.

SELECTION-SCREEN END OF BLOCK a1.



SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME TITLE TEXT-002 NO INTERVALS.
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
*        screen-intensified = '1'.
        screen-color = '611'.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.
  ENDLOOP.




*TYPES : BEGIN OF list,
*          carrid TYPE spfli-carrid,
*        END OF list.
*
*DATA  : it_list     TYPE TABLE OF list,
*        wa_list     TYPE  list,
*        it_return   TYPE TABLE OF ddshretval,
*        wa_return   TYPE ddshretval,
*        it_flight   TYPE TABLE OF spfli,
*        wa_flight   TYPE spfli,
*        it_material TYPE TABLE OF mara,
*        wa_material TYPE mara,
*        it_links    TYPE TABLE OF tline.
*
*SELECTION-SCREEN : BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
*
*  PARAMETERS : p_carrid TYPE char3,
*               p_matnr  TYPE char18.
*
*SELECTION-SCREEN : END  OF BLOCK b1.
*
*SELECTION-SCREEN : BEGIN OF BLOCK b2 WITH FRAME TITLE TEXT-002 NO INTERVALS.
*
*  PARAMETERS : r1 RADIOBUTTON GROUP g1 DEFAULT 'X' USER-COMMAND sss,
*               r2 RADIOBUTTON GROUP g1.
*
*SELECTION-SCREEN : END  OF BLOCK b2.
*
*AT SELECTION-SCREEN OUTPUT. " DYNAMIC MODIFICATION OF SCREEN
*
*  IF r1 = 'X'.
*    LOOP AT SCREEN.
*      IF screen-name = 'P_MATNR' OR screen-name = '%_P_MATNR_%_APP_%-TEXT'.
*        screen-active = 0.
*        screen-invisible = 1.
*        MODIFY SCREEN.
*      ENDIF.
*    ENDLOOP.
*  ELSEIF r2 = 'X'.
*    LOOP AT SCREEN.
*      IF screen-name = 'P_CARRID' OR screen-name = '%_P_CARRID_%_APP_%-TEXT'.
*        screen-active = 0.
*        screen-invisible = 1.
*        MODIFY SCREEN.
*      ENDIF.
*    ENDLOOP.
*  ENDIF.
*
*INITIALIZATION.
*
*  p_carrid = 'AB'.
*  p_matnr = '00000010'.
*
*AT SELECTION-SCREEN ON HELP-REQUEST FOR p_carrid.
*
*  CALL FUNCTION 'HELP_OBJECT_SHOW'
*    EXPORTING
*      dokclass = 'ABAP'
*      dokname  = 'FLIGHTHELP'
*    TABLES
*      links    = it_links.
*
*AT SELECTION-SCREEN ON VALUE-REQUEST FOR p_carrid.
*
*  SELECT carrid FROM spfli INTO TABLE it_list.
*
*  CALL FUNCTION 'F4IF_INT_TABLE_VALUE_REQUEST'
*    EXPORTING
*      retfield   = 'CARRID'
*      value_org  = 'S'
*    TABLES
*      value_tab  = it_list
*      return_tab = it_return.
*
*  LOOP AT it_return INTO wa_return.
*    p_carrid = wa_return-fieldval.
*  ENDLOOP.
*
*START-OF-SELECTION.
*
*  IF r1 = 'X'.
*    SELECT * FROM spfli
*      INTO TABLE it_flight
*      WHERE carrid = p_carrid.
*  ELSEIF r2 = 'X'.
*    SELECT * FROM mara
*      INTO TABLE it_material
*      WHERE matnr = p_matnr.
*  ENDIF.
*
*END-OF-SELECTION.
*
*  IF r1 = 'X'.
*    LOOP AT it_flight INTO wa_flight.
*      WRITE :/ wa_flight-carrid,
*               wa_flight-connid,
*               wa_flight-countryfr,
*               wa_flight-countryto,
*               wa_flight-airpfrom,
*               wa_flight-airpto,
*               wa_flight-cityfrom,
*               wa_flight-cityto,
*               wa_flight-distance.
*    ENDLOOP.
*
*  ELSEIF r2 = 'X'.
*
*    LOOP AT it_material INTO wa_material.
*      WRITE :/ wa_material-matnr,
*               wa_material-ersda,
*               wa_material-ernam,
*               wa_material-aenam.
*    ENDLOOP.
*  ENDIF.
*
*TOP-OF-PAGE.
*
*  IF r1 = 'X'.
*    WRITE :/50 'INDIAN AIRLINE DETAILD OF FLIGHT'.
*    ULINE.
*  ELSEIF r2 = 'X'.
*    WRITE :/50 'DETAILS OF MATERIALS'.
*    ULINE.
*  ENDIF.
*
*END-OF-PAGE.
*  WRITE :/50 'THANKS FOR SHOWING INTEREST'.
*  ULINE.
