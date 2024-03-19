class ZABAP_CMY_SELECT_NEW definition
  public
  final
  create public .

public section.

  data GT_TABLE type ref to DATA .

  methods GET_TABLE
    importing
      !IV_TABNAME type TABNAME
    exporting
      !ET_DATA type STANDARD TABLE .
protected section.
private section.
ENDCLASS.



CLASS ZABAP_CMY_SELECT_NEW IMPLEMENTATION.


  METHOD GET_TABLE.

    SELECT * FROM (iv_tabname) INTO TABLE et_data.

  ENDMETHOD.
ENDCLASS.
