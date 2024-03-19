*&---------------------------------------------------------------------*
*& Report ZCM_TEST_248
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_248.

"Abap 7.40 öncesi.
DATA: gv_text_1 TYPE c LENGTH 15,
      gv_text_2 TYPE string,
      gv_number TYPE i,
      gv_date   TYPE datum,
      gv_time   TYPE uzeit.

gv_text_1 = 'Deneme text 001'.
gv_text_2 = 'Deneme text 002'.
gv_number = 20.
gv_date   = sy-datum.
gv_time   = sy-uzeit.

"Abap 7.40 sonrasi.
DATA(gv_text_1_new) = 'Deneme text 001'.
DATA(gv_text_2_new) = 'Deneme text 002'.
DATA(gv_number_new) = 20.
DATA(gv_date_new)   = sy-datum.
DATA(gv_time_new)   = sy-uzeit.

BREAK-POINT.
