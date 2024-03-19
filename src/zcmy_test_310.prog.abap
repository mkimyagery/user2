*&---------------------------------------------------------------------*
*& Report ZCM_TEST_310
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_310.

TYPES: BEGIN OF gty_table,
         id      TYPE n LENGTH 6,
         name    TYPE c LENGTH 20,
         surname TYPE c LENGTH 20,
         address TYPE c LENGTH 50,
       END OF gty_table.

TYPES: gtt_table TYPE TABLE OF gty_table WITH NON-UNIQUE KEY address.

DATA: gs_str   TYPE gty_table.
*      gt_table TYPE TABLE OF gty_table.

START-OF-SELECTION.

  "Abap 7.40 Öncesi.
  gs_str-id      = '000001'.
  gs_str-name    = 'Mehmet'.
  gs_str-surname = 'Öztürk'.
  gs_str-address = 'Mehmet Pasa Mh, Ince Sk, 4/5'.
*  APPEND gs_str TO gt_table.
  CLEAR: gs_str.

  "Abap 7.40 sonrasi:
  gs_str = VALUE #( id = '000002'
                    name = 'Ahmet'
                    surname = 'Yilmaz'
                    address = 'Yilmaz Pasa Mh, Ince Sk, 4/5' ).

  DATA(gs_str_new) = VALUE gty_table( id = '000002'
                                      name = 'Ahmet'
                                      surname = 'Yilmaz'
                                      address = 'Yilmaz Pasa Mh, Ince Sk, 4/5' ).


  DATA(gt_table) = VALUE gtt_table( ( id = '000005' name = 'Selim'   surname = 'Baltaci' address = 'Cicek Mh, Bugday Sk, 8/9' )
                                    ( id = '000003' name = 'Aysenur' surname = 'Akar'    address = 'Cankiri Mh, 1024 Sk, 8/9' )
                                    ( id = '000005' name = 'Murat'   surname = 'Erman'   address = 'Uzunyol Mh, 1065 Sk, 8/9' ) ).


  BREAK-POINT.
