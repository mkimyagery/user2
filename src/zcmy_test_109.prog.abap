*&---------------------------------------------------------------------*
*& Report ZCM_TEST_108
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_109.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.

  PARAMETERS: p_ag_num TYPE s_agncynum,
              p_name   TYPE s_agncynam,
              p_street TYPE s_street,
              p_pbox   TYPE s_postbox,
              p_pcode  TYPE postcode,
              p_city   TYPE city,
              p_cntry  TYPE s_country,
              p_region TYPE s_region,
              p_tel    TYPE s_phoneno,
              p_curr   TYPE s_curr_ag.

SELECTION-SCREEN END OF BLOCK a1.

DATA: go_stravelag_new_entry_alv TYPE REF TO ZSTRAVELAG_NEW_ENTRY_ALV_2.

START-OF-SELECTION.

  CREATE OBJECT go_stravelag_new_entry_alv.

  go_stravelag_new_entry_alv->new_entry(
    EXPORTING
      iv_agencynum = p_ag_num
      iv_name      = p_name
      iv_street    = p_street
      iv_postbox   = p_pbox
      iv_postcode  = p_pcode
      iv_city      = p_city
      iv_country   = p_cntry
      iv_region    = p_region
      iv_telephone = p_tel
      iv_currency  = p_curr ).

  go_stravelag_new_entry_alv->prep_fcat(
    EXCEPTIONS
      no_fcat = 1
      OTHERS  = 2  ).

  IF sy-subrc = 1 .
    MESSAGE TEXT-002 TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  go_stravelag_new_entry_alv->prep_layout(
    EXPORTING
      iv_zebra             = abap_true
      iv_colwidth_optimize = abap_true ).

  go_stravelag_new_entry_alv->prep_data( ).

  go_stravelag_new_entry_alv->show_data( ).

*  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
*    EXPORTING
*      i_callback_program       = sy-repid
*      is_layout                = go_stravelag_new_entry_alv->gs_layout
*      it_fieldcat              = go_stravelag_new_entry_alv->gt_fcat
*    TABLES
*      t_outtab                 = go_stravelag_new_entry_alv->gt_zcm_stravelag
*    EXCEPTIONS
*      program_error            = 1
*      OTHERS                   = 2.
*
*  IF sy-subrc IS NOT INITIAL.
*    MESSAGE TEXT-003 TYPE 'S' DISPLAY LIKE 'E'.
*  ENDIF.
