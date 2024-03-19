*&---------------------------------------------------------------------*
*& Report ZABAP_CM_024
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zabap_cmy_024.

DATA: gv_id TYPE zcm_de_id.

SELECT-OPTIONS: so_id FOR gv_id.

PARAMETERS: p_innerj RADIOBUTTON GROUP abc,
            p_router RADIOBUTTON GROUP abc.

DATA: gt_table_1 TYPE TABLE OF zcm_tablo_1,
      gt_table_2 TYPE TABLE OF zcm_tablo_2.

START-OF-SELECTION.

  IF p_innerj = abap_true.
    SELECT zcm_tablo_1~id, zcm_tablo_1~ad, zcm_tablo_1~soyad,
           zcm_tablo_2~yil, zcm_tablo_2~izin_baslangic, zcm_tablo_2~izin_bitis, zcm_tablo_2~kul_izin
    INTO TABLE @DATA(gt_table)
    FROM zcm_tablo_1
    INNER JOIN zcm_tablo_2
    ON zcm_tablo_1~id = zcm_tablo_2~id
    WHERE zcm_tablo_1~id IN @so_id.
  ELSE.
    SELECT zcm_tablo_1~id, zcm_tablo_1~ad, zcm_tablo_1~soyad,
         zcm_tablo_2~yil, zcm_tablo_2~izin_baslangic, zcm_tablo_2~izin_bitis, zcm_tablo_2~kul_izin
    INTO TABLE @gt_table
    FROM zcm_tablo_1
    LEFT OUTER JOIN zcm_tablo_2
    ON zcm_tablo_1~id = zcm_tablo_2~id
    WHERE zcm_tablo_1~id IN @so_id.
  ENDIF.

  LOOP AT gt_table INTO DATA(gs_table).

  ENDLOOP.
