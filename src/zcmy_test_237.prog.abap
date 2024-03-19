*&---------------------------------------------------------------------*
*& Report ZCM_TEST_237
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_237.

DATA: gt_table TYPE SORTED TABLE OF scarr WITH NON-UNIQUE KEY carrname,
      gs_scarr TYPE scarr.

select * FROM scarr INTO TABLE gt_table.


SELECT SINGLE * FROM scarr INTO gs_scarr WHERE carrid = 'AA'.

  INSERT gs_scarr INTO TABLE gt_table.
  BREAK-POINT.
