*&---------------------------------------------------------------------*
*& Report ZCM_TEST_277
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_277.

TYPES: BEGIN OF gty_table,
         id      TYPE n LENGTH 6,
         name    TYPE c LENGTH 20,
         surname TYPE c LENGTH 20,
         address TYPE c LENGTH 50,
       END OF gty_table.

DATA: gs_str   TYPE gty_table,
      gt_table TYPE TABLE OF gty_table.

START-OF-SELECTION.

  gs_str = VALUE #( id      = '000001'
                    name    = 'Mehmet'
                    surname = 'Arabaci'
                    address = 'Ali Pasa Mh. 1024 Sokak 45/4').

  gt_table = VALUE #( ( id      = '000001'
                        name    = 'Mehmet'
                        surname = 'Arabaci'
                        address = 'Ali Pasa Mh. 1024 Sokak 45/4')
                      ( id      = '000002'
                        name    = 'Aysenur'
                        surname = 'Akar'
                        address = 'Cankiri Mh. 1060 Sokak 23/2')
                      ( id      = '000003'
                        name    = 'Murat'
                        surname = 'Erman'
                        address = 'Uzunyol Mh. 1234 Sokak 56/11') ).

BREAK-POINT.
