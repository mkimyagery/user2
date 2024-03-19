*&---------------------------------------------------------------------*
*& Report ZCM_TEST_193
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_193.


DATA: gv_product_number   TYPE matnr,
      gv_product_number_2 TYPE matnr,
      gv_no               TYPE i,
      gv_no_2             TYPE i,
      gv_text             TYPE c  LENGTH 40.

PARAMETERS: p_prod TYPE matnr.
*
*gv_product_number = '292837490602.     "Kutu icerisine bu üründen 2 tane sigar.
*gv_product_number = '64758005000'.      "Kutu icerisine bu üründen 42 tane sigar.
gv_product_number = '38475873837388090'. "Kutu icerisine bu üründen 90 tane sigar.
*gv_product_number = '292837490602'.
gv_product_number_2 = 'DSP_876836888'.

"Kosul 1: Tamami sayi ise,
"Talep: Ürün numarasindaki son 0'dan sonraki sayiyi cikart.
"Sifir sondaki sifir veya sifirlar olmayacak.

"Kosul 2: Ürün DSP ile basliyor.

IF p_prod CO '1234567890 '.

  gv_no = strlen( p_prod ) - 1.

  DO.
    gv_no_2 = gv_no_2 + 1.
    gv_text = p_prod+gv_no(gv_no_2).
*    gv_text = p_prod+19(1). "1. Döngü = 20. karakter
*    gv_text = p_prod+18(2). "2. Döngü = Son 2 karakter.
*    gv_text = p_prod+17(3). "3. Döngü = Son 3 karakter.

    IF gv_text CP '0*'.
      IF gv_text CA '123456789'.
        EXIT.
      ENDIF.
    ENDIF.

    gv_no = gv_no - 1.
  ENDDO.

ENDIF.

WRITE: gv_text.

*BREAK-POINT.
