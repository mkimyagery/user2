*&---------------------------------------------------------------------*
*& Report ZCM_TEST_295
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_295.

*FIELD-SYMBOLS: <fs_scarr> TYPE ZCM_TT_SCARR.

START-OF-SELECTION.

SELECT * FROM scarr INTO TABLE @DATA(gt_scarr).

LOOP AT gt_scarr ASSIGNING FIELD-SYMBOL(<fs_scarr>).

  ASSIGN COMPONENT 'CARRID' OF STRUCTURE <fs_scarr> to FIELD-SYMBOL(<fs_hucre>).
  IF <fs_hucre> IS ASSIGNED.
    WRITE: <fs_hucre>.
  ENDIF.

  SKIP.
ENDLOOP.

SELECT * FROM spfli INTO TABLE @DATA(gt_spfli).

*  LOOP AT gt_spfli ASSIGNING <fs_scarr>.
*
*  ENDLOOP.

BREAK-POINT.
