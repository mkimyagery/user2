class ZYCMCALISAN_BILGILERI definition
  public
  final
  create public .

public section.

  methods CALISAN_BILGILERINI_AL
    importing
      !IV_ID type ZCM_DE_ID
    exporting
      !ES_CALISAN_BILGILERI type ZCM_TABLO_1 .
  methods IZIN_BILGILERINI_AL
    importing
      !IV_ID type ZCM_DE_ID
    exporting
      !ET_IZIN_BILGILERI type ZCM_TT_IZIN .
protected section.
private section.
ENDCLASS.



CLASS ZYCMCALISAN_BILGILERI IMPLEMENTATION.


  METHOD CALISAN_BILGILERINI_AL.

    SELECT SINGLE * FROM zcm_tablo_1
      INTO es_calisan_bilgileri
      WHERE id = iv_id.

  ENDMETHOD.


  METHOD IZIN_BILGILERINI_AL.

    SELECT yil, kul_izin FROM zcm_tablo_2
      INTO TABLE @et_izin_bilgileri
      WHERE id = @iv_id.


  ENDMETHOD.
ENDCLASS.
