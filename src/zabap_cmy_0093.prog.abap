*&---------------------------------------------------------------------*
*& Report ZABAP_CM_0093
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_cmy_0093.


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
BREAK-POINT.

*CALL FUNCTION 'ENQUEUE_EZCM_STRAVELAG2'
** EXPORTING
**   MODE_ZCM_STRAVELAG       = 'X'
**   MANDT                    = SY-MANDT
**   ID                       =
**   AGENCYNUM                =
**   X_ID                     = ' '
**   X_AGENCYNUM              = ' '
**   _SCOPE                   = '2'
**   _WAIT                    = ' '
**   _COLLECT                 = ' '
** EXCEPTIONS
**   FOREIGN_LOCK             = 1
**   SYSTEM_FAILURE           = 2
**   OTHERS                   = 3
*          .
*IF sy-subrc <> 0.
** Implement suitable error handling here
*ENDIF.
