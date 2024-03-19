*&---------------------------------------------------------------------*
*& Report ZCM_TEST_253
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_253.

TYPES: BEGIN OF gty_table,
         id           TYPE zcm_de_yeni_id,
         agencynum    TYPE s_agncynum,
         name         TYPE s_agncynam,
         country      TYPE s_country,
         country_text TYPE landx,
       END OF gty_table.

DATA: gt_table TYPE TABLE OF gty_table.

START-OF-SELECTION.

  SELECT * FROM zcm_stravelag INTO CORRESPONDING FIELDS OF TABLE gt_table.

  LOOP AT gt_table ASSIGNING FIELD-SYMBOL(<fs_str>).

    CALL FUNCTION 'IGN_COUNTRYNAME_GET'
      EXPORTING
        i_country         = <fs_str>-country
      IMPORTING
        e_countryname     = <fs_str>-country_text
      EXCEPTIONS
        country_not_found = 1
        OTHERS            = 2.

  ENDLOOP.

  BREAK-POINT.

  READ TABLE gt_table ASSIGNING <fs_str> INDEX 5.
  IF sy-subrc IS INITIAL.
    <fs_str>-country      = 'TR'.
    <fs_str>-country_text = 'Türkiye'.
  ENDIF.

  READ TABLE gt_table INTO DATA(ls_str) INDEX 10.
  IF sy-subrc IS INITIAL.
    ls_str-country      = 'TR'.
    ls_str-country_text = 'Türkiye'.
  ENDIF.

  BREAK-POINT.
