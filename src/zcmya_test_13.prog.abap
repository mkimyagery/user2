*&---------------------------------------------------------------------*
*& Report ZCMA_TEST_13
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmya_test_13.

DATA: gs_structure TYPE zmc_table_001,
      gt_table     TYPE TABLE OF zmc_table_001.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS: p_id     TYPE zmc_table_001-id,
              p_name   TYPE zmc_table_001-name,
              p_sname  TYPE zmc_table_001-surname,
              p_job    TYPE zmc_table_001-job,
              p_slry   TYPE zmc_table_001-salary,
              p_curr   TYPE zmc_table_001-curr,
              p_gsm    TYPE zmc_table_001-gsm,
              p_email  TYPE zmc_table_001-e_mail,
              p_create RADIOBUTTON GROUP abc,
              p_read   RADIOBUTTON GROUP abc,
              p_update RADIOBUTTON GROUP abc,
              p_delete RADIOBUTTON GROUP abc.
SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  IF p_create = abap_true.
    IF p_id IS INITIAL.
      MESSAGE TEXT-002 TYPE 'S' DISPLAY LIKE 'E'.
    ELSE.
      SELECT SINGLE * FROM zmc_table_001 INTO gs_structure WHERE id = p_id.
      IF sy-subrc IS INITIAL.
        MESSAGE TEXT-003 TYPE 'S' DISPLAY LIKE 'E'.
      ELSE.
        gs_structure-id      = p_id.
        gs_structure-name    = p_name.
        gs_structure-surname = p_sname.
        gs_structure-job     = p_job.
        gs_structure-salary  = p_slry.
        gs_structure-curr    = p_curr.
        gs_structure-gsm     = p_gsm.
        gs_structure-e_mail  = p_email.

        INSERT zmc_table_001 FROM gs_structure.
        IF sy-subrc IS INITIAL.
          MESSAGE TEXT-004 TYPE 'S'.
        ELSE.
          MESSAGE TEXT-005 TYPE 'S' DISPLAY LIKE 'E'.
        ENDIF.
      ENDIF.

      CLEAR: gs_structure.
    ENDIF.
  ELSEIF p_read = abap_true.
    IF p_id IS INITIAL.
      SELECT * FROM zmc_table_001 INTO TABLE gt_table.
      IF sy-subrc IS INITIAL.
        LOOP AT gt_table INTO gs_structure.
          WRITE: gs_structure-id,  gs_structure-name,   gs_structure-surname,
                 gs_structure-job, gs_structure-salary, gs_structure-curr,
                 gs_structure-gsm, gs_structure-e_mail.

          CLEAR: gs_structure.
          SKIP.
          ULINE.
        ENDLOOP.
      ELSE.
        MESSAGE TEXT-006 TYPE 'I'.
      ENDIF.
    ELSE.
      SELECT SINGLE * FROM zmc_table_001 INTO gs_structure WHERE id = p_id.
      IF sy-subrc IS INITIAL.
        WRITE: gs_structure-id,  gs_structure-name,   gs_structure-surname,
               gs_structure-job, gs_structure-salary, gs_structure-curr,
               gs_structure-gsm, gs_structure-e_mail.

        CLEAR: gs_structure.
      ELSE.
        MESSAGE TEXT-007 TYPE 'S' DISPLAY LIKE 'E'.
      ENDIF.
    ENDIF.
  ELSEIF p_update = abap_true.
    IF p_id IS INITIAL.
      MESSAGE TEXT-008 TYPE 'S' DISPLAY LIKE 'E'.
    ELSE.
      SELECT SINGLE * FROM zmc_table_001 INTO  gs_structure WHERE id = p_id.
      IF sy-subrc IS INITIAL.
        UPDATE zmc_table_001 SET name     = p_name
                                 surname  = p_sname
                                 job      = p_job
                                 salary   = p_slry
                                 curr     = p_curr
                                 gsm      = p_gsm
                                 e_mail   = p_email WHERE id = p_id.

        IF sy-subrc IS INITIAL.
          MESSAGE TEXT-009 TYPE 'S'.
        ELSE.
          MESSAGE TEXT-010 TYPE 'S' DISPLAY LIKE 'E'.
        ENDIF.
      ELSE.
        MESSAGE TEXT-011 TYPE 'S' DISPLAY LIKE 'E'.
      ENDIF .
    ENDIF.
  ELSEIF p_delete = abap_true.
    IF p_id IS INITIAL.
      MESSAGE TEXT-012 TYPE 'S' DISPLAY LIKE 'E'.
    ELSE.
      SELECT SINGLE * FROM zmc_table_001 INTO  gs_structure WHERE id = p_id.
      IF sy-subrc IS INITIAL.
        DELETE FROM zmc_table_001 WHERE id = p_id.
        IF sy-subrc IS INITIAL.
          MESSAGE TEXT-013 TYPE 'S'.
        ELSE.
          MESSAGE TEXT-014 TYPE 'S' DISPLAY LIKE 'E'.
        ENDIF.
      ELSE.
        MESSAGE TEXT-015 TYPE 'S' DISPLAY LIKE 'E'.
      ENDIF.
    ENDIF.
  ENDIF.



























*DATA: gs_structure TYPE zmc_table_001,
*      gt_table     TYPE TABLE OF zmc_table_001.
*
*START-OF-SELECTION.
*
*  DELETE FROM zmc_table_001 WHERE id = '20240005'.
*
*  SELECT SINGLE * FROM zmc_table_001 INTO gs_structure WHERE id = '20240005'.
*
*  WRITE: sy-subrc.






*  UPDATE zmc_table_001 SET salary = 6000
*                           curr = 'USD'
*                           WHERE id = '20240005'.
*
*  SELECT * FROM zmc_table_001 INTO TABLE gt_table.
*    LOOP AT gt_table INTO gs_structure.
*      insert zmc_table_002 FROM gs_structure.
*    ENDLOOP.

*  DELETE FROM zmc_table_002 WHERE id BETWEEN 0020240002 AND 0020240004.

*
*  CLEAR: gs_structure.
*
*  READ TABLE gt_table INTO gs_structure WITH KEY id = '20240005'.
*  IF sy-subrc IS INITIAL.
*    WRITE: gs_structure-id,  gs_structure-name,   gs_structure-surname,
*           gs_structure-job, gs_structure-salary, gs_structure-curr,
*           gs_structure-gsm, gs_structure-e_mail.
*    CLEAR: gs_structure.
*  ENDIF.



*  gs_structure-id      = '20240005'.
*  gs_structure-name    = 'NEVZAT'.
*  gs_structure-surname = 'DEGIRMENCI'.
*  gs_structure-job     = 'CONSULTANT'.
*  gs_structure-salary  = 5000.
*  gs_structure-curr    = 'EUR'.
*  gs_structure-gsm     = '+4917629047632'.
*  gs_structure-e_mail  = 'NEVZATDEGIRMENCI@GMAIL.COM'.
*
*  INSERT zmc_table_001 FROM gs_structure.
*
*  SELECT * FROM zmc_table_001 INTO TABLE gt_table.
*
*  CLEAR: gs_structure.
*
*  LOOP AT gt_table INTO gs_structure.
*    WRITE: gs_structure-id,  gs_structure-name,   gs_structure-surname,
*           gs_structure-job, gs_structure-salary, gs_structure-curr,
*           gs_structure-gsm, gs_structure-e_mail.
*    CLEAR: gs_structure.
*    SKIP.
*  ENDLOOP.































































*  WRITE: gs_structure-carrid,
*         gs_structure-carrname,
*         gs_structure-currcode,
*         gs_structure-url.
*  SKIP.
*  ULINE.
