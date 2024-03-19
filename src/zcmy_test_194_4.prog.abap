*&---------------------------------------------------------------------*
*& Report ZCM_TEST_194_4
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_194_4.

DATA: gt_stravelag TYPE TABLE OF zcm_stravelag_02,
      gt_selected  TYPE TABLE OF zcm_stravelag_02,
      gs_stravelag TYPE zcm_stravelag_02,
      gt_fieldcat  TYPE lvc_t_fcat,
      gt_fcat_sel  TYPE slis_t_fieldcat_alv,
      gs_layout    TYPE lvc_s_layo,
      gv_count     TYPE n LENGTH 3,
      gv_msg       TYPE c LENGTH 40,
      gv_city      TYPE city,
      gv_cnt_city  TYPE n LENGTH 3.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.

  SELECT-OPTIONS: so_agnnm FOR gs_stravelag-agencynum.

SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  PERFORM select_data.
  PERFORM fcat.
  PERFORM layout.
  PERFORM show_alv.

FORM select_data.

  SELECT * FROM zcm_stravelag_02 INTO TABLE gt_stravelag WHERE agencynum IN so_agnnm.

ENDFORM.

FORM fcat.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZCM_STRAVELAG_02'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

ENDFORM.

FORM layout.

  gs_layout-zebra      = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode   = 'A'.

ENDFORM.

FORM show_alv.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program       = sy-repid
      is_layout_lvc            = gs_layout
      it_fieldcat_lvc          = gt_fieldcat
      i_callback_pf_status_set = 'PF_194_4'
      i_callback_user_command  = 'UC_194_4'
    TABLES
      t_outtab                 = gt_stravelag
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

ENDFORM.

FORM pf_194_4 USING lt_extab TYPE slis_t_extab.
  SET PF-STATUS 'PF_STATUS_194_4'.
ENDFORM.

FORM uc_194_4 USING lv_ucomm    TYPE sy-ucomm
                    ls_selfield TYPE slis_selfield.

  CASE lv_ucomm.
    WHEN 'COUNT'.
      DESCRIBE TABLE gt_stravelag LINES gv_count.
      SHIFT gv_count LEFT DELETING LEADING '0'.
      CONCATENATE TEXT-002 gv_count INTO gv_msg SEPARATED BY space.
      MESSAGE gv_msg TYPE 'I'.
      CLEAR: gv_msg.
    WHEN 'CITY'.
      SORT gt_stravelag BY city.

      LOOP AT gt_stravelag INTO gs_stravelag.
        IF sy-tabix > 1 AND gs_stravelag-city = gv_city.
          CONTINUE.
        ENDIF.

        gv_city = gs_stravelag-city.
        gv_cnt_city = gv_cnt_city + 1.
      ENDLOOP.

      SHIFT gv_cnt_city LEFT DELETING LEADING '0'.
      CONCATENATE TEXT-003 gv_cnt_city INTO gv_msg SEPARATED BY space.
      MESSAGE gv_msg TYPE 'I'.
      CLEAR: gv_msg, gv_cnt_city.

    WHEN 'LINE'.
      READ TABLE gt_stravelag INTO gs_stravelag INDEX ls_selfield-tabindex.
      IF sy-subrc IS INITIAL.

        APPEND gs_stravelag TO gt_selected.

        CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
          EXPORTING
            i_structure_name       = 'ZCM_STRAVELAG_02'
            i_bypassing_buffer     = abap_true
          CHANGING
            ct_fieldcat            = gt_fcat_sel
          EXCEPTIONS
            inconsistent_interface = 1
            program_error          = 2
            OTHERS                 = 3.

        IF sy-subrc IS NOT INITIAL.
          LEAVE PROGRAM.
        ENDIF.

        CALL FUNCTION 'REUSE_ALV_POPUP_TO_SELECT'
          EXPORTING
            i_title               = TEXT-004
            i_screen_start_column = 5
            i_screen_start_line   = 5
            i_screen_end_column   = 165
            i_screen_end_line     = 8
            i_tabname             = 'GT_SELECTED'
            it_fieldcat           = gt_fcat_sel
            i_callback_program    = sy-repid
          TABLES
            t_outtab              = gt_selected
          EXCEPTIONS
            program_error         = 1
            OTHERS                = 2.

        IF sy-subrc IS NOT INITIAL.
          LEAVE PROGRAM.
        ENDIF.

        CLEAR: gt_selected. "*****

      ENDIF.

  ENDCASE.
ENDFORM.
