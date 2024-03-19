*&---------------------------------------------------------------------*
*& Report ZCM_TEST_240
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_240.

*TYPES: BEGIN OF gty_table,
*         sirket_id  TYPE n LENGTH 3,
*         calisan_id TYPE n LENGTH 3,
*         name       TYPE c LENGTH 20,
*         sname      TYPE c LENGTH 20,
*       END OF gty_table.

DATA: gt_table_1 TYPE STANDARD TABLE OF zcm_test_11,
      gt_table_2 TYPE SORTED TABLE OF zcm_test_11 WITH UNIQUE KEY sirket_id calisan_id,
      gs_str     TYPE zcm_test_11.



START-OF-SELECTION.

  gs_str-sirket_id  = 23.
  gs_str-calisan_id = 23.
  gs_str-name       = 'Hande'.
  gs_str-sname      = 'Canan'.
  INSERT gs_str INTO TABLE gt_table_2.
  CLEAR: gs_str.

  gs_str-sirket_id  = 23.
  gs_str-calisan_id = 24.
  gs_str-name       = 'Tarik'.
  gs_str-sname      = 'Öztürk'.
  INSERT gs_str INTO TABLE gt_table_2.
  CLEAR: gs_str.

  gs_str-sirket_id  = 23.
  gs_str-calisan_id = 22.
  gs_str-name       = 'Erkin'.
  gs_str-sname      = 'Öztürk'.
  INSERT gs_str INTO TABLE gt_table_2.
  CLEAR: gs_str.

  gs_str-sirket_id  = 23.
  gs_str-calisan_id = 24.
  gs_str-name       = 'Mustafa'.
  gs_str-sname      = 'Öztürk'.
  INSERT gs_str INTO TABLE gt_table_2.
  CLEAR: gs_str.
