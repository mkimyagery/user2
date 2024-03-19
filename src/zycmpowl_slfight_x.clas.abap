class ZYCMPOWL_SLFIGHT_X definition
  public
  final
  create public .

public section.

  interfaces IF_POWL_FEEDER .
protected section.
private section.
ENDCLASS.



CLASS ZYCMPOWL_SLFIGHT_X IMPLEMENTATION.


  method IF_POWL_FEEDER~GET_ACTIONS.
  endmethod.


  method IF_POWL_FEEDER~GET_ACTION_CONF.
  endmethod.


  method IF_POWL_FEEDER~GET_DETAIL_COMP.
  endmethod.


  method IF_POWL_FEEDER~GET_FIELD_CATALOG.
  endmethod.


  method IF_POWL_FEEDER~GET_OBJECTS.

    DATA: lt_carrid_range TYPE RANGE OF s_carr_id,
          lt_connid_range TYPE RANGE OF s_conn_id,
          lt_results      TYPE zcm_tt_sflight,
          lv_sonuc        TYPE p DECIMALS 2.

    "Secim ekranindan gelen degerleri kullanarak CARRID ve CONNID icin range olusturalim.
    LOOP AT i_selcrit_values INTO DATA(ls_selcrit_value).
      CASE ls_selcrit_value-selname.
        WHEN 'CARRID'.
          APPEND INITIAL LINE TO lt_carrid_range ASSIGNING FIELD-SYMBOL(<fs_carrid_range>).
          <fs_carrid_range>-sign   = ls_selcrit_value-sign.
          <fs_carrid_range>-option = ls_selcrit_value-option.
          <fs_carrid_range>-low    = ls_selcrit_value-low.
          <fs_carrid_range>-high   = ls_selcrit_value-high.
        WHEN 'CONNID'.
          APPEND INITIAL LINE TO lt_connid_range ASSIGNING FIELD-SYMBOL(<fs_connid_range>).
          <fs_connid_range>-sign   = ls_selcrit_value-sign.
          <fs_connid_range>-option = ls_selcrit_value-option.
          <fs_connid_range>-low    = ls_selcrit_value-low.
          <fs_connid_range>-high   = ls_selcrit_value-high.
      ENDCASE.
    ENDLOOP.

    "Range tablolarini kullanarak veri cekelim.
    SELECT * FROM sflight
      INTO TABLE e_results
      WHERE carrid IN lt_carrid_range AND
            connid IN lt_connid_range.

  endmethod.


  method IF_POWL_FEEDER~GET_OBJECT_DEFINITION.
    e_object_def ?= cl_abap_tabledescr=>describe_by_name( 'ZCM_TT_SFLIGHT_X' ).

  endmethod.


  method IF_POWL_FEEDER~GET_SEL_CRITERIA.

    APPEND INITIAL LINE TO c_selcrit_defs ASSIGNING FIELD-SYMBOL(<fs_selcrit>).
    <fs_selcrit>-selname     = 'CARRID'.    "Ekranda görünecek isim.
    <fs_selcrit>-kind        = 'S'.         "Select-Options seklinde görünecek.
    <fs_selcrit>-param_type  = 'I'.         "Inclusive.
    <fs_selcrit>-selopt_type = 'A'.         "Coklu secime imkan taniyacak.
    <fs_selcrit>-datatype    = 'S_CARR_ID'. "Bu hücreye girilebilecek verinin tipi.

    APPEND INITIAL LINE TO c_selcrit_defs ASSIGNING <fs_selcrit>.
    <fs_selcrit>-selname     = 'CONNID'.   "Ekranda görünecek isim.
    <fs_selcrit>-kind        = 'S'.        "Select-Options seklinde görünecek.
    <fs_selcrit>-param_type  = 'I'.        "Inclusive.
    <fs_selcrit>-selopt_type = 'A'.        "Coklu secime imkan taniyacak.
    <fs_selcrit>-datatype    = 'S_CONN_ID'."Bu hücreye girilebilecek verinin tipi.

    e_selcrit_defs_changed = abap_true. "Secim kriterleri düzenlendi.

  endmethod.


  method IF_POWL_FEEDER~HANDLE_ACTION.
  endmethod.
ENDCLASS.
