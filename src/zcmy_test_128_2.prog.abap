*&---------------------------------------------------------------------*
*& Report ZCM_TEST_128_2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_128_2.

TABLES: MARC.

DATA: BEGIN OF ITAB OCCURS 0.
 INCLUDE STRUCTURE MARC.
DATA: END OF ITAB.


*--ALV Grid
DATA: OK_CODE LIKE SY-UCOMM.
DATA: CUSTOM_CONTAINER TYPE REF TO CL_GUI_CUSTOM_CONTAINER.
DATA: MYCONTAINER TYPE SCRFNAME VALUE 'ALV_CONTAINER'.
DATA: GR_GRID TYPE REF TO CL_GUI_ALV_GRID.
DATA: GR_DOCKING_CONTAINER TYPE REF TO CL_GUI_DOCKING_CONTAINER.
DATA: GT_FIELDCAT TYPE LVC_T_FCAT WITH HEADER LINE.
DATA: LS_FCAT TYPE LVC_S_FCAT .
DATA: LT_FIELDCAT_SLIS TYPE SLIS_T_FIELDCAT_ALV.
DATA: GS_LAYOUT TYPE LVC_S_LAYO.


*-----------------------------------
* Event Handler Class definition
*
CLASS LCL_EVENT_HANDLER DEFINITION.
 PUBLIC SECTION.

 METHODS: HANDLE_TOOLBAR
 FOR EVENT TOOLBAR OF CL_GUI_ALV_GRID
 IMPORTING E_OBJECT E_INTERACTIVE.


 METHODS: HANDLE_USER_COMMAND
 FOR EVENT USER_COMMAND OF CL_GUI_ALV_GRID
 IMPORTING E_UCOMM.

ENDCLASS. "lcl_event_handler DEFINITION

DATA: GR_EVENT_HANDLER TYPE REF TO LCL_EVENT_HANDLER.

*----------------------------------
* Event Handler Class implimentation
*
CLASS LCL_EVENT_HANDLER IMPLEMENTATION.

 METHOD: HANDLE_TOOLBAR.

 PERFORM HANDLE_TOOLBAR USING E_OBJECT.

 ENDMETHOD. "handle_toolbar

 METHOD: HANDLE_USER_COMMAND.

 PERFORM HANDLE_USER_COMMAND USING E_UCOMM.
 ENDMETHOD. "handle_user_command

ENDCLASS. "lcl_event_handler IMPLEMENTATION


*----- selection-screen
SELECTION-SCREEN: BEGIN OF BLOCK A1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS: S_MATNR FOR MARC-MATNR,
 S_WERKS FOR MARC-WERKS.
SELECTION-SCREEN: END OF BLOCK A1.


*---- start-of-selection
START-OF-SELECTION.

*-- read data into internal table
 PERFORM GET_DATA.

 CHECK ITAB[] IS NOT INITIAL.

 CALL SCREEN 100.



END-OF-SELECTION.
*&---------------------------------------------------------------------

*& Form GET_DATA
*&---------------------------------------------------------------------

* text
*----------------------------------------------------------------------

* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------

FORM GET_DATA .


 SELECT * INTO CORRESPONDING FIELDS OF TABLE ITAB
 FROM MARC
 WHERE MATNR IN S_MATNR
 AND WERKS IN S_WERKS.

ENDFORM. " GET_DATA
*&---------------------------------------------------------------------*
*& Module STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
MODULE STATUS_0100 OUTPUT.

 SET PF-STATUS 'STATUS_100'.

 PERFORM DISPLAY_TABLE.




ENDMODULE. " STATUS_0100 OUTPUT
*&---------------------------------------------------------------------*
*& Module USER_COMMAND_0100 INPUT
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
MODULE USER_COMMAND_0100 INPUT.

 CASE OK_CODE.
 WHEN 'BACK'. "Go Back
 LEAVE TO SCREEN 0.
 WHEN 'EXIT'.
 CALL METHOD CUSTOM_CONTAINER->FREE.
 LEAVE TO SCREEN 0.
 WHEN OTHERS.
 ENDCASE.

 CLEAR OK_CODE.

ENDMODULE. " USER_COMMAND_0100 INPUT
*&---------------------------------------------------------------------*
*& Form DISPLAY_TABLE
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM DISPLAY_TABLE .

 IF CUSTOM_CONTAINER IS INITIAL.
* create container
 CREATE OBJECT CUSTOM_CONTAINER
 EXPORTING
 CONTAINER_NAME = MYCONTAINER
 EXCEPTIONS
 CNTL_ERROR = 1
 CNTL_SYSTEM_ERROR = 2
 CREATE_ERROR = 3
 LIFETIME_ERROR = 4
 LIFETIME_DYNPRO_DYNPRO_LINK = 5.
 IF SY-SUBRC <> 0.
 MESSAGE ' erreur container' TYPE 'I'.
 ENDIF.
