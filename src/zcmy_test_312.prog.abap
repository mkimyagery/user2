*&---------------------------------------------------------------------*
*& Report ZCM_TEST_312
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_312.

*TYPES: BEGIN OF gty_table,
*         id        TYPE zcm_de_yeni_id,
*         agencynum TYPE s_agncynum,
*         name      TYPE s_agncynam,
*         street    TYPE s_street,
*         url       TYPE s_url,
*       END OF gty_table.
*
*DATA: gt_table TYPE TABLE OF gty_table,
*      gs_table TYPE gty_table.

START-OF-SELECTION.

  SELECT * FROM zcm_stravelag INTO TABLE @DATA(gt_stravelag).

*  LOOP AT gt_stravelag INTO DATA(gs_str) WHERE id < 20.
*
*    gs_table-id        = gs_str-id.
*    gs_table-agencynum = gs_str-agencynum.
*    gs_table-name      = gs_str-name.
*    gs_table-street    = gs_str-street.
*    gs_table-url       = gs_str-url.
*    APPEND gs_table TO gt_table.
*    CLEAR: gs_table.
*
*  ENDLOOP.

  DATA(gt_table) = VALUE zcm_tt_tabletypenew( FOR gs_stravelag
                                              IN gt_stravelag
                                              WHERE ( id < 20 )
                                            ( id        = gs_stravelag-id
                                              agencynum = gs_stravelag-agencynum
                                              name      = gs_stravelag-name
                                              street    = gs_stravelag-street
                                              url       = gs_stravelag-url ) ).

  gt_table = VALUE #( BASE gt_table
                      FOR gs_stravelag
                      IN gt_stravelag
                      WHERE ( id > 30 )
                      ( id        = gs_stravelag-id
                        agencynum = gs_stravelag-agencynum
                        name      = gs_stravelag-name
                        street    = gs_stravelag-street
                        url       = gs_stravelag-url ) ).



  BREAK-POINT.
