class ZYFLIGHT_DATA_SELECT definition
  public
  final
  create public .

public section.

  class-data GT_SCARR type ZCM_TT_SCARR .

  class-methods GET_SCARR
    importing
      !IV_CARRID type S_CARR_ID
    exporting
      !ET_SCARR type ZCM_TT_SCARR .
  class-methods GET_SPFLI
    importing
      !IV_CARRID type S_CARR_ID
    exporting
      !ET_SPFLI type ZCM_TT_SPFLI .
  class-methods GET_SFLIGHT
    importing
      !IV_CARRID type S_CARR_ID
    exporting
      !ET_SFLIGHT type ZCM_TT_SFLIGHT .
  class-methods GET_ALL
    importing
      !IV_CARRID type S_CARR_ID
    exporting
      !ET_SCARR type ZCM_TT_SCARR
      !ET_SPFLI type ZCM_TT_SPFLI
      !ET_SFLIGHT type ZCM_TT_SFLIGHT .
protected section.
private section.
ENDCLASS.



CLASS ZYFLIGHT_DATA_SELECT IMPLEMENTATION.


  METHOD GET_ALL.

*    SELECT * FROM scarr
*      INTO TABLE et_scarr
*      WHERE carrid = iv_carrid.

    get_scarr(
      EXPORTING
        iv_carrid = iv_carrid
      IMPORTING
        et_scarr  = et_scarr ).

*    SELECT * FROM spfli
*      INTO TABLE et_spfli
*      WHERE carrid = iv_carrid.

    get_spfli(
      EXPORTING
        iv_carrid = iv_carrid
      IMPORTING
        et_spfli  = et_spfli ).


*    SELECT * FROM sflight
*      INTO TABLE et_sflight
*      WHERE carrid = iv_carrid.

    get_sflight(
      EXPORTING
        iv_carrid  = iv_carrid
      IMPORTING
        et_sflight = et_sflight ).

  ENDMETHOD.


  METHOD GET_SCARR.

    SELECT * FROM scarr
      INTO TABLE et_scarr
      WHERE carrid = iv_carrid.

  ENDMETHOD.


  METHOD GET_SFLIGHT.

    SELECT * FROM sflight
      INTO TABLE et_sflight
      WHERE carrid = iv_carrid.

  ENDMETHOD.


  METHOD GET_SPFLI.

    SELECT * FROM spfli
      INTO TABLE et_spfli
      WHERE carrid = iv_carrid.

  ENDMETHOD.
ENDCLASS.
