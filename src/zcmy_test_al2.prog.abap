*&---------------------------------------------------------------------*
*& Report ZCM_TEST_AL2
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_al2.

TYPES: BEGIN OF gty_table,
         id       TYPE zcm_de_id,
         yil      TYPE c LENGTH 4,
         kul_izin TYPE int1,
       END OF gty_table.

DATA: gv_is_gunu TYPE i,
      gv_date    TYPE datum,
      gt_izin    TYPE TABLE OF gty_table.

START-OF-SELECTION.

  SELECT * FROM zcm_tablo_1 INTO TABLE @DATA(gt_tablo_1).
  SELECT * FROM zcm_tablo_2 INTO TABLE @DATA(gt_tablo_2).

  LOOP AT gt_tablo_2 ASSIGNING FIELD-SYMBOL(<fs_str>).
    READ TABLE gt_izin ASSIGNING FIELD-SYMBOL(<fs_izin>) WITH KEY id = <fs_str>-id yil = <fs_str>-yil.
    IF sy-subrc IS NOT INITIAL.
      APPEND INITIAL LINE TO gt_izin ASSIGNING <fs_izin>.
      <fs_izin>-id       = <fs_str>-id.
      <fs_izin>-yil      = <fs_str>-yil.
      <fs_izin>-kul_izin = <fs_str>-kul_izin.
    ELSE.
      <fs_izin>-kul_izin = <fs_izin>-kul_izin + <fs_str>-kul_izin.
    ENDIF.
  ENDLOOP.

  LOOP AT gt_tablo_2 ASSIGNING <fs_str>.

    READ TABLE gt_tablo_1 INTO DATA(gs_tablo_1) WITH KEY id = <fs_str>-id.
    IF sy-subrc IS INITIAL.
      READ TABLE gt_izin ASSIGNING <fs_izin> WITH KEY id = <fs_str>-id yil = <fs_str>-yil.
      IF sy-subrc IS INITIAL.

        IF <fs_izin>-kul_izin =< gs_tablo_1-izin_hakki.

          gv_date = <fs_str>-izin_bitis + 1.

          CALL FUNCTION 'HR_RO_WORKDAYS_IN_INTERVAL'
            EXPORTING
              begda   = gv_date
              endda   = gv_date
              mofid   = '08'
            CHANGING
              wrkdays = gv_is_gunu.

          IF gv_is_gunu = 1.
            <fs_str>-izin_bitis = gv_date.
            <fs_str>-kul_izin   = <fs_str>-kul_izin + 1.
            <fs_izin>-kul_izin  = <fs_izin>-kul_izin + 1.
          ENDIF.
        ENDIF.
      ENDIF.
    ENDIF.

  ENDLOOP.
