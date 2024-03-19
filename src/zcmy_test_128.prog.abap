*&---------------------------------------------------------------------*
*& Report ZCM_TEST_128
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_128.

TYPES: BEGIN OF gty_address,
         street   TYPE  char30,
         house_no TYPE  int2,
         pbx_no   TYPE  char5,
         city     TYPE  char30,
       END OF gty_address.

TYPES: BEGIN OF gty_deep_str,
         id      TYPE  zcm_de_id,
         name    TYPE  zcm_de_name,
         surname TYPE  zcm_de_surname,
         address TYPE gty_address,
         gsm     TYPE  zcm_de_gsm,
         e_mail  TYPE  zcm_de_e_mail,
       END OF gty_deep_str.

DATA: gs_structure TYPE gty_deep_str.

START-OF-SELECTION.

  gs_structure-id      = 20240001.
  gs_structure-name    = 'Burak'.
  gs_structure-surname = 'Dogru'.
  gs_structure-address-street   = 'Ilkbahar Caddesi'.
  gs_structure-address-house_no = 25.
  gs_structure-address-pbx_no   = '45863'.
  gs_structure-address-city     = 'IZMIR'.
  gs_structure-gsm     = '+9005553847293'.
  gs_structure-e_mail  = 'burakdogru@gmail.com'.

  BREAK-POINT.
