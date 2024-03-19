*&---------------------------------------------------------------------*
*& Report ZCM_TEST_214
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_214.

TYPES: BEGIN OF gty_table,
         carrid    TYPE s_carr_id,
         carrname  TYPE s_carrname,
         connid    TYPE s_conn_id,
         countryfr TYPE land1,
         cityfrom  TYPE s_from_cit,
         airpfrom  TYPE s_fromairp,
       END OF gty_table.

DATA: gt_table_son_1 TYPE TABLE OF gty_table.
DATA: gt_table_son_2 TYPE TABLE OF gty_table.
DATA: gt_table_son_3 TYPE TABLE OF gty_table.

START-OF-SELECTION.

  SELECT spfli~connid, spfli~countryfr, spfli~cityfrom, spfli~airpfrom,
         scarr~carrid, scarr~carrname
    INTO CORRESPONDING FIELDS OF TABLE @gt_table_son_1
    FROM spfli
    RIGHT OUTER JOIN scarr
    ON spfli~carrid = scarr~carrid.

  SELECT spfli~connid, spfli~countryfr, spfli~cityfrom, spfli~airpfrom,
         scarr~carrid, scarr~carrname
    INTO CORRESPONDING FIELDS OF TABLE @gt_table_son_2
    FROM spfli
    LEFT OUTER JOIN scarr
    ON spfli~carrid = scarr~carrid.

  SELECT scarr~carrid, scarr~carrname,
         spfli~connid, spfli~countryfr, spfli~cityfrom, spfli~airpfrom
    INTO CORRESPONDING FIELDS OF TABLE @gt_table_son_3
    FROM spfli
    LEFT OUTER JOIN scarr
    ON spfli~carrid = scarr~carrid.

  BREAK-POINT.
