*&---------------------------------------------------------------------*
*& Report ZCM_TEST_258
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_258.

DATA: gv_carrid TYPE s_carr_id.

PARAMETERS: p_table TYPE tabname.

SELECT-OPTIONS: so_car FOR gv_carrid.

START-OF-SELECTION.

  IF p_table = 'SCARR'.
    SUBMIT zcm_test_259 WITH so_car_1 IN so_car AND RETURN.
    MESSAGE 'SCARR tablosunun ALV*si gösterildi' TYPE 'I'.

  ELSEIF p_table = 'SPFLI'.
    SUBMIT zcm_test_260 WITH so_car_2 IN so_car AND RETURN.
    MESSAGE 'SPFLI tablosunun ALV*si gösterildi' TYPE 'I'.

  ELSEIF p_table = 'SFLIGHT'.
    SUBMIT zcm_test_261 WITH so_car_3 IN so_car AND RETURN.
    MESSAGE 'SFLIGHT tablosunun ALV*si gösterildi' TYPE 'I'.

  ENDIF.
