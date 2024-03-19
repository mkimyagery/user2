*&---------------------------------------------------------------------*
*& Report ZCM_TEST_175
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_175.

DATA: gv_1 TYPE c LENGTH 3 VALUE '100',
      gv_2 TYPE c LENGTH 3 VALUE '10A',
      gv_3 TYPE c LENGTH 3 VALUE '200',
      gv_4 TYPE c LENGTH 3 VALUE '$4%'.

IF gv_1 CN '0123456789'.
  WRITE: 'gv_1 degiskeni ile matematiksel islem yapilamaz.'.
ELSE.
  WRITE: 'gv_1 degiskeni ile matematiksel islem yapilabilir.'.
ENDIF.

IF gv_2 CN '0123456789'.
  WRITE: / 'gv_2 degiskeni ile matematiksel islem yapilamaz.'.
ELSE.
  WRITE: / 'gv_2 degiskeni ile matematiksel islem yapilabilir.'.
ENDIF.

IF gv_3 CN '0123456789'.
  WRITE: / 'gv_3 degiskeni ile matematiksel islem yapilamaz.'.
ELSE.
  WRITE: / 'gv_3 degiskeni ile matematiksel islem yapilabilir.'.
ENDIF.

IF gv_4 CN '0123456789'.
  WRITE: / 'gv_4 degiskeni ile matematiksel islem yapilamaz.'.
ELSE.
  WRITE: / 'gv_4 degiskeni ile matematiksel islem yapilabilir.'.
ENDIF.
