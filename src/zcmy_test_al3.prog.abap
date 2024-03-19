*&---------------------------------------------------------------------*
*& Report ZCM_TEST_AL3
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_al3.


TYPES: BEGIN OF gty_table,
         id   TYPE c LENGTH 5,
         ad   TYPE c LENGTH 25,
         sorm TYPE c LENGTH 40,
         gun  TYPE i,
         dept TYPE c LENGTH 5,
       END OF gty_table.

DATA: gt_table TYPE TABLE OF gty_table.

START-OF-SELECTION.

APPEND INITIAL LINE TO gt_table ASSIGNING FIELD-SYMBOL(<gs_table>).
<gs_table>-id   = 'PRJ01'.
<gs_table>-ad   = 'PRJ AD 1'.
<gs_table>-sorm = 'Frau Meyer'.
<gs_table>-gun  = 20.
<gs_table>-dept = 'EWM'.


SELECT * FROM zcm_iller INTO TABLE @DATA(gt_il).
SELECT * FROM zcm_ilceler INTO TABLE @DATA(gt_ilce).

DATA: gs_1 TYPE zcm_il_ilce.

LOOP AT gt_il INTO DATA(gs_il).
  LOOP AT gt_ilce INTO DATA(gs_ilce) WHERE il_kodu = gs_il-il_kodu.
    gs_1-mandt = sy-mandt.
    gs_1-il_kodu = gs_il-il_kodu.
    gs_1-il_adi = gs_il-il_adi.
    gs_1-ilce_adi = gs_ilce-ilce_adi.

    INSERT zcm_il_ilce FROM gs_1.
    CLEAR: gs_1.
  ENDLOOP.
ENDLOOP.
