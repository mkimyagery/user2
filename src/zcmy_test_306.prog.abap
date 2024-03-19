*&---------------------------------------------------------------------*
*& Report ZCM_TEST_306
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_306.

TYPES: BEGIN OF gty_table,
         box       TYPE c LENGTH 1,
         carrid    TYPE c LENGTH 3,
         connid    TYPE n LENGTH 4,
         fldate    TYPE datum,
         price     TYPE p DECIMALS 2,
         currency  TYPE c LENGTH 3,
         planetype TYPE c LENGTH 10,
       END OF gty_table.

DATA: gt_table    TYPE TABLE OF gty_table,
      gt_fieldcat TYPE slis_t_fieldcat_alv,
      gs_layout   TYPE slis_layout_alv.

START-OF-SELECTION.

  SELECT * FROM sflight INTO CORRESPONDING FIELDS OF TABLE gt_table.

  APPEND INITIAL LINE TO gt_fieldcat ASSIGNING FIELD-SYMBOL(<fs_fcat>).
  <fs_fcat>-fieldname = 'CARRID'.
  <fs_fcat>-seltext_m = 'Airline Code'.
  <fs_fcat>-key       = abap_true.
  <fs_fcat>-just      = 'C'.

  APPEND INITIAL LINE TO gt_fieldcat ASSIGNING <fs_fcat>.
  <fs_fcat>-fieldname = 'CONNID'.
  <fs_fcat>-seltext_m = 'Connection Number'.
  <fs_fcat>-key       = abap_true.
  <fs_fcat>-just      = 'C'.

  APPEND INITIAL LINE TO gt_fieldcat ASSIGNING <fs_fcat>.
  <fs_fcat>-fieldname = 'FLDATE'.
  <fs_fcat>-seltext_m = 'Flight Date'.
  <fs_fcat>-key       = abap_true.
  <fs_fcat>-just      = 'C'.

  APPEND INITIAL LINE TO gt_fieldcat ASSIGNING <fs_fcat>.
  <fs_fcat>-fieldname = 'PRICE'.
  <fs_fcat>-seltext_m = 'Airfare'.

  APPEND INITIAL LINE TO gt_fieldcat ASSIGNING <fs_fcat>.
  <fs_fcat>-fieldname = 'CURRENCY'.
  <fs_fcat>-seltext_m = 'Local Currency'.

  APPEND INITIAL LINE TO gt_fieldcat ASSIGNING <fs_fcat>.
  <fs_fcat>-fieldname = 'PLANETYPE'.
  <fs_fcat>-seltext_m = 'Aircraft Type'.

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
  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.
