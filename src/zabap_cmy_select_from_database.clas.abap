class ZABAP_CMY_SELECT_FROM_DATABASE definition
  public
  final
  create public .

public section.

  data GT_TABLE type ref to DATA .

  methods GET_TABLE
    importing
      !IV_GET_SCARR type XFELD
      !IV_GET_SPFLI type XFELD
      !IV_GET_SFLIGHT type XFELD
    exporting
      !ET_DATA type STANDARD TABLE .
protected section.
private section.
ENDCLASS.



CLASS ZABAP_CMY_SELECT_FROM_DATABASE IMPLEMENTATION.


  METHOD GET_TABLE.

    DATA: lv_tabname TYPE tabname.

    IF iv_get_scarr = abap_true.
      lv_tabname = 'SCARR'.
    ELSEIF iv_get_spfli = abap_true.
      lv_tabname = 'SPFLI'.
    ELSEIF iv_get_sflight = abap_true.
      lv_tabname = 'SFLIGHT'.
    ENDIF.

    SELECT * FROM (lv_tabname) INTO TABLE et_data.

  ENDMETHOD.
ENDCLASS.
