*&---------------------------------------------------------------------*
*& Report ZCM_TEST_298
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_298.

PARAMETERS: p_number TYPE i.

DATA: gv_day_1 TYPE string,
      gv_day_2 TYPE string.

START-OF-SELECTION.

  "Abap 7.40 öncesi:
  CASE p_number.
    WHEN 1.
      gv_day_1 = 'Pazartesi'.
    WHEN 2.
      gv_day_1 = 'Sali'.
    WHEN 3.
      gv_day_1 = 'Carsamba'.
    WHEN 4.
      gv_day_1 = 'Persembe'.
    WHEN 5.
      gv_day_1 = 'Cuma'.
    WHEN 6.
      gv_day_1 = 'Cumartesi'.
    WHEN 7.
      gv_day_1 = 'Pazar'.
    WHEN OTHERS.
      gv_day_1 = 'Gecersiz gün numarasi'.
  ENDCASE.

  WRITE: gv_day_1.

  "Abap 7.40 sonrasi:
  gv_day_2 = COND #( WHEN p_number = 1 THEN 'Pazartesi'
                     WHEN p_number = 2 THEN 'Sali'
                     WHEN p_number = 3 THEN 'Carsamba'
                     WHEN p_number = 4 THEN 'Persembe'
                     WHEN p_number = 5 THEN 'Cuma'
                     WHEN p_number = 6 THEN 'Cumartesi'
                     WHEN p_number = 7 THEN 'Pazar'
                     ELSE 'Gecersiz gün numarasi' ).

  WRITE: gv_day_2.
