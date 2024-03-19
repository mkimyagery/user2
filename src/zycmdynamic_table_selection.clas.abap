class ZYCMDYNAMIC_TABLE_SELECTION definition
  public
  final
  create public .

public section.

  methods GET_DATA
    importing
      !IV_TABNAME type TABNAME
    exporting
      !ET_DATA type ref to DATA .
protected section.
private section.
ENDCLASS.



CLASS ZYCMDYNAMIC_TABLE_SELECTION IMPLEMENTATION.


  METHOD GET_DATA.
    FIELD-SYMBOLS: <fs_table> TYPE ANY TABLE.

    CREATE DATA et_data TYPE TABLE OF (iv_tabname).

    ASSIGN et_data->* TO <fs_table>.

    SELECT * FROM (iv_tabname) INTO TABLE <fs_table>.

  ENDMETHOD.
ENDCLASS.
