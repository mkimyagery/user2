*&---------------------------------------------------------------------*
*& Report ZSG_TEST_01
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_242.
data : gt_table TYPE TABLE OF zcm_fatura_h,
       gt_table2 TYPE TABLE OF zcm_fatura_i,
       gs_table type zcm_fatura_h,
       gs_table2 type zcm_fatura_i.

SELECT * FROM zcm_fatura_h into TABLE gt_table.
SELECT * FROM zcm_fatura_i INTO TABLE gt_table2.

LOOP AT gt_table INTO  gs_table.
  WRITE : / gs_table-fatura_no, gs_table-fatura_tarihi,
            gs_table-muh_sirket, gs_table-tutar, gs_table-para_birimi,
            gs_table-odeme_bilgisi.
LOOP AT gt_table2 INTO gs_table2 WHERE fatura_no = gs_table-fatura_no.
  WRITE : / gs_table2-fatura_no, gs_table2-urun_no, gs_table2-urun_adet,
            gs_table2-birim_fiyati, gs_table2-toplam_fiyat,
            gs_table2-para_birimi.
ENDLOOP.
ENDLOOP.
