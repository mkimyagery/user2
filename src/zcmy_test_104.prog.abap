*&---------------------------------------------------------------------*
*& Report ZCM_TEST_104
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_104.

DATA: gt_scarr        TYPE TABLE OF scarr,
      gt_fcat_scarr   TYPE lvc_t_fcat,
      gs_fcat_scarr   TYPE lvc_s_fcat,
      gt_fcat_spfli   TYPE lvc_t_fcat,
      gs_fcat_spfli   TYPE lvc_s_fcat,
      gt_fcat_sflight TYPE lvc_t_fcat,
      gs_fcat_sflight TYPE lvc_s_fcat,
      gs_layout       TYPE lvc_s_layo.

START-OF-SELECTION.

  SELECT * FROM scarr INTO TABLE gt_scarr.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SCARR'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat_scarr
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc IS NOT INITIAL.
    EXIT.
  ENDIF.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SPFLI'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat_spfli
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc IS NOT INITIAL.
    EXIT.
  ENDIF.

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
    EXIT.
  ENDIF.

  LOOP AT gt_fcat_scarr INTO gs_fcat_scarr.
    IF gs_fcat_scarr-fieldname = 'CARRID'.
      gs_fcat_scarr-hotspot = abap_true.
      MODIFY gt_fcat_scarr FROM gs_fcat_scarr TRANSPORTING hotspot.
    ENDIF.
  ENDLOOP.

  LOOP AT gt_fcat_spfli INTO gs_fcat_spfli.
    IF gs_fcat_spfli-fieldname = 'CARRID'.
      gs_fcat_spfli-hotspot = abap_true.
      MODIFY gt_fcat_spfli FROM gs_fcat_spfli TRANSPORTING hotspot.
    ENDIF.
  ENDLOOP.

  gs_layout-zebra      = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode   = 'A'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
    EXPORTING
      i_callback_program       = sy-repid
      i_callback_user_command  = 'UC_104'
      is_layout_lvc            = gs_layout
      it_fieldcat_lvc          = gt_fcat_scarr
    TABLES
      t_outtab                 = gt_scarr
    EXCEPTIONS
      program_error            = 1
      OTHERS                   = 2.

  IF sy-subrc IS NOT INITIAL.
    EXIT.
  ENDIF.


FORM uc_104 USING lv_ucomm    TYPE sy-ucomm
                  ls_selfield TYPE slis_selfield.

  CASE lv_ucomm.
    WHEN '&IC1'.

      SELECT * FROM spfli INTO TABLE @DATA(gt_spfli) WHERE carrid = @ls_selfield-value.

      CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
        EXPORTING
          i_callback_program      = sy-repid
          i_callback_user_command = 'UC_104_SPFLI'
          is_layout_lvc           = gs_layout
          it_fieldcat_lvc         = gt_fcat_spfli
          i_screen_start_column   = 4
          i_screen_end_column     = 110
          i_screen_start_line     = 10
          i_screen_end_line       = 20
        TABLES
          t_outtab                = gt_spfli
        EXCEPTIONS
          program_error           = 1
          OTHERS                  = 2.
  ENDCASE.

ENDFORM.

FORM uc_104_spfli USING lv_ucomm    TYPE sy-ucomm
                        ls_selfield TYPE slis_selfield.

  CASE lv_ucomm.
    WHEN '&IC1'.
      SELECT * FROM sflight INTO TABLE @DATA(gt_sflight) WHERE carrid = @ls_selfield-value.

      CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
        EXPORTING
          i_callback_program      = sy-repid
          is_layout_lvc           = gs_layout
          it_fieldcat_lvc         = gt_fcat_sflight
          i_screen_start_column   = 4
          i_screen_end_column     = 110
          i_screen_start_line     = 10
          i_screen_end_line       = 20
        TABLES
          t_outtab                = gt_sflight
        EXCEPTIONS
          program_error           = 1
          OTHERS                  = 2.
  ENDCASE.
ENDFORM.
