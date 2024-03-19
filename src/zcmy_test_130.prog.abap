*&---------------------------------------------------------------------*
*& Report ZCM_TEST_128
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_130.

DATA: gr_alvgrid             TYPE REF TO cl_gui_alv_grid,
*      gc_custom_control_name TYPE scrfname VALUE 'CC_ALV',
      gr_ccontainer          TYPE REF TO cl_gui_custom_container,
      gt_fieldcat            TYPE lvc_t_fcat,
      gs_layout              TYPE lvc_s_layo.

TYPES: BEGIN OF gty_list.
         INCLUDE STRUCTURE sflight.
TYPES: END OF gty_list.

DATA: gt_list TYPE TABLE OF gty_list.

START-OF-SELECTION.

  CALL SCREEN 0200.

MODULE status_0200 OUTPUT.
  SET PF-STATUS 'PF_STATUS_128'.
  SET TITLEBAR 'TITLE_128'.

  PERFORM select_data.
  PERFORM fcat.
  PERFORM layout.
  PERFORM show_alv.
ENDMODULE.

FORM select_data.
  SELECT * FROM sflight INTO CORRESPONDING FIELDS OF TABLE gt_list.
ENDFORM.

FORM fcat.
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SFLIGHT'
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
  IF gr_alvgrid IS INITIAL .

    CREATE OBJECT gr_ccontainer
      EXPORTING
        container_name              = 'CC_ALV'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.

    CREATE OBJECT gr_alvgrid
      EXPORTING
        i_parent          = gr_ccontainer
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.

    gr_alvgrid->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layout
      CHANGING
        it_outtab                     = gt_list
        it_fieldcatalog               = gt_fieldcat
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4 ).

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.

  ELSE .
    gr_alvgrid->refresh_table_display(
      EXCEPTIONS
        finished = 1
        OTHERS   = 2 ).

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.
  ENDIF .
ENDFORM.

MODULE user_command_0200 INPUT.
  CASE sy-ucomm.
    WHEN '&F03'.
      LEAVE PROGRAM.
  ENDCASE.
ENDMODULE.
