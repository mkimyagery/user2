*&---------------------------------------------------------------------*
*& Report ZCM_TEST_284
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_285.

DATA: gv_1 TYPE c LENGTH 10,
      gv_2 TYPE n  LENGTH 5,
      gv_3 TYPE datum,
      gv_4 TYPE uzeit,
      gv_5 TYPE i,
      gv_6 TYPE p DECIMALS 3,
      gv_7 TYPE string.

FIELD-SYMBOLS: <fs_1> TYPE any.

gv_1 = 'Örnek Text'.
gv_2 = '12345'.
gv_3 = '20240222'.
gv_4 = '185300'.
gv_5 = 100.
gv_6 = 5 / 7.
gv_7 = 'Örnek string tipinde text'.

ASSIGN gv_1 TO <fs_1>.
IF <fs_1> IS ASSIGNED.
  WRITE: <fs_1>.
  UNASSIGN: <fs_1>.
ENDIF.

ASSIGN gv_2 TO <fs_1>.
IF <fs_1> IS ASSIGNED.
  WRITE: <fs_1>.
  UNASSIGN: <fs_1>.
ENDIF.

ASSIGN gv_3 TO <fs_1>.
IF <fs_1> IS ASSIGNED.
  WRITE: <fs_1>.
  UNASSIGN: <fs_1>.
ENDIF.

ASSIGN gv_4 TO <fs_1>.
IF <fs_1> IS ASSIGNED.
  WRITE: <fs_1>.
  UNASSIGN: <fs_1>.
ENDIF.

ASSIGN gv_5 TO <fs_1>.
IF <fs_1> IS ASSIGNED.
  WRITE: <fs_1>.
  UNASSIGN: <fs_1>.
ENDIF.

ASSIGN gv_6 TO <fs_1>.
IF <fs_1> IS ASSIGNED.
  WRITE: <fs_1>.
  UNASSIGN: <fs_1>.
ENDIF.

ASSIGN gv_7 TO <fs_1>.
IF <fs_1> IS ASSIGNED.
  WRITE: <fs_1>.
  UNASSIGN: <fs_1>.
ENDIF.





BREAK-POINT.
