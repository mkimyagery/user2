*&---------------------------------------------------------------------*
*& Report ZCM_TEST_334
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_334.


TYPES: BEGIN OF gty_header,
         header TYPE c LENGTH 20,
       END OF gty_header.

DATA: gv_agencynum TYPE s_agncynum,
      gt_header    TYPE TABLE OF gty_header,
      gr_data      TYPE REF TO data,
      gt_fcat      TYPE lvc_t_fcat.

PARAMETERS: p_table TYPE tabname.

FIELD-SYMBOLS: <fs_table> TYPE ANY TABLE.

START-OF-SELECTION.

  CREATE DATA gr_data TYPE TABLE OF (p_table).

  ASSIGN gr_data->* TO <fs_table>.

  SELECT * FROM (p_table) INTO TABLE @<fs_table>.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = p_table
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

  gt_header = VALUE #( FOR gs_fcat IN gt_fcat ( header = gs_fcat-fieldname ) ).

  cl_gui_frontend_services=>gui_download(
    EXPORTING
      filename                  = 'C:\Users\musta\OneDrive\Desktop\FORM_YENI.XLS'
      filetype                  = 'ASC'
      write_field_separator     = abap_true
      fieldnames                =  gt_header
    CHANGING
      data_tab                  = <fs_table>
    EXCEPTIONS
      file_write_error          = 1
      no_batch                  = 2
      gui_refuse_filetransfer   = 3
      invalid_type              = 4
      no_authority              = 5
      unknown_error             = 6
      header_not_allowed        = 7
      separator_not_allowed     = 8
      filesize_not_allowed      = 9
      header_too_long           = 10
      dp_error_create           = 11
      dp_error_send             = 12
      dp_error_write            = 13
      unknown_dp_error          = 14
      access_denied             = 15
      dp_out_of_memory          = 16
      disk_full                 = 17
      dp_timeout                = 18
      file_not_found            = 19
      dataprovider_exception    = 20
      control_flush_error       = 21
      not_supported_by_gui      = 22
      error_no_gui              = 23
      OTHERS                    = 24 ).

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.
