*&---------------------------------------------------------------------*
*& Report ZCM_TEST_291
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_291.

DATA: gv_text_1 TYPE c LENGTH 15,
      gv_text_2 TYPE string,
      gv_number TYPE i,
      gv_date TYPE datum,
      gv_time TYPE uzeit.


gv_text_1 = 'Text 001'.
gv_text_2 = 'Text 002'.
gv_number = 10.
gv_date   = '20201215'. "YYYYMMDD
gv_time   = '190000'.

"Abap 7.40 sonrasi.

DATA(gv_text_1_yeni) = 'Text 001'.
DATA(gv_text_2_yeni) = 'Text 002'.
DATA(gv_number_new)  = 50.
DATA(gv_date_new)    = sy-datum.
DATA(gv_time_new)    = sy-uzeit.

BREAK-POINT.
