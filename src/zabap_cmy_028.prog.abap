*&---------------------------------------------------------------------*
*& Report ZABAP_CM_028
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_cmy_028.


TYPES: BEGIN OF gty_table,
         id       TYPE zcm_de_id,
         ad       TYPE zcm_de_info_ad,
         soyad    TYPE zcm_de_info_sad,
         izin_bas TYPE sy-datum,
         izin_bit TYPE sy-datum,
       END OF gty_table.

DATA: gt_table TYPE TABLE OF gty_table.

DATA: gr_alvgrid      TYPE REF TO cl_gui_alv_grid,
      gr_ccontainer   TYPE REF TO cl_gui_custom_container,
      gr_alvgrid_2    TYPE REF TO cl_gui_alv_grid,
      gr_ccontainer_2 TYPE REF TO cl_gui_custom_container,
      gr_alvgrid_3    TYPE REF TO cl_gui_alv_grid,
      gr_ccontainer_3 TYPE REF TO cl_gui_custom_container,
      gt_fieldcat     TYPE lvc_t_fcat,
      gt_fieldcat_2   TYPE lvc_t_fcat,
      gt_fieldcat_3   TYPE lvc_t_fcat,
      gs_fieldcat     TYPE lvc_s_fcat,
      gs_layout       TYPE lvc_s_layo,
      gt_tablo_1      TYPE TABLE OF zcm_tablo_1,
      gt_tablo_2      TYPE TABLE OF zcm_tablo_2,
      gs_tablo_1      TYPE zcm_tablo_1,
      gs_tablo_2      TYPE zcm_tablo_2,
      gv_msg TYPE string.

START-OF-SELECTION.

  CALL SCREEN 0200.

MODULE status_0200 OUTPUT.
  SET PF-STATUS 'PF_ST_028'.
  SET TITLEBAR 'TITLE_028'.

  PERFORM select_data.
  PERFORM select_data_2.
  PERFORM select_data_3.
  PERFORM fcat.
  PERFORM fcat_2.
  PERFORM fcat_3.
  PERFORM layout.
  PERFORM show_alv.
ENDMODULE.

MODULE user_command_0200 INPUT.
  CASE sy-ucomm.
    WHEN 'GERI'.
      LEAVE PROGRAM.
    WHEN 'CHECK'.
      LOOP AT gt_tablo_2 INTO gs_tablo_2.
        READ TABLE gt_tablo_1 INTO gs_tablo_1 WITH KEY id = gs_tablo_2-id.
        IF sy-subrc IS NOT INITIAL.
          CONCATENATE gs_tablo_2-id 'nolu ID''ye sahip calisan, calisanlar listesinde bulunmamaktadir!' INTO gv_msg SEPARATED BY space.
          MESSAGE gv_msg TYPE 'I'.
        ENDIF.
      ENDLOOP.
  ENDCASE.
ENDMODULE.

FORM select_data .
  SELECT zcm_tablo_1~id, zcm_tablo_1~ad, zcm_tablo_1~soyad,
         zcm_tablo_2~izin_baslangic, zcm_tablo_2~izin_bitis
    INTO TABLE @gt_table
    FROM zcm_tablo_1
    JOIN zcm_tablo_2
    ON zcm_tablo_1~id = zcm_tablo_2~id.
ENDFORM.

FORM fcat.

  gs_fieldcat-fieldname = 'ID'.
  gs_fieldcat-reptext   = 'ID'.

  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'AD'.
  gs_fieldcat-reptext   = 'AD'.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'SOYAD'.
  gs_fieldcat-reptext   = 'SOYAD'.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'IZIN_BAS'.
  gs_fieldcat-reptext   = 'IZIN BASLANGIC'.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'IZIN_BIT'.
  gs_fieldcat-reptext   = 'IZIN BITIS'.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

ENDFORM.

FORM layout .
  gs_layout-zebra      = abap_true.
  gs_layout-cwidth_opt = abap_true.
  gs_layout-sel_mode   = 'A'.

ENDFORM.

FORM show_alv .
  IF gr_alvgrid IS INITIAL .

    CREATE OBJECT gr_ccontainer
      EXPORTING
        container_name              = 'CC_01'
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
        it_outtab                     = gt_table
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

  IF gr_alvgrid_2 IS INITIAL .

    CREATE OBJECT gr_ccontainer_2
      EXPORTING
        container_name              = 'CC_02'
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

    CREATE OBJECT gr_alvgrid_2
      EXPORTING
        i_parent          = gr_ccontainer_2
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.

    gr_alvgrid_2->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layout
      CHANGING
        it_outtab                     = gt_tablo_1
        it_fieldcatalog               = gt_fieldcat_2
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4 ).

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.

  ELSE .
    gr_alvgrid_2->refresh_table_display(
      EXCEPTIONS
        finished = 1
        OTHERS   = 2 ).

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.
  ENDIF .

  IF gr_alvgrid_3 IS INITIAL .

    CREATE OBJECT gr_ccontainer_3
      EXPORTING
        container_name              = 'CC_03'
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

    CREATE OBJECT gr_alvgrid_3
      EXPORTING
        i_parent          = gr_ccontainer_3
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.

    gr_alvgrid_3->set_table_for_first_display(
      EXPORTING
        is_layout                     = gs_layout
      CHANGING
        it_outtab                     = gt_tablo_2
        it_fieldcatalog               = gt_fieldcat_3
      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4 ).

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.

  ELSE .
    gr_alvgrid_3->refresh_table_display(
      EXCEPTIONS
        finished = 1
        OTHERS   = 2 ).

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.
  ENDIF .
ENDFORM.

FORM select_data_2 .
  SELECT * FROM zcm_tablo_1
    INTO TABLE gt_tablo_1
    FOR ALL ENTRIES IN gt_table
    WHERE id NE gt_table-id.
ENDFORM.

FORM select_data_3 .
  SELECT * FROM zcm_tablo_2 INTO TABLE gt_tablo_2 FOR ALL ENTRIES IN gt_table
    WHERE id NE gt_table-id.
ENDFORM.

FORM fcat_2 .
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZCM_TABLO_1'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fieldcat_2
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.
ENDFORM.

FORM fcat_3 .
  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'ZCM_TABLO_2'
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fieldcat_3
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.
ENDFORM.
