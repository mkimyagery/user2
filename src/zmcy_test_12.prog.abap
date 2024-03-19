*&---------------------------------------------------------------------*
*& Report ZMC_TEST_12
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmcy_test_12.

PARAMETERS: p_day TYPE n. "Alternatif tanimlama--> PARAMETERS: p_day TYPE n.

DATA: gv_day TYPE string,
      gv_msg TYPE string.

CASE p_day.
  WHEN 1.
    gv_day = 'Pazartesi'.
  WHEN 2.
    gv_day = 'Sali'.
  WHEN 3.
    gv_day = 'Carsamba'.
  WHEN 4.
    gv_day = 'Persembe'.
  WHEN 5.
    gv_day = 'Cuma'.
  WHEN 6.
    gv_day = 'Cumartesi'.
  WHEN 7.
    gv_day = 'Pazar'.
  WHEN OTHERS.
    MESSAGE TEXT-001 TYPE 'S' DISPLAY LIKE 'E'.
ENDCASE.

IF p_day BETWEEN 1 AND 7.
  CONCATENATE text-002 gv_day INTO gv_msg SEPARATED BY space.
  MESSAGE gv_msg TYPE 'I'.
ENDIF.

BREAK-POINT.
