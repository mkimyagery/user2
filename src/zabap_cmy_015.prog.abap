*&---------------------------------------------------------------------*
*& Report ZABAP_CM_015
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_cmy_015.

PARAMETERS: p_id  TYPE zcm_de_yeni_id,
            p_url TYPE string LOWER CASE.

DATA: go_update TYPE REF TO zcmtest_stravelag_url_update,
      gv_ok     TYPE c LENGTH 1,
      gv_url    TYPE string,
      gv_sonuc  TYPE c LENGTH 1.

START-OF-SELECTION.

  CREATE OBJECT go_update.

  "Birinci yol.
*go_update->id_kontrol(
*             EXPORTING
*               iv_id = p_id
*             RECEIVING
*               rv_ok = gv_ok ).

  "Ikinci yol
  gv_ok = go_update->id_kontrol( iv_id = p_id ).

  IF gv_ok IS NOT INITIAL.
    gv_url = go_update->url_kontrol( iv_url = p_url ).

    gv_sonuc = go_update->update_url(
                 EXPORTING
                   iv_id  = p_id
                   iv_url = gv_url ).

    IF gv_sonuc IS NOT INITIAL.
      MESSAGE 'Update islemi basarli' TYPE 'S'.
    ELSE.
      MESSAGE 'Update islemi basarisiz' TYPE 'S' DISPLAY LIKE 'E'.
    ENDIF.
  ENDIF.
