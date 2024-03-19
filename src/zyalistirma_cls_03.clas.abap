class ZYALISTIRMA_CLS_03 definition
  public
  final
  create public .

public section.

  class-methods UZERI_2
    importing
      !IV_NUMBER type INT4
    exporting
      !EV_RESULT type INT4 .
  class-methods UZERI_3
    importing
      !IV_NUMBER type INT4
    exporting
      !EV_RESULT type INT4 .
  class-methods UZERI_4
    importing
      !IV_NUMBER type INT4
    exporting
      !EV_RESULT type INT4 .
protected section.
private section.
ENDCLASS.



CLASS ZYALISTIRMA_CLS_03 IMPLEMENTATION.


  METHOD UZERI_2.

    ev_result = iv_number * iv_number.

  ENDMETHOD.


  method UZERI_3.

    ev_result = iv_number * iv_number * iv_number.

  endmethod.


  METHOD UZERI_4.

    ev_result = iv_number * iv_number * iv_number * iv_number.

  ENDMETHOD.
ENDCLASS.
