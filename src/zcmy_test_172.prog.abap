*&---------------------------------------------------------------------*
*& Report ZCM_TEST_172
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_172.

DATA: go_cont_sflight TYPE REF TO cl_gui_custom_container,
      go_grid_sflight TYPE REF TO cl_gui_alv_grid,
      gt_fcat_sflight TYPE lvc_t_fcat,
      gt_sflight      TYPE TABLE OF sflight,
      gs_sflight      TYPE sflight,
      gs_layout       TYPE lvc_s_layo,
      gv_colon        TYPE lvc_fname.

START-OF-SELECTION.

  CALL SCREEN 0400.

MODULE status_0400 OUTPUT.
  SET PF-STATUS 'STATUS_172'.
*  SET TITLEBAR 'TITLE_161'.

  PERFORM layout.
  PERFORM select_data.
  PERFORM fcat.
  PERFORM show_alv.

ENDMODULE.

MODULE user_command_0400 INPUT.

  CASE sy-ucomm.
    WHEN 'GERI'.
      LEAVE PROGRAM.
    WHEN 'RENK'.
      READ TABLE gt_fcat_sflight ASSIGNING FIELD-SYMBOL(<gs_fcat>) WITH KEY fieldname = gv_colon.
      IF sy-subrc IS INITIAL.

      ENDIF.
  ENDCASE.
ENDMODULE.

FORM layout.
  gs_layout-zebra      = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode   = 'A'.
ENDFORM.

FORM select_data.
  IF gt_sflight IS INITIAL.
    SELECT * FROM sflight INTO TABLE gt_sflight.
  ENDIF.
ENDFORM.

FORM fcat.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SFLIGHT'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat_sflight
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

ENDFORM.

FORM show_alv.

  IF go_grid_sflight IS INITIAL.

    CREATE OBJECT go_cont_sflight
      EXPORTING
        container_name              = 'CC_SFLIGHT'
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

    CREATE OBJECT go_grid_sflight
      EXPORTING
        i_parent          = go_cont_sflight
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.

    go_grid_sflight->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layout
      CHANGING
        it_outtab                     = gt_sflight
        it_fieldcatalog               = gt_fcat_sflight
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4 ).

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.

  ELSE.

    go_grid_sflight->refresh_table_display(
      EXCEPTIONS
        finished       = 1
        OTHERS         = 2 ).

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.
  ENDIF.
ENDFORM.
