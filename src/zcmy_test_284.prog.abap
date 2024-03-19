*&---------------------------------------------------------------------*
*& Report ZCM_TEST_284
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_284.

DATA: gv_1 TYPE c LENGTH 10,
      gv_2 TYPE n  LENGTH 5,
      gv_3 TYPE datum,
      gv_4 TYPE uzeit,
      gv_5 TYPE i,
      gv_6 TYPE p DECIMALS 3,
      gv_7 TYPE string.

FIELD-SYMBOLS: <fs_1> TYPE c,
               <fs_2> TYPE n,
               <fs_3> TYPE datum,
               <fs_4> TYPE uzeit,
               <fs_5> TYPE i,
               <fs_6> TYPE p,
               <fs_7> TYPE string.

gv_1 = 'Örnek Text'.
gv_2 = '12345'.
gv_3 = '20240222'.
gv_4 = '185300'.
gv_5 = 100.
gv_6 = 5 / 7.
gv_7 = 'Örnek string tipinde text'.

ASSIGN gv_1 TO <fs_1>.
ASSIGN gv_2 TO <fs_2>.
ASSIGN gv_3 TO <fs_3>.
ASSIGN gv_4 TO <fs_4>.
ASSIGN gv_5 TO <fs_5>.
ASSIGN gv_6 TO <fs_6>.
ASSIGN gv_7 TO <fs_7>.

*WRITE: <fs_1>, <fs_2>, <fs_3>, <fs_4>, <fs_5>, <fs_6>, <fs_7>.
*
*UNASSIGN: <fs_1>, <fs_2>, <fs_3>, <fs_4>, <fs_5>, <fs_6>, <fs_7>.


DATA: gs_scarr TYPE scarr.

FIELD-SYMBOLS: <fs_any> TYPE any.

SELECT SINGLE * FROM scarr INTO gs_scarr.

  ASSIGN COMPONENT 'CARRID' OF STRUCTURE gs_scarr to <fs_any>.
  IF <fs_any> IS ASSIGNED.
    WRITE: <fs_any>.
    UNASSIGN: <fs_any>.
  ENDIF.

  ASSIGN COMPONENT 'CONNID' OF STRUCTURE gs_scarr to <fs_any>.
  IF <fs_any> IS ASSIGNED.
    WRITE: <fs_any>.
    UNASSIGN: <fs_any>.
  ENDIF.

  BREAK-POINT.





*BREAK-POINT.
