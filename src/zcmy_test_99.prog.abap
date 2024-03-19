*&---------------------------------------------------------------------*
*& Report ZCM_TEST_99
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_99.

TYPES: BEGIN OF gty_table,
         box.
         INCLUDE STRUCTURE zmc_table_001.
TYPES: END OF gty_table.

DATA: gt_table    TYPE TABLE OF gty_table,
      gt_fieldcat TYPE slis_t_fieldcat_alv,
      gs_layout   TYPE slis_layout_alv,
      gv_answer   TYPE c LENGTH 1.

START-OF-SELECTION.

  SELECT * FROM zmc_table_001 INTO CORRESPONDING FIELDS OF TABLE gt_table.

  CALL FUNCTION 'REUSE_ALV_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZMC_TABLE_001'
      i_bypassing_buffer     = 'X'
    CHANGING
      ct_fieldcat            = gt_fieldcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc IS NOT INITIAL.
    EXIT.
  ENDIF.

  gs_layout-zebra             = abap_true.
  gs_layout-colwidth_optimize = abap_true.
  gs_layout-box_fieldname     = 'BOX'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program       = sy-repid
      is_layout                = gs_layout
      it_fieldcat              = gt_fieldcat
      i_callback_pf_status_set = 'CM_PF_STATUS'
      i_callback_user_command  = 'CM_USER_COMMAND'
    TABLES
      t_outtab                 = gt_table
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.

FORM cm_pf_status USING lt_extab TYPE slis_t_extab.
  SET PF-STATUS 'STATUS_99'.
ENDFORM.

FORM cm_user_command USING lv_ucomm    TYPE sy-ucomm
                           ls_selfield TYPE slis_selfield.

  CASE lv_ucomm.
    WHEN 'SIL'.
      IF ls_selfield-fieldname = 'ID'.
        DELETE gt_table WHERE id = ls_selfield-value.

        CALL FUNCTION 'POPUP_TO_CONFIRM'
          EXPORTING
            text_question  = 'Database tablosundan da silmek istiyor musunuz?'
          IMPORTING
            answer         = gv_answer
          EXCEPTIONS
            text_not_found = 1
            OTHERS         = 2.

        IF gv_answer = 1.
          DELETE FROM zmc_table_001 WHERE id = ls_selfield-value.
        ENDIF.

        CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
          EXPORTING
            i_callback_program       = sy-repid
            is_layout                = gs_layout
            it_fieldcat              = gt_fieldcat
            i_callback_pf_status_set = 'CM_PF_STATUS'
            i_callback_user_command  = 'CM_USER_COMMAND'
          TABLES
            t_outtab                 = gt_table
          EXCEPTIONS
            program_error            = 1
            OTHERS                   = 2.
      ENDIF.

    WHEN 'GERI'.
      LEAVE PROGRAM.
  ENDCASE.
ENDFORM.
