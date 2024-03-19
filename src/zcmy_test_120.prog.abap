*&---------------------------------------------------------------------*
*& Report ZCM_TEST_119
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_120.


TYPES: BEGIN OF gty_table,
         box       TYPE c LENGTH 1,
         carrid    TYPE c LENGTH 3,
         connid    TYPE n LENGTH 4,
         fldate    TYPE datum, "sy-datum
         price     TYPE p DECIMALS 2,
         currency  TYPE c LENGTH 3,
         planetype TYPE c LENGTH 10,
       END OF gty_table.

DATA: gt_table    TYPE TABLE OF gty_table,
      gt_fieldcat TYPE slis_t_fieldcat_alv,
      gs_fieldcat TYPE slis_fieldcat_alv,
      gs_layout   TYPE slis_layout_alv.

START-OF-SELECTION.

  PERFORM select_data.
  PERFORM fcat.
  PERFORM layout.
  PERFORM show_alv.

FORM select_data.
  SELECT * FROM sflight INTO CORRESPONDING FIELDS OF TABLE gt_table.
ENDFORM.

FORM fcat.

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
  gs_fieldcat-seltext_m = 'Flight Date'.
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
  gs_fieldcat-just      = 'C'.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

  gs_fieldcat-fieldname = 'PLANETYPE'.
  gs_fieldcat-seltext_m = 'Aircraft Type'.
  gs_fieldcat-just      = 'C'.
  APPEND gs_fieldcat TO gt_fieldcat.
  CLEAR: gs_fieldcat.

ENDFORM.

FORM layout.
  gs_layout-zebra = abap_true.
  gs_layout-colwidth_optimize = abap_true.
  gs_layout-box_fieldname = 'BOX'.
ENDFORM.

FORM show_alv.

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

ENDFORM.
