*&---------------------------------------------------------------------*
*& Report ZCM_TEST_238
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_238.

DATA: gt_scarr TYPE TABLE OF scarr,
      gs_scarr TYPE scarr.


START-OF-SELECTION.

select * FROM scarr
  INTO TABLE gt_scarr.

  LOOP AT gt_scarr INTO gs_scarr.
    IF gs_scarr-currcode = 'EUR'.

      gs_scarr-currcode = 'USD'.
*      MODIFY gt_scarr FROM gs_scarr TRANSPORTING currcode WHERE carrid = gs_scarr-carrid.
      MODIFY gt_scarr FROM gs_scarr INDEX sy-tabix.

    ELSEIF gs_scarr-currcode = 'USD'.

      gs_scarr-currcode = 'EUR'.
*      MODIFY gt_scarr FROM gs_scarr TRANSPORTING currcode WHERE carrid = gs_scarr-carrid.
      MODIFY gt_scarr FROM gs_scarr INDEX sy-tabix.

    ENDIF.

    WRITE: / gs_scarr-carrid, gs_scarr-carrname, gs_scarr-currcode, gs_scarr-url.
  ENDLOOP.
