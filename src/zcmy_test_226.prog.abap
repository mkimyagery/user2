*&---------------------------------------------------------------------*
*& Report ZCM_TEST_226
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_226.

DATA: gv_carrid TYPE s_carr_id.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
  PARAMETERS: p_table TYPE tabname.

  SELECT-OPTIONS: so_carr FOR gv_carrid.
SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  CASE p_table.
    WHEN 'SCARR'.
      SUBMIT zcm_test_227 WITH so_car_1 IN so_carr AND RETURN.
      MESSAGE 'SCARR tablosunun ALV''si gösterildi.' TYPE 'S'.
    WHEN 'SPFLI'.
      SUBMIT zcm_test_228 WITH so_car_2 IN so_carr AND RETURN.
      MESSAGE 'SPFLI tablosunun ALV''si gösterildi.' TYPE 'S'.
    WHEN 'SFLIGHT'.
      SUBMIT zcm_test_229 WITH so_car_3 IN so_carr AND RETURN.
      MESSAGE 'SFLIGHT tablosunun ALV''si gösterildi.' TYPE 'S'.
  ENDCASE.





































*CASE p_table.
*  WHEN 'SCARR'.
*    SUBMIT zcm_test_227 AND RETURN.
*    WRITE: 'SCARR'.
*  WHEN 'SPFLI'.
*    SUBMIT zcm_test_228 AND RETURN.
*    WRITE: 'SPFLI'.
*  WHEN 'SFLIGHT'.
*    SUBMIT zcm_test_229 AND RETURN.
*    WRITE: 'SFLIGHT'.
*ENDCASE.
