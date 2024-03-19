*&---------------------------------------------------------------------*
*& Report ZCM_TEST_174
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_174.

DATA: gv_1 TYPE c LENGTH 3 VALUE '100',
      gv_2 TYPE c LENGTH 3 VALUE '10A',
      gv_3 TYPE c LENGTH 3 VALUE '200',
      gv_4 TYPE c LENGTH 3 VALUE '$4%'.

IF gv_1 CO '0123456789'.
  WRITE: 'gv_1 degiskeni ile matematiksel islem yapilabilir.'.
ELSE.
  WRITE: 'gv_1 degiskeni ile matematiksel islem yapilamaz.'.
ENDIF.

IF gv_2 CO '0123456789'.
  WRITE: / 'gv_2 degiskeni ile matematiksel islem yapilabilir.'.
ELSE.
  WRITE: / 'gv_2 degiskeni ile matematiksel islem yapilamaz.'.
ENDIF.

IF gv_3 CO '0123456789'.
  WRITE: / 'gv_3 degiskeni ile matematiksel islem yapilabilir.'.
ELSE.
  WRITE: / 'gv_3 degiskeni ile matematiksel islem yapilamaz.'.
ENDIF.

IF gv_4 CO '0123456789'.
  WRITE: / 'gv_4 degiskeni ile matematiksel islem yapilabilir.'.
ELSE.
  WRITE: / 'gv_4 degiskeni ile matematiksel islem yapilamaz.'.
ENDIF.
