*&---------------------------------------------------------------------*
*& Report ZMC_TEST_16
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmcy_test_16.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.

  PARAMETERS: p_id     TYPE c LENGTH 8,
              p_name   TYPE c LENGTH 20,
              p_sname  TYPE c LENGTH 20,
              p_deprtm TYPE c LENGTH 15,
              p_team   TYPE c LENGTH 15.

SELECTION-SCREEN END OF BLOCK a1.

DATA: BEGIN OF gs_structure,
        user_id TYPE c LENGTH 8,
        name    TYPE c LENGTH 20,
        sname   TYPE c LENGTH 20,
        deprtm  TYPE c LENGTH 15,
        team    TYPE c LENGTH 15,
      END OF gs_structure.

START-OF-SELECTION.

gs_structure-user_id = p_id.
gs_structure-name    = p_name.
gs_structure-sname   = p_sname.
gs_structure-deprtm  = p_deprtm.
gs_structure-team    = p_team.

WRITE: gs_structure-user_id,
     / gs_structure-name,
     / gs_structure-sname,
     / gs_structure-deprtm,
     / gs_structure-team.
