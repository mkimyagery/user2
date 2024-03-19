class ZYCMPOWL_SLFIGHT_YENI definition
  public
  final
  create public .

public section.

  interfaces IF_POWL_FEEDER .
protected section.
private section.
ENDCLASS.



CLASS ZYCMPOWL_SLFIGHT_YENI IMPLEMENTATION.


  METHOD IF_POWL_FEEDER~GET_ACTIONS.

    DATA: ls_action TYPE powl_actdescr_sty,
          ls_ddown  TYPE powl_act_choice_sty.

    ls_action-actionid      = 'ACTION_1'. "Butonun teknik isimlendirmesi.
    ls_action-cardinality   = 'S'.        "Bu butonun kullanilabilmesi icin en az 1 satir secilmis olmak zorundadir.
    ls_action-placement     = 'B'.        "Butonu TOOLBAR üzerinde olustur.
    ls_action-enabled       = abap_true.  "Butonun aktif ve görünür olmasini istiyoruz.
    ls_action-placementindx = 1.
    ls_action-text          = 'KOLTUK BILGISI'. "Butonun üzerinde gösterilecek text.
    ls_action-add_separator = abap_true.

    INSERT ls_action INTO TABLE c_action_defs.
    CLEAR: ls_action.

    "BUTON 2
    ls_action-actionid      = 'ECO'.
    ls_action-cardinality   = 'S'.
    ls_action-placement     = 'B'.
    ls_action-enabled       = abap_true.
    ls_action-placementindx = 2.
    ls_action-text          = 'ECONOMY CLASS'.
    ls_action-add_separator = abap_true.

    ls_ddown-actionid       = 'ECO_ARTI_BIR'.
    ls_ddown-enabled        = abap_true.
    ls_ddown-placementindx  = 1.
    ls_ddown-text           = '1 KOLTUK SATILDI'.

    INSERT ls_ddown INTO TABLE ls_action-act_choices.
    CLEAR: ls_ddown.

    ls_ddown-actionid       = 'ECO_EKSI_BIR'.
    ls_ddown-enabled        = abap_true.
    ls_ddown-placementindx  = 2.
    ls_ddown-text           = '1 KOLTUK IPTAL EDILDI'.

    INSERT ls_ddown INTO TABLE ls_action-act_choices.
    CLEAR: ls_ddown.

    INSERT ls_action INTO TABLE c_action_defs.
    CLEAR: ls_action.

    "BUTON 3
    ls_action-actionid      = 'BUSINESS'.
    ls_action-cardinality   = 'S'.
    ls_action-placement     = 'B'.
    ls_action-enabled       = abap_true.
    ls_action-placementindx = 3.
    ls_action-text          = 'BUSINESS CLASS'.
    ls_action-add_separator = abap_true.

    ls_ddown-actionid       = 'BUS_ARTI_BIR'.
    ls_ddown-enabled        = abap_true.
    ls_ddown-placementindx  = 1.
    ls_ddown-text           = '1 KOLTUK SATILDI'.

    INSERT ls_ddown INTO TABLE ls_action-act_choices.
    CLEAR: ls_ddown.

    ls_ddown-actionid       = 'BUS_EKSI_BIR'.
    ls_ddown-enabled        = abap_true.
    ls_ddown-placementindx  = 2.
    ls_ddown-text           = '1 KOLTUK IPTAL EDILDI'.

    INSERT ls_ddown INTO TABLE ls_action-act_choices.
    CLEAR: ls_ddown.

    INSERT ls_action INTO TABLE c_action_defs.
    CLEAR: ls_action.

    "BUTON 4
    ls_action-actionid      = 'FIRST'.
    ls_action-cardinality   = 'S'.
    ls_action-placement     = 'B'.
    ls_action-enabled       = abap_true.
    ls_action-placementindx = 4.
    ls_action-text          = 'FIRST CLASS'.
    ls_action-add_separator = abap_true.

    ls_ddown-actionid       = 'FIRST_ARTI_BIR'.
    ls_ddown-enabled        = abap_true.
    ls_ddown-placementindx  = 1.
    ls_ddown-text           = '1 KOLTUK SATILDI'.

    INSERT ls_ddown INTO TABLE ls_action-act_choices.
    CLEAR: ls_ddown.

    ls_ddown-actionid       = 'FIRST_EKSI_BIR'.
    ls_ddown-enabled        = abap_true.
    ls_ddown-placementindx  = 2.
    ls_ddown-text           = '1 KOLTUK IPTAL EDILDI'.

    INSERT ls_ddown INTO TABLE ls_action-act_choices.
    CLEAR: ls_ddown.

    INSERT ls_action INTO TABLE c_action_defs.
    CLEAR: ls_action.

    "BUTON 5
    ls_action-actionid      = 'KAYDET'.
    ls_action-cardinality   = 'I'.
    ls_action-placement     = 'B'.
    ls_action-enabled       = abap_true.
    ls_action-placementindx = 5.
    ls_action-text          = 'KAYDET'.
    ls_action-add_separator = abap_true.
    ls_action-imagesource   = '/sap/public/bc/icons/s_F_SAVE.gif'.

    INSERT ls_action INTO TABLE c_action_defs.
    CLEAR: ls_action.

    e_actions_changed = abap_true.

  ENDMETHOD.


  method IF_POWL_FEEDER~GET_ACTION_CONF.
  endmethod.


  method IF_POWL_FEEDER~GET_DETAIL_COMP.
  endmethod.


  METHOD IF_POWL_FEEDER~GET_FIELD_CATALOG.

    DATA: lt_fcat      TYPE lvc_t_fcat,
          ls_fcat_powl TYPE powl_fieldcat_sty.

    CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
      EXPORTING
        i_structure_name       = 'ZCM_S_POWL'
        i_bypassing_buffer     = abap_true
      CHANGING
        ct_fieldcat            = lt_fcat
      EXCEPTIONS
        inconsistent_interface = 1
        program_error          = 2
        OTHERS                 = 3.

    IF sy-subrc IS NOT INITIAL.
      BREAK-POINT.
    ENDIF.

    LOOP AT lt_fcat INTO DATA(ls_fcat).

      ls_fcat_powl-colid          = ls_fcat-fieldname.
      ls_fcat_powl-header_by_ddic = abap_true.
      ls_fcat_powl-col_visible    = abap_true.
      ls_fcat_powl-enabled        = abap_true.
      ls_fcat_powl-colpos         = sy-tabix.
      ls_fcat_powl-allow_sort     = abap_true.
      ls_fcat_powl-allow_filter   = abap_true.

      ls_fcat_powl-color_ref      = 'SATIR_RENK'.

      IF ls_fcat_powl-colid  = 'SATIR_RENK'.
        ls_fcat_powl-technical_col = abap_true.
      ENDIF.

      IF ls_fcat_powl-colid  = 'HUCRE_RENK'.
        ls_fcat_powl-technical_col = abap_true.
      ENDIF.

      IF ls_fcat_powl-colid  = 'PLANETYPE'.
        ls_fcat_powl-color_ref = 'HUCRE_RENK'.
      ENDIF.

      IF ls_fcat_powl-colid  = 'CARRID'.
        CLEAR: ls_fcat_powl-color_ref.
        ls_fcat_powl-color = '04'.
      ENDIF.

      IF ls_fcat_powl-colid  = 'URL'.
        ls_fcat_powl-display_type = 'LU'.
        ls_fcat_powl-text_ref = 'URL'.
      ENDIF.

      IF ls_fcat_powl-colid  = 'PROGRESS_ECO'.
        ls_fcat_powl-display_type = 'PI'.
        ls_fcat_powl-progr_color = '03'.
        ls_fcat_powl-progr_percent_ref = 'ECO_REF'.
      ENDIF.

      IF ls_fcat_powl-colid  = 'ECO_REF'.
        ls_fcat_powl-technical_col = abap_true.
      ENDIF.

      IF ls_fcat_powl-colid  = 'PROGRESS_BUS'.
        ls_fcat_powl-display_type = 'PI'.
        ls_fcat_powl-progr_color = '03'.
        ls_fcat_powl-progr_percent_ref = 'BUS_REF'.
      ENDIF.

      IF ls_fcat_powl-colid  = 'BUS_REF'.
        ls_fcat_powl-technical_col = abap_true.
      ENDIF.

      IF ls_fcat_powl-colid  = 'PROGRESS_FIRST'.
        ls_fcat_powl-display_type = 'PI'.
        ls_fcat_powl-progr_color = '03'.
        ls_fcat_powl-progr_percent_ref = 'FIRST_REF'.
      ENDIF.

      IF ls_fcat_powl-colid  = 'FIRST_REF'.
        ls_fcat_powl-technical_col = abap_true.
      ENDIF.

      INSERT ls_fcat_powl INTO TABLE c_fieldcat.
      CLEAR: ls_fcat_powl.

    ENDLOOP.

    e_fieldcat_changed = abap_true.

  ENDMETHOD.


  METHOD IF_POWL_FEEDER~GET_OBJECTS.

    DATA: lt_carrid_range TYPE RANGE OF s_carr_id,
          lt_connid_range TYPE RANGE OF s_conn_id,
          lt_results      TYPE zcm_tt_sflight_yeni,
          lv_sonuc        TYPE p DECIMALS 2.

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
        WHEN OTHERS.
      ENDCASE.

    ENDLOOP.

    SELECT * FROM zcm_sflight
      INTO CORRESPONDING FIELDS OF TABLE lt_results
      WHERE carrid IN lt_carrid_range AND
            connid IN lt_connid_range.

    SELECT * FROM scarr INTO TABLE @DATA(lt_scarr).

    LOOP AT lt_results ASSIGNING FIELD-SYMBOL(<ls_result>).
        lv_sonuc = <ls_result>-seatsocc / <ls_result>-seatsmax.

        IF lv_sonuc >= ( 4 / 5 ).
          <ls_result>-satir_renk = '11'.
        ENDIF.
    ENDLOOP.

    LOOP AT lt_results ASSIGNING <ls_result>.
      IF <ls_result>-planetype = 'A380-800'.
        <ls_result>-hucre_renk = '16'.
      ELSE.
        <ls_result>-hucre_renk = <ls_result>-satir_renk.
      ENDIF.

      READ TABLE lt_scarr INTO DATA(ls_scarr) WITH KEY carrid = <ls_result>-carrid.
      IF sy-subrc IS INITIAL.
        <ls_result>-url = ls_scarr-url.
      ENDIF.

      <ls_result>-eco_ref   = ( <ls_result>-seatsocc / <ls_result>-seatsmax )     * 100.
      <ls_result>-bus_ref   = ( <ls_result>-seatsocc_b / <ls_result>-seatsmax_b ) * 100.
      <ls_result>-first_ref = ( <ls_result>-seatsocc_f / <ls_result>-seatsmax_f ) * 100.

    ENDLOOP.

    e_results = lt_results.

  ENDMETHOD.


  METHOD IF_POWL_FEEDER~GET_OBJECT_DEFINITION.

    e_object_def ?= cl_abap_tabledescr=>describe_by_name( 'ZCM_TT_SFLIGHT_YENI' ).

  ENDMETHOD.


  METHOD IF_POWL_FEEDER~GET_SEL_CRITERIA.

    APPEND INITIAL LINE TO c_selcrit_defs ASSIGNING FIELD-SYMBOL(<fs_selcrit>).
    <fs_selcrit>-selname     = 'CARRID'.
    <fs_selcrit>-kind        = 'S'.
    <fs_selcrit>-param_type  = 'I'.
    <fs_selcrit>-selopt_type = 'A'.
    <fs_selcrit>-datatype    = 'S_CARR_ID'.

    APPEND INITIAL LINE TO c_selcrit_defs ASSIGNING <fs_selcrit>.
    <fs_selcrit>-selname     = 'CONNID'.
    <fs_selcrit>-kind        = 'S'.
    <fs_selcrit>-param_type  = 'I'.
    <fs_selcrit>-selopt_type = 'A'.
    <fs_selcrit>-datatype    = 'S_CONN_ID'.

    e_selcrit_defs_changed = abap_true.

  ENDMETHOD.


  METHOD IF_POWL_FEEDER~HANDLE_ACTION.

    DATA: lv_eco_bos   TYPE i,
          lv_bus_bos   TYPE i,
          lv_first_bos TYPE i.

    CASE i_actionid.
      WHEN 'ACTION_1'.
        LOOP AT c_selected INTO DATA(ls_selected).

          READ TABLE c_result_tab ASSIGNING FIELD-SYMBOL(<fs_data>) INDEX ls_selected-tabix.
          IF sy-subrc IS INITIAL.
            ASSIGN COMPONENT 'SEATSMAX' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_seatsmax>).
            ASSIGN COMPONENT 'SEATSOCC' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_seatsocc>).

            lv_eco_bos = lv_eco_bos + ( <fs_seatsmax> - <fs_seatsocc> ).

            ASSIGN COMPONENT 'SEATSMAX_B' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_seatsmax_b>).
            ASSIGN COMPONENT 'SEATSOCC_B' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_seatsocc_b>).

            lv_bus_bos = lv_bus_bos + ( <fs_seatsmax_b> - <fs_seatsocc_b> ).

            ASSIGN COMPONENT 'SEATSMAX_F' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_seatsmax_f>).
            ASSIGN COMPONENT 'SEATSOCC_F' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_seatsocc_f>).

            lv_first_bos = lv_first_bos + ( <fs_seatsmax_f> - <fs_seatsocc_f> ).
          ENDIF.
        ENDLOOP.

        APPEND INITIAL LINE TO e_messages ASSIGNING FIELD-SYMBOL(<fs_msg>).
        <fs_msg>-msgid = 'ZCM_MSG_CLASS_1'.
        <fs_msg>-msgnumber = 22.
        <fs_msg>-msgtype = 'I'.
        <fs_msg>-message_v1 = lv_eco_bos.
        <fs_msg>-message_v2 = lv_bus_bos.
        <fs_msg>-message_v3 = lv_first_bos.

      WHEN 'ECO_ARTI_BIR'.

        LOOP AT c_selected INTO ls_selected.
          READ TABLE c_result_tab ASSIGNING <fs_data> INDEX ls_selected-tabix.
          IF sy-subrc IS INITIAL.

            ASSIGN COMPONENT 'CARRID' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_carrid>).
            ASSIGN COMPONENT 'CONNID' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_connid>).
            ASSIGN COMPONENT 'FLDATE' OF STRUCTURE <fs_data> TO FIELD-SYMBOL(<fs_fldate>).

            ASSIGN COMPONENT 'SEATSMAX' OF STRUCTURE <fs_data> TO <fs_seatsmax>.
            ASSIGN COMPONENT 'SEATSOCC' OF STRUCTURE <fs_data> TO <fs_seatsocc>.
            IF <fs_seatsmax> = <fs_seatsocc>.

              APPEND INITIAL LINE TO e_messages ASSIGNING <fs_msg>.
              <fs_msg>-msgid = 'ZCM_MSG_CLASS_1'.
              <fs_msg>-msgnumber = 23.
              <fs_msg>-msgtype = 'W'.
              <fs_msg>-message_v1 = <fs_carrid>.
              <fs_msg>-message_v2 = <fs_connid>.
              <fs_msg>-message_v3 = <fs_fldate>.
              <fs_msg>-message_v4 = 'Economy Cls. satilabilecek koltuk bulunmamaktadir'.

            ELSE.
              <fs_seatsocc> = <fs_seatsocc> + 1.

              APPEND INITIAL LINE TO e_messages ASSIGNING <fs_msg>.
              <fs_msg>-msgid = 'ZCM_MSG_CLASS_1'.
              <fs_msg>-msgnumber = 23.
              <fs_msg>-msgtype = 'S'.
              <fs_msg>-message_v1 = <fs_carrid>.
              <fs_msg>-message_v2 = <fs_connid>.
              <fs_msg>-message_v3 = <fs_fldate>.
              <fs_msg>-message_v4 = 'Economy Cls yeni bir koltuk satildi'.

              e_result_lines_changed = abap_true.
            ENDIF.
          ENDIF.
        ENDLOOP.

      WHEN 'ECO_EKSI_BIR'.

        LOOP AT c_selected INTO ls_selected.
          READ TABLE c_result_tab ASSIGNING <fs_data> INDEX ls_selected-tabix.
          IF sy-subrc IS INITIAL.

            ASSIGN COMPONENT 'CARRID' OF STRUCTURE <fs_data> TO <fs_carrid>.
            ASSIGN COMPONENT 'CONNID' OF STRUCTURE <fs_data> TO <fs_connid>.
            ASSIGN COMPONENT 'FLDATE' OF STRUCTURE <fs_data> TO <fs_fldate>.

            ASSIGN COMPONENT 'SEATSOCC' OF STRUCTURE <fs_data> TO <fs_seatsocc>.

            IF <fs_seatsocc> = 0.

              APPEND INITIAL LINE TO e_messages ASSIGNING <fs_msg>.
              <fs_msg>-msgid = 'ZCM_MSG_CLASS_1'.
              <fs_msg>-msgnumber = 23.
              <fs_msg>-msgtype = 'W'.
              <fs_msg>-message_v1 = <fs_carrid>.
              <fs_msg>-message_v2 = <fs_connid>.
              <fs_msg>-message_v3 = <fs_fldate>.
              <fs_msg>-message_v4 = 'Economy Cls henüz satilan koltuk bulunmamaktadir'.

            ELSE.
              <fs_seatsocc> = <fs_seatsocc> - 1.

              APPEND INITIAL LINE TO e_messages ASSIGNING <fs_msg>.
              <fs_msg>-msgid = 'ZCM_MSG_CLASS_1'.
              <fs_msg>-msgnumber = 23.
              <fs_msg>-msgtype = 'S'.
              <fs_msg>-message_v1 = <fs_carrid>.
              <fs_msg>-message_v2 = <fs_connid>.
              <fs_msg>-message_v3 = <fs_fldate>.
              <fs_msg>-message_v4 = 'Economy Cls bir koltuk satisi iptal edildi'.

              e_result_lines_changed = abap_true.

            ENDIF.
          ENDIF.
        ENDLOOP.

      WHEN 'BUS_ARTI_BIR'.

        LOOP AT c_selected INTO ls_selected.
          READ TABLE c_result_tab ASSIGNING <fs_data> INDEX ls_selected-tabix.
          IF sy-subrc IS INITIAL.

            ASSIGN COMPONENT 'CARRID' OF STRUCTURE <fs_data> TO <fs_carrid>.
            ASSIGN COMPONENT 'CONNID' OF STRUCTURE <fs_data> TO <fs_connid>.
            ASSIGN COMPONENT 'FLDATE' OF STRUCTURE <fs_data> TO <fs_fldate>.

            ASSIGN COMPONENT 'SEATSMAX_B' OF STRUCTURE <fs_data> TO <fs_seatsmax_b>.
            ASSIGN COMPONENT 'SEATSOCC_B' OF STRUCTURE <fs_data> TO <fs_seatsocc_b>.
            IF <fs_seatsmax_b> = <fs_seatsocc_b>.

              APPEND INITIAL LINE TO e_messages ASSIGNING <fs_msg>.
              <fs_msg>-msgid = 'ZCM_MSG_CLASS_1'.
              <fs_msg>-msgnumber = 23.
              <fs_msg>-msgtype = 'W'.
              <fs_msg>-message_v1 = <fs_carrid>.
              <fs_msg>-message_v2 = <fs_connid>.
              <fs_msg>-message_v3 = <fs_fldate>.
              <fs_msg>-message_v4 = 'Business Cls. satilabilecek koltuk bulunmamaktadir'.

            ELSE.
              <fs_seatsocc_b> = <fs_seatsocc_b> + 1.

              APPEND INITIAL LINE TO e_messages ASSIGNING <fs_msg>.
              <fs_msg>-msgid = 'ZCM_MSG_CLASS_1'.
              <fs_msg>-msgnumber = 23.
              <fs_msg>-msgtype = 'S'.
              <fs_msg>-message_v1 = <fs_carrid>.
              <fs_msg>-message_v2 = <fs_connid>.
              <fs_msg>-message_v3 = <fs_fldate>.
              <fs_msg>-message_v4 = 'Business Cls yeni bir koltuk satildi'.

              e_result_lines_changed = abap_true.
            ENDIF.
          ENDIF.
        ENDLOOP.

      WHEN 'BUS_EKSI_BIR'.

        LOOP AT c_selected INTO ls_selected.
          READ TABLE c_result_tab ASSIGNING <fs_data> INDEX ls_selected-tabix.
          IF sy-subrc IS INITIAL.

            ASSIGN COMPONENT 'CARRID' OF STRUCTURE <fs_data> TO <fs_carrid>.
            ASSIGN COMPONENT 'CONNID' OF STRUCTURE <fs_data> TO <fs_connid>.
            ASSIGN COMPONENT 'FLDATE' OF STRUCTURE <fs_data> TO <fs_fldate>.

            ASSIGN COMPONENT 'SEATSOCC_B' OF STRUCTURE <fs_data> TO <fs_seatsocc_b>.

            IF <fs_seatsocc_b> = 0.

              APPEND INITIAL LINE TO e_messages ASSIGNING <fs_msg>.
              <fs_msg>-msgid = 'ZCM_MSG_CLASS_1'.
              <fs_msg>-msgnumber = 23.
              <fs_msg>-msgtype = 'W'.
              <fs_msg>-message_v1 = <fs_carrid>.
              <fs_msg>-message_v2 = <fs_connid>.
              <fs_msg>-message_v3 = <fs_fldate>.
              <fs_msg>-message_v4 = 'Business Cls henüz satilan koltuk bulunmamaktadir'.

            ELSE.
              <fs_seatsocc_b> = <fs_seatsocc_b> - 1.

              APPEND INITIAL LINE TO e_messages ASSIGNING <fs_msg>.
              <fs_msg>-msgid = 'ZCM_MSG_CLASS_1'.
              <fs_msg>-msgnumber = 23.
              <fs_msg>-msgtype = 'S'.
              <fs_msg>-message_v1 = <fs_carrid>.
              <fs_msg>-message_v2 = <fs_connid>.
              <fs_msg>-message_v3 = <fs_fldate>.
              <fs_msg>-message_v4 = 'Business Cls bir koltuk satisi iptal edildi'.

              e_result_lines_changed = abap_true.

            ENDIF.
          ENDIF.
        ENDLOOP.

      WHEN 'FIRST_ARTI_BIR'.

        LOOP AT c_selected INTO ls_selected.
          READ TABLE c_result_tab ASSIGNING <fs_data> INDEX ls_selected-tabix.
          IF sy-subrc IS INITIAL.

            ASSIGN COMPONENT 'CARRID' OF STRUCTURE <fs_data> TO <fs_carrid>.
            ASSIGN COMPONENT 'CONNID' OF STRUCTURE <fs_data> TO <fs_connid>.
            ASSIGN COMPONENT 'FLDATE' OF STRUCTURE <fs_data> TO <fs_fldate>.

            ASSIGN COMPONENT 'SEATSMAX_F' OF STRUCTURE <fs_data> TO <fs_seatsmax_f>.
            ASSIGN COMPONENT 'SEATSOCC_F' OF STRUCTURE <fs_data> TO <fs_seatsocc_f>.
            IF <fs_seatsmax_f> = <fs_seatsocc_f>.

              APPEND INITIAL LINE TO e_messages ASSIGNING <fs_msg>.
              <fs_msg>-msgid = 'ZCM_MSG_CLASS_1'.
              <fs_msg>-msgnumber = 23.
              <fs_msg>-msgtype = 'W'.
              <fs_msg>-message_v1 = <fs_carrid>.
              <fs_msg>-message_v2 = <fs_connid>.
              <fs_msg>-message_v3 = <fs_fldate>.
              <fs_msg>-message_v4 = 'First Cls. satilabilecek koltuk bulunmamaktadir'.

            ELSE.
              <fs_seatsocc_f> = <fs_seatsocc_f> + 1.

              APPEND INITIAL LINE TO e_messages ASSIGNING <fs_msg>.
              <fs_msg>-msgid = 'ZCM_MSG_CLASS_1'.
              <fs_msg>-msgnumber = 23.
              <fs_msg>-msgtype = 'S'.
              <fs_msg>-message_v1 = <fs_carrid>.
              <fs_msg>-message_v2 = <fs_connid>.
              <fs_msg>-message_v3 = <fs_fldate>.
              <fs_msg>-message_v4 = 'First Cls yeni bir koltuk satildi'.

              e_result_lines_changed = abap_true.
            ENDIF.
          ENDIF.
        ENDLOOP.

      WHEN 'FIRST_EKSI_BIR'.

        LOOP AT c_selected INTO ls_selected.
          READ TABLE c_result_tab ASSIGNING <fs_data> INDEX ls_selected-tabix.
          IF sy-subrc IS INITIAL.

            ASSIGN COMPONENT 'CARRID' OF STRUCTURE <fs_data> TO <fs_carrid>.
            ASSIGN COMPONENT 'CONNID' OF STRUCTURE <fs_data> TO <fs_connid>.
            ASSIGN COMPONENT 'FLDATE' OF STRUCTURE <fs_data> TO <fs_fldate>.

            ASSIGN COMPONENT 'SEATSOCC_F' OF STRUCTURE <fs_data> TO <fs_seatsocc_f>.

            IF <fs_seatsocc_f> = 0.

              APPEND INITIAL LINE TO e_messages ASSIGNING <fs_msg>.
              <fs_msg>-msgid = 'ZCM_MSG_CLASS_1'.
              <fs_msg>-msgnumber = 23.
              <fs_msg>-msgtype = 'W'.
              <fs_msg>-message_v1 = <fs_carrid>.
              <fs_msg>-message_v2 = <fs_connid>.
              <fs_msg>-message_v3 = <fs_fldate>.
              <fs_msg>-message_v4 = 'First Cls henüz satilan koltuk bulunmamaktadir'.

            ELSE.
              <fs_seatsocc_f> = <fs_seatsocc_f> - 1.

              APPEND INITIAL LINE TO e_messages ASSIGNING <fs_msg>.
              <fs_msg>-msgid = 'ZCM_MSG_CLASS_1'.
              <fs_msg>-msgnumber = 23.
              <fs_msg>-msgtype = 'S'.
              <fs_msg>-message_v1 = <fs_carrid>.
              <fs_msg>-message_v2 = <fs_connid>.
              <fs_msg>-message_v3 = <fs_fldate>.
              <fs_msg>-message_v4 = 'First Cls bir koltuk satisi iptal edildi'.

              e_result_lines_changed = abap_true.

            ENDIF.
          ENDIF.
        ENDLOOP.

      WHEN 'KAYDET'.
        LOOP AT c_result_tab ASSIGNING <fs_data>.
          ASSIGN COMPONENT 'CARRID' OF STRUCTURE <fs_data> TO <fs_carrid>.
          ASSIGN COMPONENT 'CONNID' OF STRUCTURE <fs_data> TO <fs_connid>.
          ASSIGN COMPONENT 'FLDATE' OF STRUCTURE <fs_data> TO <fs_fldate>.

          ASSIGN COMPONENT 'SEATSOCC'   OF STRUCTURE <fs_data> TO <fs_seatsocc>.
          ASSIGN COMPONENT 'SEATSOCC_B' OF STRUCTURE <fs_data> TO <fs_seatsocc_b>.
          ASSIGN COMPONENT 'SEATSOCC_F' OF STRUCTURE <fs_data> TO <fs_seatsocc_f>.

          UPDATE zcm_sflight SET seatsocc = <fs_seatsocc>
                                 seatsocc_b = <fs_seatsocc_b>
                                 seatsocc_f = <fs_seatsocc_f>
                           WHERE carrid = <fs_carrid> AND
                                 connid = <fs_connid> AND
                                 fldate = <fs_fldate>.
          IF sy-subrc IS NOT INITIAL.
            APPEND INITIAL LINE TO e_messages ASSIGNING <fs_msg>.
            <fs_msg>-msgid     = 'ZCM_MSG_CLASS_1'.
            <fs_msg>-msgnumber = 25.
            <fs_msg>-msgtype   = 'W'.

            RETURN.
          ENDIF.
        ENDLOOP.

        APPEND INITIAL LINE TO e_messages ASSIGNING <fs_msg>.
        <fs_msg>-msgid     = 'ZCM_MSG_CLASS_1'.
        <fs_msg>-msgnumber = 24.
        <fs_msg>-msgtype   = 'S'.

        e_do_refresh = abap_true.

*    	WHEN OTHERS.
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
