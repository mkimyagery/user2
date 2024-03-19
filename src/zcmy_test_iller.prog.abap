*&---------------------------------------------------------------------*
*& Report ZCM_TEST_ILLER
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_ILLER.

DATA: gs_tam TYPE ZCM_IL_ILCE.

SELECT * FROM zcm_iller INTO TABLE @DATA(gt_iller).
SELECT * FROM zcm_ilceler INTO TABLE @DATA(gt_ilceler).

  LOOP AT gt_iller INTO DATA(gs_iller).
    LOOP AT gt_ilceler INTO DATA(gs_ilceler) WHERE il_kodu = gs_iller-il_kodu.
      gs_tam-il_kodu = gs_iller-il_kodu.
      gs_tam-il_adi = gs_iller-il_adi.
      gs_tam-il_adi = gs_ilceler-ilce_adi.

      insert ZCM_IL_ILCE FROM gs_tam.
    ENDLOOP.
  ENDLOOP.
