class ZYCMTEST_HM definition
  public
  final
  create public .

public section.

  methods TOPLAMA
    importing
      !IV_SAYI_TOPLAMA_1 type INT4
      !IV_SAYI_TOPLAMA_2 type INT4
    exporting
      !EV_SONUC_TOPLAMA type INT4 .
  methods CIKARMA
    importing
      !IV_SAYI_CIKARMA_1 type INT4
      !IV_SAYI_CIKARMA_2 type INT4
    exporting
      !EV_SONUC_CIKARMA type INT4 .
  methods CARPMA
    importing
      !IV_SAYI_CARPMA_1 type INT4
      !IV_SAYI_CARPMA_2 type INT4
    exporting
      !EV_SONUC_CARPMA type INT4 .
  methods BOLME
    importing
      !IV_SAYI_BOLME_1 type INT4
      !IV_SAYI_BOLME_2 type INT4
    exporting
      !EV_SONUC_BOLME type INT4 .
  methods ISLEM_KONTROL
    importing
      !IV_SEMBOL type CHAR1
      !IV_SAYI_2 type INT4
    exporting
      !EV_OK type CHAR1 .
protected section.
private section.
ENDCLASS.



CLASS ZYCMTEST_HM IMPLEMENTATION.


  method BOLME.

    ev_sonuc_bolme = iv_sayi_bolme_1 / iv_sayi_bolme_2.

  endmethod.


  method CARPMA.

    ev_sonuc_carpma = iv_sayi_carpma_1 * iv_sayi_carpma_2.

  endmethod.


  method CIKARMA.

    ev_sonuc_cikarma = iv_sayi_cikarma_1 - iv_sayi_cikarma_2.

  endmethod.


  METHOD ISLEM_KONTROL.

    IF iv_sembol = '+' OR iv_sembol = '-' OR
       iv_sembol = '/' OR iv_sembol = '*' .

      ev_ok = abap_true.

    ENDIF.

    IF iv_sembol = '/' AND iv_sayi_2 = 0.

      CLEAR ev_ok.


    ENDIF.


  ENDMETHOD.


  method TOPLAMA.

    ev_sonuc_toplama = iv_sayi_toplama_1 + iv_sayi_toplama_2.

  endmethod.
ENDCLASS.
