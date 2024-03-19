*&---------------------------------------------------------------------*
*& Report ZCM_TEST_144
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_144.

CLASS lcl_name_sname DEFINITION.

  PUBLIC SECTION.
    "Bu baslik altindaki bütün metotlar ya Static-Public, ya da Instance-Public.
    "Bu baslik altindaki bütün attributelar ya Static-Public, ya da Instance-Public.
    CLASS-DATA: gv_name  TYPE c LENGTH 25, "Static-Public bir attribute.
                gv_sname TYPE c LENGTH 25. "Static-Public bir attribute.

    CLASS-METHODS: set_name_sname IMPORTING iv_name  TYPE char25
                                            iv_sname TYPE char25.

    CLASS-METHODS: translate IMPORTING iv_uppercase TYPE boolean
                                       iv_lowercase TYPE boolean.
ENDCLASS.

CLASS lcl_name_sname IMPLEMENTATION.

  METHOD: set_name_sname.
    gv_name  = iv_name.
    gv_sname = iv_sname.
  ENDMETHOD.

  METHOD: translate.
    IF iv_uppercase = abap_true.
      TRANSLATE gv_name  TO UPPER CASE.
      TRANSLATE gv_sname TO UPPER CASE.
    ELSEIF iv_lowercase = abap_true.
      TRANSLATE gv_name  TO LOWER CASE.
      TRANSLATE gv_sname TO LOWER CASE.
    ENDIF.

  ENDMETHOD.

ENDCLASS.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.

  PARAMETERS: p_name  TYPE c LENGTH 25 LOWER CASE,
              p_sname TYPE c LENGTH 25 LOWER CASE,
              p_upper RADIOBUTTON GROUP abc,
              p_lower RADIOBUTTON GROUP abc.

SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  lcl_name_sname=>set_name_sname(
    EXPORTING
      iv_name  = p_name
      iv_sname = p_sname ).

  lcl_name_sname=>translate(
    EXPORTING
      iv_uppercase = p_upper
      iv_lowercase = p_lower ).

  WRITE: lcl_name_sname=>gv_name, lcl_name_sname=>gv_sname.
