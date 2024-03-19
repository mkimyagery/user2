*&---------------------------------------------------------------------*
*& Report ZCM_TEST_1500
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_1500.

*MODULE status_0200 OUTPUT.
*  SET PF-STATUS 'PF_STATUS_128'.
*  SET TITLEBAR 'TITLE_128'.
*
*  PERFORM select_data.
*  PERFORM fcat.
*  PERFORM layout.
*  PERFORM show_alv.
*ENDMODULE.
*
*FORM select_data.
*  SELECT * FROM sflight INTO CORRESPONDING FIELDS OF TABLE gt_list.
*ENDFORM.
*
*FORM fcat.
*  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
*    EXPORTING
*      i_structure_name       = 'SFLIGHT'
*      i_bypassing_buffer     = abap_true
*    CHANGING
*      ct_fieldcat            = gt_fieldcat
*    EXCEPTIONS
*      inconsistent_interface = 1
*      program_error          = 2
*      OTHERS                 = 3.
*
*  IF sy-subrc IS NOT INITIAL.
*    LEAVE PROGRAM.
*  ENDIF.
*ENDFORM.
*
*FORM layout.
*  gs_layout-zebra      = abap_true.
*  gs_layout-cwidth_opt = abap_true.
*  gs_layout-sel_mode   = 'A'.
*ENDFORM.
*
*FORM show_alv.
*  IF go_alvgrid IS INITIAL .
*
*    CREATE OBJECT go_container
*      EXPORTING
*        container_name              = 'CC_ALV'
*      EXCEPTIONS
*        cntl_error                  = 1
*        cntl_system_error           = 2
*        create_error                = 3
*        lifetime_error              = 4
*        lifetime_dynpro_dynpro_link = 5
*        OTHERS                      = 6.
*
*    IF sy-subrc IS NOT INITIAL.
*      LEAVE PROGRAM.
*    ENDIF.
*
*    CREATE OBJECT go_alvgrid
*      EXPORTING
*        i_parent          = go_container
*      EXCEPTIONS
*        error_cntl_create = 1
*        error_cntl_init   = 2
*        error_cntl_link   = 3
*        error_dp_create   = 4
*        OTHERS            = 5.
*
*    IF sy-subrc IS NOT INITIAL.
*      LEAVE PROGRAM.
*    ENDIF.
*
*    go_alvgrid->set_table_for_first_display(
*      EXPORTING
*        is_layout                     = gs_layout
*      CHANGING
*        it_outtab                     = gt_list
*        it_fieldcatalog               = gt_fieldcat
*      EXCEPTIONS
*        invalid_parameter_combination = 1
*        program_error                 = 2
*        too_many_lines                = 3
*        OTHERS                        = 4 ).
*
*    IF sy-subrc IS NOT INITIAL.
*      LEAVE PROGRAM.
*    ENDIF.
*
*  ELSE.
*    go_alvgrid->refresh_table_display(
*      EXCEPTIONS
*        finished = 1
*        OTHERS   = 2 ).
*
*    IF sy-subrc IS NOT INITIAL.
*      LEAVE PROGRAM.
*    ENDIF.
*  ENDIF.
*ENDFORM.
*
*MODULE user_command_0200 INPUT.
*  CASE sy-ucomm.
*    WHEN 'GERI'.
*      LEAVE PROGRAM.
*  ENDCASE.
*ENDMODULE.
