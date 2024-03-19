*&---------------------------------------------------------------------*
*& Report ZABAP_CM_023
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_cmy_023.

PARAMETERS: p_id TYPE zcm_de_id as LISTBOX VISIBLE LENGTH 12.

DATA: gv_fname  TYPE vrm_id,
      gt_values TYPE vrm_values,
      gs_value  TYPE vrm_value,
      gs_table_1  TYPE zcm_tablo_1,
      gs_table_2  TYPE zcm_tablo_2,
      gt_table_1  TYPE TABLE OF zcm_tablo_1,
      gt_table_2  TYPE TABLE OF zcm_tablo_2.

INITIALIZATION.

  gv_fname = 'P_ID'.
  CLEAR: gt_values.

  SELECT * FROM zcm_tablo_1 INTO TABLE gt_table_1.

  LOOP AT gt_table_1 INTO gs_table_1.

    gs_value-key  = gs_table_1-id.
    gs_value-text = gs_table_1-ad && | | && gs_table_1-soyad.
    APPEND gs_value TO gt_values.
    CLEAR: gs_value.
  ENDLOOP.

  SORT gt_values BY text.
  DELETE ADJACENT DUPLICATES FROM gt_values COMPARING text.

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

START-OF-SELECTION.

SELECT * FROM zcm_tablo_2 INTO TABLE gt_table_2 WHERE id = p_id.

LOOP AT gt_table_2 INTO gs_table_2 WHERE id = p_id.
  WRITE: gs_table_2-id.
ENDLOOP.
