*&---------------------------------------------------------------------*
*& Report ZCM_TEST_302
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_302.

"Abap 7.40 öncesi:
DATA: gv_text TYPE string.

CONCATENATE 'Text 001' 'Text 002' INTO gv_text SEPARATED BY space.

"Abap 7.40 sonrasi
DATA(gv_text_new) = |Text 001| & | | & |Text 002|.

DATA(text_1) = 'Text 001'.
DATA(text_2) = 'Text 002'.

gv_text_new = |{ text_1 }| & | | & |{ text_2 }|.

BREAK-POINT.
