*&---------------------------------------------------------------------*
*& Report ZCM_TEST_271
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_271.

DATA: gv_text    TYPE string VALUE 'Field sembol kullanimi örnek rapor',
      gs_scarr   TYPE scarr,
      gt_spfli   TYPE TABLE OF spfli,
      gt_sflight TYPE TABLE OF sflight,
      gt_scarr   TYPE TABLE OF scarr.

FIELD-SYMBOLS: <fs_genel> TYPE any,
               <fs_hucre> TYPE any,
               <fs_str>   TYPE any,
               <fs_table> TYPE ANY TABLE.

START-OF-SELECTION.

  SELECT * FROM sflight INTO TABLE gt_sflight.
  SELECT * FROM spfli INTO TABLE gt_spfli.
  SELECT * FROM scarr INTO TABLE gt_scarr.

  ASSIGN gt_sflight TO <fs_table>.
  ASSIGN gt_spfli TO <fs_table>.
  ASSIGN gt_scarr TO <fs_table>.




  BREAK-POINT.
