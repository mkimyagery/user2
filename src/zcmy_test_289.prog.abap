*&---------------------------------------------------------------------*
*& Report ZCM_TEST_288
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_289.

PARAMETERS: p_1 RADIOBUTTON GROUP xyz,
            p_2 RADIOBUTTON GROUP xyz,
            p_3 RADIOBUTTON GROUP xyz.

DATA: gt_table TYPE TABLE OF stravelag,
      gv_no    TYPE i VALUE 1.

FIELD-SYMBOLS: <fs_table> TYPE ANY TABLE,
               <fs_satir> TYPE any,
               <fs_hucre> TYPE any.

START-OF-SELECTION.

  SELECT * FROM stravelag INTO TABLE gt_table.

  ASSIGN gt_table TO <fs_table>.

  LOOP AT <fs_table> ASSIGNING <fs_satir>.

    DO.

      ASSIGN COMPONENT gv_no OF STRUCTURE <fs_satir> TO <fs_hucre>.
      IF <fs_hucre> IS ASSIGNED.
        WRITE: <fs_hucre>.
        UNASSIGN: <fs_hucre>.
      ELSE.
        EXIT.
      ENDIF.

      gv_no = gv_no + 1.

      IF p_1 = abap_true.

        IF gv_no > 3.
          EXIT.
        ENDIF.

      ELSEIF p_2 = abap_true.

        IF gv_no > 6.
          EXIT.
        ENDIF.
      ENDIF.
    ENDDO.

    SKIP.
    gv_no = 1.

  ENDLOOP.
