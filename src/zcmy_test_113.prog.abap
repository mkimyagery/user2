*&---------------------------------------------------------------------*
*& Report ZCM_TEST_113
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_113.

CLASS lcl_stravelag_update_name DEFINITION.

  PUBLIC SECTION.
    CLASS-METHODS: update_name IMPORTING iv_agencynum     TYPE s_agncynum "Static - Public method.
                                         iv_name          TYPE string
                               RETURNING VALUE(rv_upd_ok) TYPE boolean.

  PROTECTED SECTION.
    CLASS-METHODS: check_id   IMPORTING  iv_agencynum TYPE s_agncynum     "Static - Protected method.
                              EXCEPTIONS no_data,

                   check_name IMPORTING  iv_name      TYPE string         "Static - Protected method.
                              RETURNING  VALUE(rv_ok) TYPE boolean
                              EXCEPTIONS new_name_empty too_long_name.

ENDCLASS.

CLASS lcl_stravelag_update_name IMPLEMENTATION.

  METHOD: check_id.

    DATA: ls_stravelag TYPE zcm_stravelag.

    SELECT SINGLE * FROM zcm_stravelag
      INTO ls_stravelag
      WHERE agencynum = iv_agencynum.

    IF ls_stravelag IS INITIAL.
      RAISE no_data.
    ENDIF.

  ENDMETHOD.

  METHOD check_name.

    DATA: lv_number_of_char TYPE i.

    IF iv_name IS INITIAL.
      RAISE new_name_empty.
    ENDIF.

    lv_number_of_char = strlen( iv_name ).

    IF lv_number_of_char > 25.
      RAISE too_long_name.
    ENDIF.

    rv_ok = abap_true.

  ENDMETHOD.

  METHOD update_name.

    DATA: lv_ok TYPE c LENGTH 1.

    check_id(
      EXPORTING
        iv_agencynum = iv_agencynum
      EXCEPTIONS
        no_data      = 1
        OTHERS       = 2 ).

    IF sy-subrc = 1.
      MESSAGE TEXT-001 TYPE 'S' DISPLAY LIKE 'E'.
      RETURN.
    ENDIF.

    check_name(
      EXPORTING
        iv_name = iv_name
      RECEIVING
        rv_ok   = lv_ok
      EXCEPTIONS
        new_name_empty = 1
        too_long_name  = 2
        OTHERS         = 3 ).

    IF sy-subrc = 1.
      MESSAGE TEXT-002 TYPE 'S' DISPLAY LIKE 'E'.
      RETURN.
    ELSEIF sy-subrc = 2.
      MESSAGE TEXT-003 TYPE 'S' DISPLAY LIKE 'E'.
      RETURN.
    ENDIF.

    IF lv_ok IS NOT INITIAL.
      UPDATE zcm_stravelag SET   name      = iv_name
                           WHERE agencynum = iv_agencynum.
      IF sy-subrc IS INITIAL.
        rv_upd_ok = abap_true.
      ENDIF.
    ENDIF.

  ENDMETHOD.

ENDCLASS.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-004.

  PARAMETERS: p_agnum TYPE s_agncynum OBLIGATORY,
              p_name  TYPE string LOWER CASE.

SELECTION-SCREEN END OF BLOCK a1.

DATA: gv_upd_ok TYPE c LENGTH 1.

START-OF-SELECTION.

  lcl_stravelag_update_name=>update_name(
    EXPORTING
      iv_agencynum = p_agnum
      iv_name      = p_name
    RECEIVING
      rv_upd_ok = gv_upd_ok ).

  IF gv_upd_ok IS NOT INITIAL.
    MESSAGE TEXT-005 TYPE 'S'.
  ENDIF.
