*&---------------------------------------------------------------------*
*& Report ZABAP_CM_0251
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_cmy_0251.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001."NO INTERVALS.
  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 1(5) TEXT-002.
    SELECTION-SCREEN POSITION 6.
    PARAMETERS : p_carr TYPE S_CARR_ID.

    SELECTION-SCREEN COMMENT 25(7) TEXT-003.
    SELECTION-SCREEN POSITION 32.
    PARAMETERS : p_conn TYPE S_CONN_ID.

    SELECTION-SCREEN COMMENT 47(7) TEXT-004.
    SELECTION-SCREEN POSITION 54.
    PARAMETERS : p_cntfr TYPE LAND1.

  SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK a1.

PARAMETERS: p_carrid TYPE s_carr_id as LISTBOX VISIBLE LENGTH 12,
            p_connid TYPE s_conn_id as LISTBOX VISIBLE LENGTH 10.

DATA: gv_fname  TYPE vrm_id,
      gt_values TYPE vrm_values,
      gs_value  TYPE vrm_value,
      gt_scarr  TYPE TABLE OF scarr.

INITIALIZATION.

  gv_fname = 'P_CARRID'.

  SELECT * FROM scarr INTO TABLE gt_scarr.

    LOOP AT gt_scarr INTO DATA(gs_scarr).
      gs_value-key = gs_scarr-carrid.
      gs_value-text = gs_scarr-carrname.
      APPEND gs_value TO gt_values.
      CLEAR: gs_value.
    ENDLOOP.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id              = gv_fname
      values          = gt_values
    EXCEPTIONS
      id_illegal_name = 1
      OTHERS          = 2.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

  gv_fname = 'P_CONNID'.
  CLEAR: gt_values.

  SELECT * FROM spfli INTO TABLE @DATA(gt_spfli).

    LOOP AT gt_spfli INTO DATA(gs_spfli).
      gs_value-key = gs_spfli-connid.
      gs_value-text = gs_spfli-connid.
      APPEND gs_value TO gt_values.
      CLEAR: gs_value.
    ENDLOOP.

  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id              = gv_fname
      values          = gt_values
    EXCEPTIONS
      id_illegal_name = 1
      OTHERS          = 2.

  IF sy-subrc IS NOT INITIAL.
    LEAVE PROGRAM.
  ENDIF.

at SELECTION-SCREEN.

  SELECT SINGLE * FROM spfli INTO @DATA(gs_spfli_2) WHERE carrid = @p_carrid AND connid = @p_connid.
      p_carr = gs_spfli_2-carrid.
      p_conn = gs_spfli_2-connid.
      p_cntfr = gs_spfli_2-countryfr.

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.
    IF p_carr IS INITIAL.
      IF screen-name = 'P_CARR' OR screen-name = '%_P_CARR_%_APP_%-TEXT' .
        screen-active = 0.
        MODIFY SCREEN.
      ENDIF.
    ELSE.
      IF screen-name = 'P_CARR'.
        screen-input = 0.
        MODIFY SCREEN.
      ENDIF.
    ENDIF.

  ENDLOOP.
