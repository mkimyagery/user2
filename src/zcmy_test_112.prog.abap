*&---------------------------------------------------------------------*
*& Report ZCM_TEST_112
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_112.

CLASS lcl_calculator DEFINITION.

  PUBLIC SECTION.
    METHODS: topla IMPORTING iv_num_topla_01 TYPE i  "Instance - Public method.
                             iv_num_topla_02 TYPE i
                   EXPORTING ev_sonuc_toplam TYPE i,

             cikar IMPORTING iv_num_cikar_01  TYPE i "Instance - Public method.
                             iv_num_cikar_02  TYPE i
                   EXPORTING ev_sonuc_cikarma TYPE i,

             carp  IMPORTING iv_num_carp_01  TYPE i  "Instance - Public method.
                             iv_num_carp_02  TYPE i
                   EXPORTING ev_sonuc_carpim TYPE i,

             bol   IMPORTING iv_num_bol_01  TYPE i   "Instance - Public method.
                             iv_num_bol_02  TYPE i
                   EXPORTING ev_sonuc_bolum TYPE i.

ENDCLASS.

CLASS lcl_calculator IMPLEMENTATION.

  METHOD topla.
    ev_sonuc_toplam = iv_num_topla_01 + iv_num_topla_02.
  ENDMETHOD.

  METHOD cikar.
    ev_sonuc_cikarma = iv_num_cikar_01 - iv_num_cikar_02.
  ENDMETHOD.

  METHOD carp.
    ev_sonuc_carpim = iv_num_carp_01 * iv_num_carp_02.
  ENDMETHOD.

  METHOD bol.
    ev_sonuc_bolum = iv_num_bol_01 / iv_num_bol_02.
  ENDMETHOD.

ENDCLASS.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_num_01 TYPE i OBLIGATORY,
              p_num_02 TYPE i OBLIGATORY,
              p_sembol TYPE c LENGTH 1.

SELECTION-SCREEN END OF BLOCK a1.

DATA: go_calculator TYPE REF TO lcl_calculator,
      gv_sonuc      TYPE i.

START-OF-SELECTION.

  CREATE OBJECT go_calculator.

  IF p_sembol = '+'.

    go_calculator->topla(
      EXPORTING
        iv_num_topla_01 = p_num_01
        iv_num_topla_02 = p_num_02
      IMPORTING
        ev_sonuc_toplam = gv_sonuc ).

  ELSEIF p_sembol = '-'.

    go_calculator->cikar(
      EXPORTING
        iv_num_cikar_01  = p_num_01
        iv_num_cikar_02  = p_num_02
      IMPORTING
        ev_sonuc_cikarma = gv_sonuc ).

  ELSEIF p_sembol = '*'.

    go_calculator->carp(
      EXPORTING
        iv_num_carp_01  = p_num_01
        iv_num_carp_02  = p_num_02
      IMPORTING
        ev_sonuc_carpim = gv_sonuc ).

  ELSEIF p_sembol = '/'.

    go_calculator->bol(
      EXPORTING
        iv_num_bol_01  = p_num_01
        iv_num_bol_02  = p_num_02
      IMPORTING
        ev_sonuc_bolum = gv_sonuc ).

  ELSE.
    MESSAGE text-002 TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.
  ENDIF.

  WRITE: gv_sonuc.
