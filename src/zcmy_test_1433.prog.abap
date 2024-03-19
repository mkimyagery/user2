*&---------------------------------------------------------------------*
*& Report ZCM_TEST_1433
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_1433.


DATA: gv_carrid TYPE s_carr_id.

SELECT-OPTIONS: sp_carr FOR gv_carrid.


zflight_data_modeling_22=>test( it_selopt = sp_carr[] ).

BREAK-POINT.
