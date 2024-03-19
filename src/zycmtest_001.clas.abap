class ZYCMTEST_001 definition
  public
  final
  create public .

public section.

  methods METHOD_1
    importing
      !IV_NUMBER type INT4
      !IV_RDBUTTON type CHAR1
    exporting
      !EV_NUMBER type INT4 .
protected section.

  methods METHOD_2
    importing
      !IV_NUMBER type INT4
    exporting
      !EV_NUMBER type INT4 .
  methods METHOD_3
    importing
      !IV_NUMBER type INT4
    exporting
      !EV_NUMBER type INT4 .
private section.
ENDCLASS.



CLASS ZYCMTEST_001 IMPLEMENTATION.


  METHOD METHOD_1.

    IF iv_rdbutton = 2.
      method_2(
        EXPORTING
          iv_number = iv_number
        IMPORTING
          ev_number = ev_number ).

    ELSEIF iv_rdbutton = 3.

      method_3(
        EXPORTING
          iv_number = iv_number
        IMPORTING
          ev_number = ev_number ).

    ENDIF.

  ENDMETHOD.


  method METHOD_2.

    ev_number = iv_number * iv_number.

  endmethod.


  method METHOD_3.

    ev_number = iv_number * iv_number * iv_number.

  endmethod.
ENDCLASS.
