*&---------------------------------------------------------------------*
*& Report ZABAP_CM_0094
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_cmy_0094.

CALL FUNCTION 'ENQUEUE_EZCM_STRAVELAG2'
  EXPORTING
    mode_zcm_stravelag = 'E'
    mandt              = sy-mandt
    id                 = '0001'
    agencynum          = '00000055'
  EXCEPTIONS
    foreign_lock       = 1
    system_failure     = 2
    OTHERS             = 3.

UPDATE zcm_stravelag SET name = 'AlpaslanV2'
                     WHERE id = '0001' AND
                           agencynum = '00000055'.

*SELECT SINGLE * FROM zcm_stravelag INTO @DATA(gs_1) WHERE id = 1.
BREAK-POINT.
