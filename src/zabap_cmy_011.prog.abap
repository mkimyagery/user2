*&---------------------------------------------------------------------*
*& Report ZABAP_CM_011
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_cmy_011.


DATA : gt_table       TYPE TABLE OF zcm_stravelag,
       gt_table_popup TYPE TABLE OF zcm_stravelag,
       gs_table       TYPE zcm_stravelag,
       gt_fieldcat    TYPE lvc_t_fcat,
       gt_fcat_popup  TYPE slis_t_fieldcat_alv,
       gs_fcat_popup  TYPE slis_fieldcat_alv,
       gs_fieldcat    TYPE lvc_s_fcat,
       gs_layout      TYPE lvc_s_layo,
       gv_answer      TYPE c LENGTH 1.

START-OF-SELECTION.

  PERFORM get_data.
  PERFORM fcat_alv.
  PERFORM layout.
  PERFORM show_alv.

FORM pf_status_011 USING lt_extab TYPE slis_t_extab.
  SET PF-STATUS '011_STATUS'.
ENDFORM.

FORM uc_011 USING lv_ucomm    TYPE sy-ucomm
                  ls_selfield TYPE slis_selfield.

  CASE lv_ucomm.
    WHEN 'GERI'.
      LEAVE PROGRAM.
    WHEN 'SIRALA'.
      SORT gt_table BY name.
      PERFORM show_alv.
    WHEN '&IC1'.

      CLEAR: gt_table_popup.

      READ TABLE gt_table INTO gs_table INDEX ls_selfield-tabindex.
      IF sy-subrc IS INITIAL.

        PERFORM fcat_popup.

        APPEND gs_table TO gt_table_popup.

        CALL FUNCTION 'REUSE_ALV_POPUP_TO_SELECT'
          EXPORTING
            i_title               = 'Secilen satirin isim bilgisini degistirebilirsiniz.'
            i_screen_start_column = 5
            i_screen_start_line   = 5
            i_screen_end_column   = 165
            i_screen_end_line     = 8
            i_tabname             = 'GT_TABLE_POPUP'
            it_fieldcat           = gt_fcat_popup
            i_callback_program    = sy-repid
          IMPORTING
            e_exit                = gv_answer
          TABLES
            t_outtab              = gt_table_popup
          EXCEPTIONS
            program_error         = 1
            OTHERS                = 2.

        IF sy-subrc <> 0.
          LEAVE PROGRAM.
        ENDIF.

        IF gv_answer IS INITIAL.

          READ TABLE gt_table_popup INTO gs_table INDEX 1.
          IF sy-subrc IS INITIAL.
            IF gs_table-name IS NOT INITIAL.
              UPDATE zcm_stravelag SET name = gs_table-name
                                   WHERE id = gs_table-id AND
                                         agencynum = gs_table-agencynum.

              PERFORM get_data.
              PERFORM show_alv.
            ENDIF.
          ENDIF.
        ENDIF.
      ENDIF.
  ENDCASE.

ENDFORM.

FORM get_data.
  SELECT * FROM zcm_stravelag INTO TABLE gt_table.
ENDFORM.

FORM fcat_alv.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZCM_STRAVELAG'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
    EXIT.
  ENDIF.

ENDFORM.

FORM layout .
  gs_layout-zebra      = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode   = 'A'.
ENDFORM.

FORM show_alv.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program       = sy-repid
      i_callback_pf_status_set = 'PF_STATUS_011'
      i_callback_user_command  = 'UC_011'
      is_layout_lvc            = gs_layout
      it_fieldcat_lvc          = gt_fieldcat
    TABLES
      t_outtab                 = gt_table
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.
  IF sy-subrc <> 0.
    EXIT.
  ENDIF.
ENDFORM.

FORM fcat_popup.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZCM_STRAVELAG'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat_popup
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc <> 0.
    EXIT.
  ENDIF.


  LOOP AT gt_fcat_popup INTO gs_fcat_popup.

    IF gs_fcat_popup-fieldname = 'NAME'.
      gs_fcat_popup-edit  = abap_true.
      gs_fcat_popup-input = abap_true.

      MODIFY gt_fcat_popup FROM gs_fcat_popup TRANSPORTING edit input WHERE fieldname = gs_fcat_popup-fieldname.
    ENDIF.

  ENDLOOP.
ENDFORM.
