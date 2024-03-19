*&---------------------------------------------------------------------*
*& Report ZCM_TEST_234
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_234.

DATA: gv_number TYPE i VALUE 10.

FIELD-SYMBOLS: <gv_fs_number> TYPE i.

START-OF-SELECTION.

ASSIGN gv_number TO <gv_fs_number>.

WRITE: 'Normal degisken: ', gv_number.

WRITE: / 'Field sembol:    ', <gv_fs_number>.

SKIP.

<gv_fs_number> = 20.

WRITE: / 'Normal degisken: ', gv_number.

WRITE: / 'Field sembol:    ', <gv_fs_number>.
