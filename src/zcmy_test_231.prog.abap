*&---------------------------------------------------------------------*
*& Report ZCM_TEST_231
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_231.

DATA: gt_table TYPE TABLE OF zcm_table_001,
      gs_table TYPE zcm_table_001,
      gv_email TYPE string.

CONSTANTS: gc_mail_sonu TYPE c LENGTH 10 VALUE '@GMAIL.COM'.

START-OF-SELECTION.

  SELECT * FROM zcm_table_001
    WHERE e_mail IS INITIAL
    INTO TABLE @gt_table.

 IF gt_table IS NOT INITIAL.
   LOOP AT gt_table INTO gs_table.

     CONCATENATE gs_table-name gs_table-surname gc_mail_sonu INTO gv_email.

     TRANSLATE gv_email TO LOWER CASE.
     TRANSLATE gv_email USING 'çcöoüuğgıişs'.

     UPDATE zcm_table_001 SET e_mail = gv_email
                          WHERE id   = gs_table-id.

   ENDLOOP.
 ENDIF.
