class ZYSTRAVELAG_UPDATE_NAME_2 definition
  public
  final
  create public .

public section.

  class-methods UPDATE_NAME
    importing
      !IV_AGENCYNUM type S_AGNCYNUM
      !IV_NAME type STRING
    returning
      value(RV_UPD_OK) type CHAR1 .
protected section.

  class-methods CHECK_ID
    importing
      !IV_AGENCYNUM type S_AGNCYNUM
    exceptions
      NO_DATA .
  class-methods CHECK_NAME
    importing
      !IV_NAME type STRING
    returning
      value(RV_OK) type CHAR1
    exceptions
      NEW_NAME_EMPTY
      TOO_LONG_NAME .
private section.
ENDCLASS.



CLASS ZYSTRAVELAG_UPDATE_NAME_2 IMPLEMENTATION.


  METHOD CHECK_ID.

    DATA: ls_stravelag TYPE zcm_stravelag.

    SELECT SINGLE * FROM zcm_stravelag
      INTO ls_stravelag
      WHERE agencynum = iv_agencynum.

    IF ls_stravelag IS INITIAL.
      RAISE no_data.
    ENDIF.

  ENDMETHOD.


  METHOD CHECK_NAME.

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


  METHOD UPDATE_NAME.

    DATA: lv_ok TYPE c LENGTH 1.

    check_id(
      EXPORTING
        iv_agencynum = iv_agencynum
      EXCEPTIONS
        no_data      = 1
        OTHERS       = 2 ).

    IF sy-subrc IS NOT INITIAL.
      MESSAGE TEXT-001 TYPE 'S' DISPLAY LIKE 'E'.
      RETURN.
    ENDIF.

    check_name(
      EXPORTING
        iv_name        =  iv_name
      RECEIVING
        rv_ok          =  lv_ok
      EXCEPTIONS
        new_name_empty = 1
        too_long_name  = 2
        OTHERS         = 3 ).

    "Alternatif kullanim.
*    lv_ok = check_name(  EXPORTING iv_name = iv_name ).

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
