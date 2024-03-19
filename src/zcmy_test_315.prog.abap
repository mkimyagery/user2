*&---------------------------------------------------------------------*
*& Report ZCM_TEST_315
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_315.

PARAMETERS: p_table TYPE tabname.

DATA: gr_data TYPE REF TO data.

START-OF-SELECTION.

DATA(go_new) = NEW zcmdynamic_table_selection( ).

TRY.
  go_new->get_data(
    EXPORTING
      iv_tabname = p_table
    IMPORTING
      et_data    = gr_data ).
CATCH CX_SY_CREATE_DATA_ERROR.
  MESSAGE 'Lütfen parametreyi boş geçmeyiniz.' TYPE 'S' DISPLAY LIKE 'E'.
ENDTRY.


ASSIGN gr_data->* TO FIELD-SYMBOL(<fs_table>).

BREAK-POINT.
