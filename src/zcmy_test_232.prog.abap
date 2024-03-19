*&---------------------------------------------------------------------*
*& Report ZCM_TEST_232
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_232.

DATA: gv_number TYPE i,
      gv_id     TYPE zcm_de_yeni_id.


SELECT COUNT(*) FROM zcm_stravelag
  INTO gv_number
  WHERE city = 'Frankfurt'.

  BREAK-POINT.

  CLEAR: gv_number.

SELECT MAX( id ) FROM zcm_stravelag
  INTO gv_id.

  BREAK-POINT.
