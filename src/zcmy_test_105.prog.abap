*&---------------------------------------------------------------------*
*& Report ZCM_TEST_105
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_105.

DATA: gt_spfli  TYPE TABLE OF spfli,
      gt_fcat   TYPE  lvc_t_fcat,
      gs_layout TYPE lvc_s_layo,
      gv_answer.


START-OF-SELECTION.

  SELECT * FROM spfli INTO TABLE gt_spfli.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name   = 'SPFLI'
      i_bypassing_buffer = abap_true
    CHANGING
      ct_fieldcat        = gt_fcat.

  gs_layout-zebra      = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode   = 'A'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'PFS_105'
      i_callback_user_command  = 'UC_105'
      is_layout_lvc            = gs_layout
      it_fieldcat_lvc          = gt_fcat
    TABLES
      t_outtab                 = gt_spfli.

FORM pfs_105 USING lt_extab TYPE slis_t_extab.
  SET PF-STATUS 'PFS_105'.
ENDFORM.

FORM uc_105 USING lv_ucomm    TYPE sy-ucomm
                           ls_selfield TYPE slis_selfield.

  CASE lv_ucomm.
    WHEN 'GERI'.
      LEAVE PROGRAM.
    WHEN 'MAKE_EDITABLE'.

      LOOP AT gt_fcat INTO DATA(ls_fcat).
        IF ls_fcat-fieldname = 'CITYFROM' OR ls_fcat-fieldname = 'CITYTO'.
          ls_fcat-edit = abap_true.
          MODIFY gt_fcat FROM ls_fcat TRANSPORTING edit WHERE fieldname = ls_fcat-fieldname.
        ENDIF.
      ENDLOOP.

      CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
        EXPORTING
          i_callback_program       = sy-repid
          i_callback_pf_status_set = 'PFS_105'
          i_callback_user_command  = 'UC_105'
          is_layout_lvc            = gs_layout
          it_fieldcat_lvc          = gt_fcat
        TABLES
          t_outtab                 = gt_spfli.
      WHEN 'SAVE_CHNGS'.

        CALL FUNCTION 'POPUP_TO_CONFIRM'
          EXPORTING
*           TITLEBAR                    = ' '
*           DIAGNOSE_OBJECT             = ' '
            text_question               = 'Degisikliklerin kaydedilebilmesi icin lütfen sabit hücrelerden birinin üzerine cift tiklayin.'
           TEXT_BUTTON_1               = 'Tikladim'
*           ICON_BUTTON_1               = ' '
           TEXT_BUTTON_2               = 'Geri'
*           ICON_BUTTON_2               = ' '
*           DEFAULT_BUTTON              = '1'
*           DISPLAY_CANCEL_BUTTON       = 'X'
*           USERDEFINED_F1_HELP         = ' '
*           START_COLUMN                = 25
*           START_ROW                   = 6
*           POPUP_TYPE                  =
*           IV_QUICKINFO_BUTTON_1       = ' '
*           IV_QUICKINFO_BUTTON_2       = ' '
         IMPORTING
           ANSWER                      = gv_answer.

           IF gv_answer = 1.
             MODIFY spfli FROM TABLE gt_spfli.
           ENDIF.

  ENDCASE.
ENDFORM.
