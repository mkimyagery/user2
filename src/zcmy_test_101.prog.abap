*&---------------------------------------------------------------------*
*& Report ZCM_TEST_101
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_101.

TYPES: BEGIN OF gty_table,
         box,
         carrid    TYPE c LENGTH 3,
         connid    TYPE n LENGTH 4,
         fldate    TYPE datum,
         price     TYPE p DECIMALS 2,
         currency  TYPE c LENGTH 3,
         planetype TYPE c LENGTH 10,
       END OF gty_table.

DATA: gt_table    TYPE TABLE OF gty_table,
      gt_fieldcat TYPE slis_t_fieldcat_alv,
      gs_fieldcat TYPE slis_fieldcat_alv,
      gs_layout   TYPE slis_layout_alv.

START-OF-SELECTION.

  SELECT * FROM sflight INTO CORRESPONDING FIELDS OF TABLE gt_table.

  gs_fieldcat-fieldname = 'CARRID'.
  gs_fieldcat-seltext_m = 'Airline Code'.
  gs_fieldcat-key       = abap_true.
  gs_fieldcat-just      = 'C'.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'CONNID'.
  gs_fieldcat-seltext_m = 'Connection Number'.
  gs_fieldcat-key       = abap_true.
  gs_fieldcat-just      = 'C'.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'FLDATE'.
  gs_fieldcat-seltext_m = 'Flight date'.
  gs_fieldcat-key       = abap_true.
  gs_fieldcat-just      = 'C'.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'PRICE'.
  gs_fieldcat-seltext_m = 'Airfare'.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'CURRENCY'.
  gs_fieldcat-seltext_m = 'Local Currency'.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'PLANETYPE'.
  gs_fieldcat-seltext_m = 'Aircraft Type'.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_layout-zebra             = abap_true.
  gs_layout-colwidth_optimize = abap_true.
  gs_layout-box_fieldname     = 'BOX'.

  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY'
    EXPORTING
      i_callback_program = sy-repid
      is_layout          = gs_layout
      it_fieldcat        = gt_fieldcat
    TABLES
      t_outtab           = gt_table
    EXCEPTIONS
      program_error      = 1
      OTHERS             = 2.





































*DATA: gt_table    TYPE TABLE OF zmc_table_001,
*      gt_fieldcat TYPE lvc_t_fcat,
*      gs_layout   TYPE lvc_s_layo.
*
*START-OF-SELECTION.
*
*  SELECT * FROM zmc_table_001 INTO TABLE gt_table.
*
*  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
*    EXPORTING
*      i_structure_name       = 'ZMC_TABLE_001'
*      i_bypassing_buffer     = abap_true
*    CHANGING
*      ct_fieldcat            = gt_fieldcat
*    EXCEPTIONS
*      inconsistent_interface = 1
*      program_error          = 2
*      OTHERS                 = 3.
*
*  gs_layout-zebra      = abap_true.
*  gs_layout-cwidth_opt = abap_true.
*  gs_layout-sel_mode   = 'A'.
*
*  CALL FUNCTION 'REUSE_ALV_GRID_DISPLAY_LVC'
*    EXPORTING
*      i_callback_program       = sy-repid
*      is_layout_lvc            = gs_layout
*      it_fieldcat_lvc          = gt_fieldcat
*    TABLES
*      t_outtab                 = gt_table
*    EXCEPTIONS
*      program_error            = 1
*      OTHERS                   = 2.





















FORM test2 USING lt_extab TYPE slis_t_extab.
  SET PF-STATUS 'STATUS_1002'.
ENDFORM.

FORM cm_user_command1 USING lv_ucomm    TYPE sy-ucomm
                           ls_selfield TYPE slis_selfield.

  CASE lv_ucomm.
    WHEN 'GERI' OR 'Geri'.
      LEAVE PROGRAM.
  ENDCASE.
ENDFORM.
