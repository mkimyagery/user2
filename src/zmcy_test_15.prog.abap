*&---------------------------------------------------------------------*
*& Report ZMC_TEST_15
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZMCY_TEST_15.

SELECTION-SCREEN BEGIN OF SCREEN 100.
SELECTION-SCREEN BEGIN OF BLOCK sel1 WITH FRAME TITLE title1.
PARAMETERS: p_s_v TYPE spfli-cityfrom.
PARAMETERS: p_s_n TYPE spfli-cityto.
SELECTION-SCREEN END OF BLOCK sel1.
SELECTION-SCREEN END OF SCREEN 100.

SELECTION-SCREEN BEGIN OF SCREEN 200.
SELECTION-SCREEN BEGIN OF BLOCK sel2 WITH FRAME TITLE title2.
PARAMETERS: p_fh_v TYPE spfli-airpfrom.
PARAMETERS: p_fh_n TYPE spfli-airpto.
SELECTION-SCREEN END OF BLOCK sel2.
SELECTION-SCREEN END OF SCREEN 200.

INITIALIZATION.
  title1 = 'Städte'.
  title2 = 'Flughäfen'.

START-OF-SELECTION.
  CALL SELECTION-SCREEN 100 STARTING AT 10 10.
  CALL SELECTION-SCREEN 200 STARTING AT 10 10.
