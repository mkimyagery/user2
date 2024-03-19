*&---------------------------------------------------------------------*
*& Report ZCM_TEST_190
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_196.

TYPES: BEGIN OF gty_table,
         carrid    TYPE	s_carr_id,
         carrname  TYPE	s_carrname,
         connid    TYPE	s_conn_id,
         countryfr TYPE  land1,
         cityfrom  TYPE	s_from_cit,
         airpfrom  TYPE	s_fromairp,
       END OF gty_table.

DATA: gt_table_son TYPE TABLE OF gty_table.

START-OF-SELECTION.

  SELECT spfli~connid, spfli~countryfr, spfli~cityfrom, spfli~airpfrom,
    scarr~carrid, scarr~carrname
    INTO CORRESPONDING FIELDS OF TABLE @gt_table_son
    FROM spfli
    RIGHT OUTER JOIN scarr
    ON spfli~carrid = scarr~carrid.
BREAK-POINT.









*DATA: gt_scarr     TYPE TABLE OF scarr,
*      gt_spfli     TYPE TABLE OF spfli,
*      gt_table_son TYPE TABLE OF gty_table,
*      gs_scarr     TYPE scarr,
*      gs_spfli     TYPE spfli,
*      gs_table_son TYPE gty_table.
*
*SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
*  PARAMETERS: p_carrnm TYPE s_carrname.
*SELECTION-SCREEN END OF BLOCK a1.
*
*START-OF-SELECTION.
*
*  SELECT * FROM scarr
*    INTO TABLE gt_scarr
*    WHERE carrname = p_carrnm.
*
*  SELECT * FROM spfli
*    INTO TABLE gt_spfli
*    FOR ALL ENTRIES IN gt_scarr
*    WHERE carrid = gt_scarr-carrid.
*
*  LOOP AT gt_scarr INTO gs_scarr.
*    gs_table_son-carrid   = gs_scarr-carrid.
*    gs_table_son-carrname = gs_scarr-carrname.
*
*    LOOP AT gt_spfli INTO gs_spfli WHERE carrid = gs_scarr-carrid.
*      gs_table_son-connid    = gs_spfli-connid.
*      gs_table_son-countryfr = gs_spfli-countryfr.
*      gs_table_son-cityfrom  = gs_spfli-cityfrom.
*      gs_table_son-airpfrom  = gs_spfli-airpfrom.
*
*      APPEND gs_table_son TO gt_table_son.
*    ENDLOOP.
*
*    CLEAR: gs_table_son.
*  ENDLOOP.
*  BREAK-POINT.


*START-OF-SELECTION.
*DATA: gt_tablo_son TYPE TABLE OF gty_table.
*  SELECT zcm_tablo_1~id, zcm_tablo_1~ad, zcm_tablo_1~soyad,
*         zcm_tablo_2~izin_baslangic, zcm_tablo_2~izin_bitis
*    INTO TABLE @gt_tablo_son
*    FROM zcm_tablo_1
*    INNER JOIN zcm_tablo_2
*    ON zcm_tablo_1~id = zcm_tablo_2~id.
*
*  SORT gt_tablo_son BY id.
*
*  BREAK-POINT.





























*TYPES: BEGIN OF gty_table,
*         carrid    TYPE s_carr_id,
*         carrname  TYPE s_carrname,
*         connid    TYPE s_conn_id,
*         fldate    TYPE s_date,
*         price     TYPE s_price,
*         currency  TYPE s_currcode,
*         planetype TYPE s_planetye,
*         seatsmax  TYPE s_seatsmax,
*       END OF gty_table.
*
*DATA: gt_table TYPE TABLE OF gty_table.
*
*
*START-OF-SELECTION.
*
*  SELECT scarr~carrid, scarr~carrname, sflight~connid,
*         sflight~fldate, sflight~price, sflight~currency,
*         sflight~planetype, sflight~seatsmax
*    INTO TABLE @gt_table
*    FROM scarr
*    INNER JOIN sflight
*    ON scarr~carrid = sflight~carrid.
*
*  SELECT scarr~carrid, scarr~carrname, sflight~connid,
*         sflight~fldate, sflight~price, sflight~currency,
*         sflight~planetype, sflight~seatsmax
*    INTO TABLE @DATA(gt_table_2)
*    FROM scarr
*    LEFT OUTER JOIN sflight
*    ON scarr~carrid = sflight~carrid.
*
*
*
*
*
*  BREAK-POINT.