* create alv grid
 CREATE OBJECT GR_GRID
 EXPORTING
 I_PARENT = CUSTOM_CONTAINER
 EXCEPTIONS
 ERROR_CNTL_CREATE = 1
 ERROR_CNTL_INIT = 2
 ERROR_CNTL_LINK = 3
 ERROR_DP_CREATE = 4
 OTHERS = 5.
 IF SY-SUBRC <> 0.
 MESSAGE ' erreur grid' TYPE 'I'.
 ENDIF.

* prepare fielfcatalog
 PERFORM PREPAR_CATALOG.
* prepare layout
 PERFORM PREPAR_LAYOUT.
* fist display
 PERFORM FIRST_DISPLAY.

 ELSE .
 CALL METHOD GR_GRID->REFRESH_TABLE_DISPLAY
 EXCEPTIONS
 FINISHED = 1
 OTHERS = 2.
 ENDIF.


ENDFORM. " DISPLAY_TABLE
*&---------------------------------------------------------------------*
*& Form PREPAR_CATALOG
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM PREPAR_CATALOG .

 CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
 EXPORTING
 I_PROGRAM_NAME = SY-REPID
 I_INTERNAL_TABNAME = 'ITAB'
 I_CLIENT_NEVER_DISPLAY = 'X'
 I_INCLNAME = SY-REPID
 CHANGING
 CT_FIELDCAT = LT_FIELDCAT_SLIS.

 CALL FUNCTION 'LVC_TRANSFER_FROM_SLIS'
 EXPORTING
 IT_FIELDCAT_ALV = LT_FIELDCAT_SLIS
 IMPORTING
 ET_FIELDCAT_LVC = GT_FIELDCAT[]
 TABLES
 IT_DATA = ITAB[]
 EXCEPTIONS
 IT_DATA_MISSING = 1
 OTHERS = 2.


 LOOP AT GT_FIELDCAT.
 IF GT_FIELDCAT-FIELDNAME = 'MATNR'.
 GT_FIELDCAT-HOTSPOT = 'x'.
 ENDIF.

 MODIFY GT_FIELDCAT.
 ENDLOOP.


ENDFORM. " PREPAR_CATALOG
*&---------------------------------------------------------------------*
*& Form PREPAR_LAYOUT
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM PREPAR_LAYOUT .

 GS_LAYOUT-ZEBRA = 'X' .
 GS_LAYOUT-SMALLTITLE = 'X'.

ENDFORM. " PREPAR_LAYOUT
*&---------------------------------------------------------------------*
*& Form FIRST_DISPLAY
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* --> p1 text
* <-- p2 text
*----------------------------------------------------------------------*
FORM FIRST_DISPLAY .

 CALL METHOD GR_GRID->SET_TABLE_FOR_FIRST_DISPLAY
 EXPORTING
 IS_LAYOUT = GS_LAYOUT
 I_DEFAULT = 'X'
 CHANGING
 IT_FIELDCATALOG = GT_FIELDCAT[]
 IT_OUTTAB = ITAB[]
 EXCEPTIONS
 INVALID_PARAMETER_COMBINATION = 1
 PROGRAM_ERROR = 2
 TOO_MANY_LINES = 3
 OTHERS = 4.


 CREATE OBJECT GR_EVENT_HANDLER .
 SET HANDLER GR_EVENT_HANDLER->HANDLE_TOOLBAR FOR GR_GRID.
 SET HANDLER GR_EVENT_HANDLER->HANDLE_USER_COMMAND FOR GR_GRID.

 CALL METHOD GR_GRID->SET_READY_FOR_INPUT
 EXPORTING
 I_READY_FOR_INPUT = 1.


ENDFORM. " FIRST_DISPLAY
*&---------------------------------------------------------------------*
*& Form HANDLE_TOOLBAR
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* -->P_E_OBJECT text
*----------------------------------------------------------------------*
FORM HANDLE_TOOLBAR USING I_OBJECT TYPE REF TO
 CL_ALV_EVENT_TOOLBAR_SET.

 DATA: LS_TOOLBAR TYPE STB_BUTTON.

 CLEAR LS_TOOLBAR.
 MOVE 'CHECK' TO LS_TOOLBAR-FUNCTION.
 MOVE ICON_OKAY TO LS_TOOLBAR-ICON.
 MOVE 'Check' TO LS_TOOLBAR-TEXT.
 MOVE 'Check' TO LS_TOOLBAR-QUICKINFO.
 MOVE ' ' TO LS_TOOLBAR-DISABLED.
 APPEND LS_TOOLBAR TO I_OBJECT->MT_TOOLBAR.



ENDFORM. " HANDLE_TOOLBAR
*&---------------------------------------------------------------------*
*& Form HANDLE_USER_COMMAND
*&---------------------------------------------------------------------*
* text
*----------------------------------------------------------------------*
* -->P_E_UCOMM text
*----------------------------------------------------------------------*
FORM HANDLE_USER_COMMAND USING I_UCOMM TYPE SYUCOMM.


 CASE I_UCOMM.
 WHEN 'CHECK'.
 MESSAGE I000(zf) WITH 'Check Button!'.
 WHEN OTHERS.
 ENDCASE.




ENDFORM. " HANDLE_USER_COMMAND
