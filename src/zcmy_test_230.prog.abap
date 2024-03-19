*&---------------------------------------------------------------------*
*& Report ZCM_TEST_230
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_230.


PARAMETERS: p_num TYPE S_AGNCYNUM.

select  SINGLE COUNT(*) from zcm_stravelag
  into @DATA(lv_countw)
                      WHERE city = 'Frankfurt'.

  BREAK-POINT.

select  COUNT(*) from zcm_stravelag
  into @DATA(lv_count)
                      WHERE city = 'Frankfurt'.

  BREAK-POINT.

  SELECT MAX( id ) from zcm_stravelag INTO @DATA(lv_max_id).

    BREAK-POINT.

SELECT max( agencynum ) FROM zcm_stravelag INTO @DATA(lv_max_an).
  BREAK-POINT.

SELECT max( connid ) from sflight INTO @DATA(lv_carrid) WHERE carrid = 'AA'.

  BREAK-POINT.
