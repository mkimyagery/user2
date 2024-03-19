*&---------------------------------------------------------------------*
*& Report ZCM_TEST_190
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_195.

TYPES: BEGIN OF gty_table,
         id             TYPE zcm_de_id,
         ad             TYPE zcm_de_info_ad,
         soyad          TYPE zcm_de_info_sad,
         izin_baslangic TYPE datum,
         izin_bitis     TYPE datum,
       END OF gty_table.

DATA: gt_tablo_son TYPE TABLE OF gty_table.

START-OF-SELECTION.

  SELECT zcm_tablo_1~id, zcm_tablo_1~ad, zcm_tablo_1~soyad,
         zcm_tablo_2~izin_baslangic, zcm_tablo_2~izin_bitis
    INTO TABLE @gt_tablo_son
    FROM zcm_tablo_1
    LEFT OUTER JOIN zcm_tablo_2
    ON zcm_tablo_1~id = zcm_tablo_2~id.

  SORT gt_tablo_son BY id.

  BREAK-POINT.

*DATA: gt_tablo_1   TYPE TABLE OF zcm_tablo_1,
*      gt_tablo_2   TYPE TABLE OF zcm_tablo_2,
*      gt_tablo_son TYPE TABLE OF gty_table,
*      gs_tablo_1   TYPE zcm_tablo_1,
*      gs_tablo_2   TYPE zcm_tablo_2,
*      gs_tablo_son TYPE gty_table.
*
*START-OF-SELECTION.
*
*  SELECT * FROM zcm_tablo_1
*    INTO TABLE gt_tablo_1.
*
*  SELECT * FROM zcm_tablo_2
*    INTO TABLE gt_tablo_2.
*
*  LOOP AT gt_tablo_1 INTO gs_tablo_1.
*
*    gs_tablo_son-id    = gs_tablo_1-id.
*    gs_tablo_son-ad    = gs_tablo_1-ad.
*    gs_tablo_son-soyad = gs_tablo_1-soyad.
*
*    LOOP AT gt_tablo_2 INTO gs_tablo_2 WHERE id = gs_tablo_1-id.
*      gs_tablo_son-izin_baslangic = gs_tablo_2-izin_baslangic.
*      gs_tablo_son-izin_bitis     = gs_tablo_2-izin_bitis.
*
*      APPEND gs_tablo_son to gt_tablo_son.
*    ENDLOOP.
*
*    CLEAR: gs_tablo_son.
*  ENDLOOP.
*
*  BREAK-POINT.































*TYPES: BEGIN OF gty_table,
*         carrid    TYPE s_carr_id,
*         carrname  TYPE s_carrname,
*         connid    TYPE s_conn_id,
*         fldate    TYPE s_date,
*         price     TYPE s_price,
*         currency  TYPE s_currcode,
*         planetype TYPE s_planetye,
*         seatsmax  TYPE s_seatsmax,
*       END OF gty_table.
*
*DATA: gt_table TYPE TABLE OF gty_table.
*
*
*START-OF-SELECTION.
*
*  SELECT scarr~carrid, scarr~carrname, sflight~connid,
*         sflight~fldate, sflight~price, sflight~currency,
*         sflight~planetype, sflight~seatsmax
*    INTO TABLE @gt_table
*    FROM scarr
*    INNER JOIN sflight
*    ON scarr~carrid = sflight~carrid.
*
*  SELECT scarr~carrid, scarr~carrname, sflight~connid,
*         sflight~fldate, sflight~price, sflight~currency,
*         sflight~planetype, sflight~seatsmax
*    INTO TABLE @DATA(gt_table_2)
*    FROM scarr
*    LEFT OUTER JOIN sflight
*    ON scarr~carrid = sflight~carrid.
*
*
*
*
*
*  BREAK-POINT.
