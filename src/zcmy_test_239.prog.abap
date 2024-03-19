*&---------------------------------------------------------------------*
*& Report ZCM_TEST_239
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_239.

TYPES: BEGIN OF gty_table,
         id        TYPE zcm_de_yeni_id,
         agencynum TYPE s_agncynum,
         name      TYPE s_agncynam,
         street    TYPE s_street,
         postbox   TYPE s_postbox,
         postcode  TYPE postcode,
         city      TYPE city,
         country   TYPE s_country,
         cnt_name  TYPE c LENGTH 20,
         region    TYPE s_region,
         telephone TYPE s_phoneno,
         url       TYPE s_url,
         langu     TYPE spras,
         currency  TYPE s_curr_ag,
       END OF gty_table.

DATA: gt_stravelag   TYPE TABLE OF gty_table,
      gs_stravelag   TYPE gty_table,
      gv_countryname TYPE landx.


START-OF-SELECTION.

  SELECT * FROM zcm_stravelag INTO CORRESPONDING FIELDS OF TABLE gt_stravelag.

  LOOP AT gt_stravelag INTO gs_stravelag.

    CALL FUNCTION 'IGN_COUNTRYNAME_GET'
      EXPORTING
        i_country         = gs_stravelag-country
      IMPORTING
        e_countryname     = gv_countryname
      exceptions
        country_not_found = 1
        others            = 2.

    IF sy-subrc IS NOT INITIAL.
      CLEAR: gv_countryname.
    ENDIF.

    gs_stravelag-cnt_name = gv_countryname.

    MODIFY gt_stravelag FROM gs_stravelag TRANSPORTING cnt_name WHERE id = gs_stravelag-id AND
                                                                      name = gs_stravelag-name.
    IF sy-subrc IS INITIAL.
      WRITE: gs_stravelag-id, gs_stravelag-name, gs_stravelag-country, gs_stravelag-cnt_name.
    ENDIF.

    CLEAR: gs_stravelag.

  ENDLOOP.
