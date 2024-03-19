*&---------------------------------------------------------------------*
*& Report ZCM_TEST_236
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_236.


PARAMETERS: p_carrid TYPE s_carr_id,
            p_connid TYPE s_conn_id,
            p_number TYPE i.

DATA: gt_sflight  TYPE TABLE OF zcm_sflight,
      gs_sflight  TYPE zcm_sflight,
      gv_fark     TYPE i,
      gv_yeni_max TYPE i,
      gv_yeni_occ TYPE i.

START-OF-SELECTION.

  SELECT * FROM zcm_sflight
    INTO TABLE gt_sflight
    WHERE carrid = p_carrid AND
          connid = p_connid.

  LOOP AT gt_sflight INTO gs_sflight.

    IF ( p_number + gs_sflight-seatsocc ) =< gs_sflight-seatsmax.

      gs_sflight-seatsocc = gs_sflight-seatsocc + p_number.

      UPDATE zcm_sflight SET seatsocc = gs_sflight-seatsocc
                         WHERE carrid = gs_sflight-carrid AND
                               connid = gs_sflight-connid AND
                               fldate = gs_sflight-fldate.

    ELSEIF ( p_number + gs_sflight-seatsocc ) > gs_sflight-seatsmax.
      gv_fark = p_number + gs_sflight-seatsocc - gs_sflight-seatsmax.

      gv_yeni_max = gv_fark + gs_sflight-seatsmax.
      gv_yeni_occ = p_number + gs_sflight-seatsocc.

      UPDATE zcm_sflight SET seatsmax = gv_yeni_max
                             seatsocc = gv_yeni_occ
                         WHERE carrid = gs_sflight-carrid AND
                               connid = gs_sflight-connid AND
                               fldate = gs_sflight-fldate.

      CLEAR: gv_yeni_max, gv_yeni_occ, gv_fark.
    ENDIF.
  ENDLOOP.
