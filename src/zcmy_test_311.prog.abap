*&---------------------------------------------------------------------*
*& Report ZCM_TEST_310
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_311.

DATA: gs_str TYPE zcm_s_str.

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

  DATA(gs_str_new) = VALUE zcm_s_str( id = '000002'
                                      name = 'Ahmet'
                                      surname = 'Yilmaz'
                                      address = 'Yilmaz Pasa Mh, Ince Sk, 4/5' ).


  DATA(gt_table) = VALUE zcm_tt_tabletype( ( id = '00005'
                                             name = 'Selim'
                                             surname = 'Baltaci'
                                             address = 'Cicek Mh, Bugday Sk, 8/9' )
                                           ( id = '00003'
                                             name = 'Aysenur'
                                             surname = 'Akar'
                                             address = 'Cankiri Mh, 1024 Sk, 8/9' )
                                           ( id = '00005'
                                             name = 'Murat'
                                             surname = 'Erman'
                                             address = 'Uzunyol Mh, 1065 Sk, 8/9' ) ).


  BREAK-POINT.
