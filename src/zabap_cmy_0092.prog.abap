*&---------------------------------------------------------------------*
*& Report ZABAP_CM_009
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_cmy_0092.

TYPES: BEGIN OF gty_table,
         box.
         INCLUDE STRUCTURE zcm_stravelag.
TYPES: END OF gty_table.


DATA : gt_table    TYPE TABLE OF gty_table,
       gt_table2   TYPE TABLE OF gty_table,
       gt_fieldcat TYPE	slis_t_fieldcat_alv,
       gt_fieldcat_pup TYPE	slis_t_fieldcat_alv,
       gs_fieldcat TYPE slis_fieldcat_alv,
       gs_layout   TYPE	slis_layout_alv,
       gv_answer.

SELECT * FROM zcm_stravelag INTO CORRESPONDING FIELDS OF TABLE gt_table.

CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
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

gt_fieldcat_pup = gt_fieldcat.

LOOP AT gt_fieldcat INTO gs_fieldcat.

  CASE gs_fieldcat-fieldname.
    WHEN 'NAME'.
*      gs_fieldcat-key  = abap_true.
*      gs_fieldcat-edit = abap_true.
*      gs_fieldcat-no_out = abap_true.
    WHEN 'ID'.
*      gs_fieldcat-seltext_s = gs_fieldcat-seltext_m = gs_fieldcat-seltext_l = 'Alpaslan'.
*      gs_fieldcat-no_out = abap_true.
  ENDCASE.

  MODIFY gt_fieldcat FROM gs_fieldcat.
  CLEAR: gs_fieldcat.
ENDLOOP.


gs_layout-zebra             = abap_true.
gs_layout-colwidth_optimize = abap_true.
gs_layout-box_fieldname     = 'BOX'.

CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
  EXPORTING
    i_callback_program       = sy-repid  "alternatif olarak 'ZABAP_CM_009'
    is_layout                = gs_layout
    it_fieldcat              = gt_fieldcat
    i_callback_pf_status_set = 'PF_STATUS_0092'
    i_callback_user_command  = 'UC_0092'
  TABLES
    t_outtab                 = gt_table
  EXCEPTIONS
    program_error            = 1
    OTHERS                   = 2.

IF sy-subrc <> 0.
  EXIT.
ENDIF.

FORM pf_status_0092 USING lt_extab TYPE slis_t_extab.

  SET PF-STATUS 'PF_STATUS_0092'.

ENDFORM.

FORM uc_0092 USING lv_ucomm    TYPE sy-ucomm
                   ls_selfield TYPE slis_selfield.

  CASE lv_ucomm.
    WHEN 'GERI'.
      LEAVE PROGRAM.
    WHEN 'SORT'.
      SORT gt_table BY name.

      CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
        EXPORTING
          i_callback_program       = sy-repid  "alternatif olarak 'ZABAP_CM_009'
          is_layout                = gs_layout
          it_fieldcat              = gt_fieldcat
          i_callback_pf_status_set = 'PF_STATUS_0092'
          i_callback_user_command  = 'UC_0092'
        TABLES
          t_outtab                 = gt_table
        EXCEPTIONS
          program_error            = 1
          OTHERS                   = 2.

    WHEN '&IC1'.

      READ TABLE gt_table INTO DATA(gs_table) INDEX ls_selfield-tabindex.
      IF sy-subrc IS INITIAL.
        APPEND gs_table TO gt_table2.

        LOOP AT gt_fieldcat_pup INTO DATA(gs_fcat).
          IF gs_fcat-fieldname = 'NAME'.
            gs_fcat-edit = abap_true.
            gs_fcat-input = abap_true.

            MODIFY gt_fieldcat_pup FROM gs_fcat TRANSPORTING edit input WHERE fieldname = gs_fcat-fieldname.
          ENDIF.
        ENDLOOP.

        CALL FUNCTION 'REUSE_ALV_POPUP_TO_SELECT'
          EXPORTING
            i_title               = 'Baslik test'
*           I_SELECTION           = 'X'
*           I_ALLOW_NO_SELECTION  =
*           I_ZEBRA               = ' '
            i_screen_start_column = 5
            i_screen_start_line   = 5
            i_screen_end_column   = 165
            i_screen_end_line     = 8
*           I_CHECKBOX_FIELDNAME  =
*           I_LINEMARK_FIELDNAME  =
*           I_SCROLL_TO_SEL_LINE  = 'X'
            i_tabname             = 'GT_TABLE2'
*           I_STRUCTURE_NAME      =
            it_fieldcat           = gt_fieldcat_pup
*           IT_EXCLUDING          =
            i_callback_program    = sy-repid
*           I_CALLBACK_USER_COMMAND       =
*           IS_PRIVATE            =
          IMPORTING
*           ES_SELFIELD           =
            e_exit                = gv_answer
          TABLES
            t_outtab              = gt_table2
*         EXCEPTIONS
*           PROGRAM_ERROR         = 1
*           OTHERS                = 2
          .
        IF gv_answer IS INITIAL.

          READ TABLE gt_table2 INTO gs_table INDEX 1.
          IF sy-subrc IS INITIAL.
            UPDATE zcm_stravelag SET name = gs_table-name WHERE agencynum = gs_table-agencynum.

            SELECT * FROM zcm_stravelag INTO CORRESPONDING FIELDS OF TABLE gt_table.

              CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
                EXPORTING
                  i_callback_program       = sy-repid  "alternatif olarak 'ZABAP_CM_009'
                  is_layout                = gs_layout
                  it_fieldcat              = gt_fieldcat
                  i_callback_pf_status_set = 'PF_STATUS_0092'
                  i_callback_user_command  = 'UC_0092'
                TABLES
                  t_outtab                 = gt_table
                EXCEPTIONS
                  program_error            = 1
                  OTHERS                   = 2.
            ENDIF.

          ENDIF.





        ENDIF.
    ENDCASE.

ENDFORM.
