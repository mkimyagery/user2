*&---------------------------------------------------------------------*
*& Report ZCM_TEST_266
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_266.



PARAMETERS: p_num  TYPE s_agncynum,
            p_street TYPE s_agncynam.

START-OF-SELECTION.

  UPDATE zcm_stravelag SET street = p_street WHERE agencynum = p_num.
