*&---------------------------------------------------------------------*
*& Report ZCM_TEST_267
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_267.

*DATA: gv_v1 TYPE c LENGTH 10,
*      gv_v2 TYPE n LENGTH 6,
*      gv_v3 TYPE datum,
*      gv_v4 TYPE uzeit,
*      gv_v5 TYPE i,
*      gv_v6 TYPE p DECIMALS 4,
*      gv_v7 TYPE string.
*
*FIELD-SYMBOLS: <gv_v1> TYPE c,
*               <gv_v2> TYPE n,
*               <gv_v3> TYPE datum,
*               <gv_v4> TYPE uzeit,
*               <gv_v5> TYPE i,
*               <gv_v6> TYPE p,
*               <gv_v7> TYPE string,
*               <gv_v8> TYPE any.
*
*ASSIGN gv_v1 TO <gv_v8>.
*ASSIGN gv_v2 TO <gv_v8>.
*ASSIGN gv_v3 TO <gv_v8>.
*ASSIGN gv_v4 TO <gv_v8>.
*ASSIGN gv_v5 TO <gv_v8>.
*ASSIGN gv_v6 TO <gv_v8>.
*ASSIGN gv_v7 TO <gv_v8>.

PARAMETERS: p_1 RADIOBUTTON GROUP abc,
            p_2 RADIOBUTTON GROUP abc,
            p_3 RADIOBUTTON GROUP abc.

FIELD-SYMBOLS: <fs_table> TYPE ANY TABLE.

DATA: gv_number TYPE i VALUE 1.

START-OF-SELECTION.

  SELECT * FROM zcm_stravelag INTO TABLE @DATA(gt_table).

  ASSIGN gt_table TO <fs_table>.

  LOOP AT <fs_table> ASSIGNING FIELD-SYMBOL(<fs_str>).
    DO.
      ASSIGN COMPONENT gv_number OF STRUCTURE <fs_str> TO FIELD-SYMBOL(<fs_field>).
      IF sy-subrc IS INITIAL.
        WRITE: <fs_field>.
      ELSE.
        EXIT.
      ENDIF.

      gv_number = gv_number + 1.

      IF p_1 IS NOT INITIAL.
        IF gv_number > 3.
          EXIT.
        ENDIF.
      ELSEIF p_2 IS NOT INITIAL.
        IF gv_number > 6.
          EXIT.
        ENDIF.
      ENDIF.
    ENDDO.

    gv_number = 1.
    SKIP.

  ENDLOOP.
