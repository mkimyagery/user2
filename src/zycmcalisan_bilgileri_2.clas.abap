class ZYCMCALISAN_BILGILERI_2 definition
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
      !ET_IZIN type ZCM_TT_IZIN_2 .
protected section.
private section.
ENDCLASS.



CLASS ZYCMCALISAN_BILGILERI_2 IMPLEMENTATION.


  method CALISAN_BILGILERINI_AL.

    SELECT SINGLE * FROM zcm_tablo_1 INTO es_calisan_bilgileri
      WHERE id = iv_id.
  endmethod.


  METHOD IZIN_BILGILERINI_AL.

    SELECT yil, kul_izin FROM zcm_tablo_2 INTO TABLE @et_izin
      WHERE id = @iv_id.


  ENDMETHOD.
ENDCLASS.
