*&---------------------------------------------------------------------*
*& Report ZCM_TEST_279
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_280.

TYPES: BEGIN OF gty_table,
         id        TYPE zcm_de_yeni_id,
         agencynum TYPE s_agncynum,
         name      TYPE s_agncynam,
         street    TYPE s_street,
         url       TYPE s_url,
       END OF gty_table.

TYPES: gtt_table TYPE TABLE OF gty_table WITH NON-UNIQUE KEY id.

START-OF-SELECTION.

  SELECT * FROM zcm_stravelag INTO TABLE @DATA(gt_stravelag).

  DATA(gt_table) = VALUE gtt_table( FOR gs_stravelag
                                    IN gt_stravelag
                                    WHERE ( id < 20 )
                                  ( id        = gs_stravelag-id
                                    agencynum = gs_stravelag-agencynum
                                    name      = gs_stravelag-name
                                    street    = gs_stravelag-street
                                    url       = gs_stravelag-url ) ).

  gt_table = VALUE gtt_table( BASE gt_table
                              FOR gs_stravelag
                              IN gt_stravelag
                              WHERE ( id > 30 )
                            ( id        = gs_stravelag-id
                              agencynum = gs_stravelag-agencynum
                              name      = gs_stravelag-name
                              street    = gs_stravelag-street
                              url       = gs_stravelag-url ) ).

  BREAK-POINT.
