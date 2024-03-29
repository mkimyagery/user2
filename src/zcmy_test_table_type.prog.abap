*&---------------------------------------------------------------------*
*& Report ZCM_TEST_TABLE_TYPE
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_table_type.

DATA: gs_structure TYPE zmc_structure_003,
      gt_table     TYPE zmc_table_type_001,
      gt_1 TYPE TABLE OF sflight.

START-OF-SELECTION.

  gs_structure-pc_brand          = 'HP'.
  gs_structure-pc_model          = 'EliteBook 850 G8'.
  gs_structure-pc_harddisk       = '1 TB SSD'.
  gs_structure-pc_ram            = '16 GB'.
  gs_structure-pc_screen         = '15 Inch'.
  gs_structure-pc_price          = '1255.99'.
  gs_structure-pc_curr           = 'EUR'.
  gs_structure-pc_no_usb         = 3.
  gs_structure-pc_no_typec       = 2.
  gs_structure-pc_keyboard_light = abap_false.

  APPEND gs_structure TO gt_table.
  CLEAR: gs_structure.

  gs_structure-pc_brand          = 'ASUS'.
  gs_structure-pc_model          = 'Vivobook S 14'.
  gs_structure-pc_harddisk       = '512 GB SSD'.
  gs_structure-pc_ram            = '8 GB'.
  gs_structure-pc_screen         = '13 Inch'.
  gs_structure-pc_price          = '976.49'.
  gs_structure-pc_curr           = 'EUR'.
  gs_structure-pc_no_usb         = 2.
  gs_structure-pc_no_typec       = 1.
  gs_structure-pc_keyboard_light = abap_true.

  APPEND gs_structure TO gt_table.
  CLEAR: gs_structure.

  gs_structure-pc_brand          = 'APPLE'.
  gs_structure-pc_model          = 'MacBook Air'.
  gs_structure-pc_harddisk       = '1 TB SSD'.
  gs_structure-pc_ram            = '32 GB'.
  gs_structure-pc_screen         = '16 Inch'.
  gs_structure-pc_price          = '1899.29'.
  gs_structure-pc_curr           = 'EUR'.
  gs_structure-pc_no_usb         = 2.
  gs_structure-pc_no_typec       = 2.
  gs_structure-pc_keyboard_light = abap_false.

  APPEND gs_structure TO gt_table.
  CLEAR: gs_structure.

  LOOP AT gt_table INTO gs_structure FROM 2 TO 3.
    WRITE: gs_structure-pc_brand,
           gs_structure-pc_model,
           gs_structure-pc_harddisk,
           gs_structure-pc_ram,
           gs_structure-pc_screen,
           gs_structure-pc_price,
           gs_structure-pc_curr,
           gs_structure-pc_no_usb,
           gs_structure-pc_no_typec,
           gs_structure-pc_keyboard_light.
    CLEAR: gs_structure.
    SKIP.
  ENDLOOP.
