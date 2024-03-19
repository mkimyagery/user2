class ZYFLIGHT_DATA_MODELING_STATIC definition
  public
  final
  create public .

public section.

  class-data GT_SCARR type ZCM_TT_SCARR .
  class-data GT_SPFLI type ZCM_TT_SPFLI .
  class-data GT_SFLIGHT type ZCM_TT_SFLIGHT .

  class-methods CLASS_CONSTRUCTOR .
  class-methods SHOW_ALV_SCARR .
  class-methods SHOW_ALV_SPFLI .
  class-methods SHOW_ALV_SFLIGHT .
protected section.
private section.
ENDCLASS.



CLASS ZYFLIGHT_DATA_MODELING_STATIC IMPLEMENTATION.


  METHOD CLASS_CONSTRUCTOR.

    SELECT * FROM scarr   INTO TABLE gt_scarr.
    SELECT * FROM spfli   INTO TABLE gt_spfli.
    SELECT * FROM sflight INTO TABLE gt_sflight.

  ENDMETHOD.


  METHOD SHOW_ALV_SCARR.

    DATA: lt_fcat   TYPE lvc_t_fcat,
          ls_layout TYPE lvc_s_layo.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'SCARR'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = lt_fcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.

    ls_layout-zebra      = abap_true.
    ls_layout-cwidth_opt = abap_true.
    ls_layout-sel_mode   = 'A'.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
      EXPORTING
        i_callback_program = sy-repid
        is_layout_lvc      = ls_layout
        it_fieldcat_lvc    = lt_fcat
      TABLES
        t_outtab           = gt_scarr
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.

  ENDMETHOD.


  METHOD SHOW_ALV_SFLIGHT.

    DATA: lt_fcat   TYPE lvc_t_fcat,
          ls_layout TYPE lvc_s_layo.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'SFLIGHT'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = lt_fcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.

    ls_layout-zebra      = abap_true.
    ls_layout-cwidth_opt = abap_true.
    ls_layout-sel_mode   = 'A'.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
      EXPORTING
        i_callback_program = sy-repid
        is_layout_lvc      = ls_layout
        it_fieldcat_lvc    = lt_fcat
      TABLES
        t_outtab           = gt_sflight
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.

  ENDMETHOD.


  METHOD SHOW_ALV_SPFLI.

    DATA: lt_fcat   TYPE lvc_t_fcat,
          ls_layout TYPE lvc_s_layo.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'SPFLI'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = lt_fcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.

    ls_layout-zebra      = abap_true.
    ls_layout-cwidth_opt = abap_true.
    ls_layout-sel_mode   = 'A'.

    CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
      EXPORTING
        i_callback_program = sy-repid
        is_layout_lvc      = ls_layout
        it_fieldcat_lvc    = lt_fcat
      TABLES
        t_outtab           = gt_spfli
      EXCEPTIONS
        program_error      = 1
        OTHERS             = 2.

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.

  ENDMETHOD.
ENDCLASS.
