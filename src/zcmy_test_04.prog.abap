*&---------------------------------------------------------------------*
*& Report ZCM_TEST_04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_04.

"1 tane degisken tanimladik.
"Bu degisken icerisinde CHARACTER tipinde veri tutabiliyor.
"Tutabilecegi maksimum karakter sayisi 30.
*Bu sekilde dokumente edebilirsiniz.
*Definitions - tanimlamalar.

DATA: gv_char_01 TYPE c LENGTH 30,
      gv_char_02 TYPE c LENGTH 20,
      gv_char_03 TYPE c LENGTH 70, "Alternatif tanimlama yöntemi: gv_char_03.
      gv_char_04,
      gv_result  TYPE c LENGTH 3.


gv_char_01 = 'Bugün günlerden carsamba.'.
gv_char_02 = 'Yarin persembe'.
gv_char_03 = '1000'.

gv_result = gv_char_03 * 2.

WRITE: gv_char_01, / gv_char_02, / gv_result.
