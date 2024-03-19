*&---------------------------------------------------------------------*
*& Report ZABAP_CM_0252
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_cmy_0252.

PARAMETERS: p_carrid TYPE s_carr_id AS LISTBOX VISIBLE LENGTH 12,
            p_carr_n TYPE s_carr_id,
            p_carrnm TYPE s_carrname,
            p_curr   TYPE s_currcode,
            p_url    TYPE s_carrurl.

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

AT SELECTION-SCREEN.
  IF p_carr_n IS INITIAL.
    SELECT SINGLE * FROM scarr INTO @DATA(gs_scarr) WHERE carrid = @p_carrid.

    p_carr_n = gs_scarr-carrid.
    p_carrnm = gs_scarr-carrname.
    p_curr   = gs_scarr-currcode.
    p_url    = gs_scarr-url.
  ENDIF.


START-OF-SELECTION.
