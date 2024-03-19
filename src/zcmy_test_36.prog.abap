*&---------------------------------------------------------------------*
*& Report ZCM_TEST_36
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_36.

"Definitions.
TYPES: BEGIN OF gty_structure,
         id      TYPE n LENGTH 8,
         name    TYPE c LENGTH 40,
         surname TYPE c LENGTH 40,
         job     TYPE c LENGTH 20,
         salary  TYPE i,
         curr    TYPE c LENGTH 3,
         gsm     TYPE string,
         e_mail  TYPE string,
       END OF gty_structure.

DATA: gs_structure TYPE gty_structure,
      gt_table     TYPE TABLE OF gty_structure.

START-OF-SELECTION.

  gs_structure-id      = '20240001'.
  gs_structure-name    = 'Mehmet'.
  gs_structure-surname = 'Yilmaz'.
  gs_structure-job     = 'Teacher'.
  gs_structure-salary  = 4000.
  gs_structure-curr    = 'EUR'.
  gs_structure-gsm     = '+4917672837484'.
  gs_structure-e_mail  = 'mehmetyilmaz@gmail.com'.

  APPEND gs_structure TO gt_table.
  CLEAR: gs_structure.

  gs_structure-id      = '20240002'.
  gs_structure-name    = 'Hande'.
  gs_structure-surname = 'Caner'.
  gs_structure-job     = 'Developer'.
  gs_structure-salary  = 4000.
  gs_structure-curr    = 'EUR'.
  gs_structure-gsm     = '+491767736479'.
  gs_structure-e_mail  = 'handecaner@gmail.com'.

  APPEND gs_structure TO gt_table.
  CLEAR: gs_structure.

  gs_structure-id      = '20240003'.
  gs_structure-name    = 'Ali'.
  gs_structure-surname = 'Öztürk'.
  gs_structure-job     = 'Doctor'.
  gs_structure-salary  = 4500.
  gs_structure-curr    = 'EUR'.
  gs_structure-gsm     = '+491846209484'.
  gs_structure-e_mail  = 'aliozturk@gmail.com'.

  APPEND gs_structure TO gt_table.
  CLEAR: gs_structure.

  READ TABLE gt_table INTO gs_structure INDEX 5.
  IF sy-subrc = 0.
    WRITE: / gs_structure-id,
           / gs_structure-name,
           / gs_structure-surname,
           / gs_structure-job,
           / gs_structure-salary,
           / gs_structure-curr,
           / gs_structure-gsm,
           / gs_structure-e_mail.
  ELSE.
    MESSAGE TEXT-001 TYPE 'I'.

  ENDIF.
