*&---------------------------------------------------------------------*
*& Report ZCM_TEST_244
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_244.
*tables : zcm_fatura_h.
*
*DATA: gt_table TYPE zcm_tt_fno.
*"zcm_fatura_h
*SELECT fatura_no as table_line FROM zcm_fatura_h
*  INTO CORRESPONDING FIELDS OF TABLE gt_table.
*
*BREAK-POINT.
