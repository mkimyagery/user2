*&---------------------------------------------------------------------*
*& Report ZCM_TEST_204
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_204.

PARAMETERS: p_sifre TYPE c LENGTH 12.

START-OF-SELECTION.

IF p_sifre NA '!"§$%&/()=?,.;:@€'.
  BREAK-POINT.
ENDIF.

IF p_sifre CA ' '.
  BREAK-POINT.
ENDIF.

IF p_sifre NA '0123456789 '.
  BREAK-POINT.
ENDIF.

IF p_sifre NA 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.
  BREAK-POINT.
ENDIF.

IF p_sifre NA 'abcdefghijklmnopqrstuvwxyz'.
  BREAK-POINT.
ENDIF.

IF strlen( p_sifre ) < 8.
  BREAK-POINT.
ENDIF.

WRITE: 'Sifre.'.
