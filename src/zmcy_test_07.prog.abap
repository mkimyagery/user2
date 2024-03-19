*&---------------------------------------------------------------------*
*& Report ZMC_TEST_07
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmcy_test_07.

PARAMETERS: gv_num_1 TYPE i,
            gv_num_2 TYPE i.

DATA: gv_result TYPE i .

IF gv_num_2 = 0.

  MESSAGE 'Yapilmasi imkansiz islem talebi ile karsilasildi' TYPE 'X'.

ENDIF.

gv_result = gv_num_1 / gv_num_2.

WRITE: 'Sonuc: ', gv_result.
