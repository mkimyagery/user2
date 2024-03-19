*&---------------------------------------------------------------------*
*& Report ZCM_TEST_272
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_272.

PARAMETERS: p_scarr  RADIOBUTTON GROUP abc,
            p_spfli  RADIOBUTTON GROUP abc,
            p_sflght RADIOBUTTON GROUP abc.

DATA: go_select  TYPE REF TO zabap_cm_select_data,
      gt_scarr   TYPE TABLE OF scarr,
      gt_spfli   TYPE TABLE OF spfli,
      gt_sflight TYPE TABLE OF sflight,
      gv_number  TYPE i VALUE 1.

FIELD-SYMBOLS: <fs_table> TYPE ANY TABLE,
               <fs_str>   TYPE any,
               <fs_hucre> TYPE any.

START-OF-SELECTION.

  CREATE OBJECT go_select.

  IF p_scarr = abap_true.
    ASSIGN gt_scarr TO <fs_table>.
  ELSEIF p_spfli = abap_true.
    ASSIGN gt_spfli TO <fs_table>.
  ELSEIF p_sflght = abap_true.
    ASSIGN gt_sflight TO <fs_table>.
  ENDIF.

  go_select->get_data(
    EXPORTING
      iv_get_scarr   = p_scarr
      iv_get_spfli   = p_spfli
      iv_get_sflight = p_sflght
    IMPORTING
      et_data        = <fs_table> ).

  LOOP AT <fs_table> ASSIGNING <fs_str>.

    DO.
      ASSIGN COMPONENT gv_number OF STRUCTURE <fs_str> TO <fs_hucre>.
      IF <fs_hucre> IS ASSIGNED. " IF sy-subrc is initial
        WRITE: <fs_hucre>.
        UNASSIGN: <fs_hucre>.
      ELSE.
       EXIT.
      ENDIF.

      gv_number = gv_number + 1.
    ENDDO.

    gv_number = 1.
    SKIP.
  ENDLOOP.
