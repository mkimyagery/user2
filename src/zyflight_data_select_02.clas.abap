class ZYFLIGHT_DATA_SELECT_02 definition
  public
  final
  create public .

public section.

  class-methods GET_ALL
    importing
      !IV_CARRID type S_CARR_ID
    exporting
      !ET_SCARR type ZCM_TT_SCARR
      !ET_SPFLI type ZCM_TT_SPFLI
      !ET_SFLIGHT type ZCM_TT_SFLIGHT .
protected section.

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
private section.
ENDCLASS.



CLASS ZYFLIGHT_DATA_SELECT_02 IMPLEMENTATION.


  METHOD GET_ALL.
"Ilk 50 satir
    "Method_01 (Protected) 51. ve 100 satirlar arasindaki islem.
    "Method_02 (Protected) 101. ve 150 satirlar arasindaki islem.
    "Method_03 (Protected) 151. ve 200 satirlar arasindaki islem.
    "Method_04 (Protected) 201. ve 250 satirlar arasindaki islem.
    "Method_05 (Protected) 251. ve 300 satirlar arasindaki islem.
    "Method_06 (Protected) 301. ve 350 satirlar arasindaki islem.
    "Method_07 (Protected) 351. ve 400 satirlar arasindaki islem.
    "Method_08 (Protected) 401. ve 450 satirlar arasindaki islem.

"Son 50 satir

    get_scarr(
  EXPORTING
    iv_carrid = iv_carrid
  IMPORTING
    et_scarr  = et_scarr ).

    get_spfli(
      EXPORTING
        iv_carrid = iv_carrid
      IMPORTING
        et_spfli  = et_spfli ).

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


  method GET_SFLIGHT.

    SELECT * FROM sflight
      INTO TABLE et_sflight
      WHERE carrid = iv_carrid.
  endmethod.


  METHOD GET_SPFLI.
    SELECT * FROM spfli
  INTO TABLE et_spfli
  WHERE carrid = iv_carrid.
  ENDMETHOD.
ENDCLASS.
