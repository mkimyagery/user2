*&---------------------------------------------------------------------*
*& Report ZCM_TEST_233
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_233.


PARAMETERS: p_city TYPE city LOWER CASE.

DATA: gv_number_n TYPE n LENGTH 2,
      gv_number_i TYPE i,
      gv_msg    TYPE string,
      gt_table TYPE STANDARD TABLE of scarr WITH KEY carrid.

START-OF-SELECTION.

SELECT COUNT(*) FROM zcm_stravelag
  INTO gv_number_i
  WHERE city = p_city.

  gv_number_n = gv_number_i.

  CONCATENATE p_city 'sehrinde bulunan seyahat acentesi sayisi:' gv_number_n INTO gv_msg SEPARATED BY space.

  MESSAGE gv_msg TYPE 'I'.


*  Production System
*  Quality System
*  Integration System
*
*
*  ---Code Review--- (Manuel, baskasi tarafindan yapilacak)
*  ---ATC---
*
*
*  Development System
