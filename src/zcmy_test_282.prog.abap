*&---------------------------------------------------------------------*
*& Report ZCM_TEST_282
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_282.


PARAMETERS: p_num TYPE s_agncynum,
            p_name TYPE s_agncynam.

START-OF-SELECTION.

UPDATE zcm_stravelag SET name        = p_name
                     WHERE agencynum = p_num.
