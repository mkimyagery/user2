*&---------------------------------------------------------------------*
*& Report ZCM_TEST_212
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_212.

TYPES: BEGIN OF gty_table,
         carrid    TYPE s_carr_id,
         carrname  TYPE s_carrname,
         connid    TYPE s_conn_id,
         countryfr TYPE land1,
         cityfrom  TYPE s_from_cit,
         airpfrom  TYPE s_fromairp,
       END OF gty_table.

*DATA: gt_table_son TYPE TABLE OF gty_table.
*
*SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
*  PARAMETERS: p_carrn TYPE s_carrname.
*SELECTION-SCREEN END OF BLOCK a1.
*
*START-OF-SELECTION.
*
*  SELECT scarr~carrid, scarr~carrname,
*         spfli~connid, spfli~countryfr, spfli~cityfrom, spfli~airpfrom
*    INTO TABLE @gt_table_son
*    FROM scarr
*    JOIN spfli
*    ON scarr~carrid = spfli~carrid
*    WHERE carrname = @p_carrn.
*
*  BREAK-POINT.


































DATA: gt_scarr     TYPE TABLE OF scarr,
      gt_spfli     TYPE TABLE OF spfli,
      gt_table_son TYPE TABLE OF gty_table,
      gs_table_son TYPE gty_table,
      gs_scarr     TYPE scarr,
      gs_spfli     TYPE spfli.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_carrn TYPE s_carrname.
SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  SELECT * FROM scarr
    INTO TABLE gt_scarr
    WHERE carrname = p_carrn.

  SELECT * FROM spfli
    INTO TABLE gt_spfli
    FOR ALL ENTRIES IN gt_scarr
    WHERE carrid = gt_scarr-carrid.

  LOOP AT gt_scarr INTO gs_scarr.
    gs_table_son-carrid   = gs_scarr-carrid.
    gs_table_son-carrname = gs_scarr-carrname.

    LOOP AT gt_spfli INTO gs_spfli.
      gs_table_son-connid = gs_spfli-connid.
      gs_table_son-countryfr = gs_spfli-countryfr.
      gs_table_son-cityfrom = gs_spfli-cityfrom.
      gs_table_son-airpfrom = gs_spfli-airpfrom.

      APPEND gs_table_son TO gt_table_son.
    ENDLOOP.

    CLEAR: gs_table_son.
  ENDLOOP.

  BREAK-POINT.
