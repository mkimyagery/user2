*&---------------------------------------------------------------------*
*& Report ZCM_TEST_114
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_114.

CLASS lcl_test_class DEFINITION.

  PUBLIC SECTION.

    CLASS-DATA: gv_name  TYPE c LENGTH 25, " Static - Public attribute.
                gv_sname TYPE c LENGTH 25. " Static - Public attribute.

    CLASS-METHODS: set_name_sname IMPORTING iv_name  TYPE char25 " Static - Public method.
                                            iv_sname TYPE char25,

                   translate IMPORTING iv_uppercase TYPE boolean OPTIONAL" Static - Public method.
                                       iv_lowercase TYPE boolean OPTIONAL.

ENDCLASS.

CLASS lcl_test_class IMPLEMENTATION.

  METHOD: set_name_sname.
    gv_name = iv_name.
    gv_sname = iv_sname.
  ENDMETHOD.

  METHOD: translate.
    IF iv_lowercase IS NOT INITIAL.
      TRANSLATE gv_name TO LOWER CASE.
      TRANSLATE gv_sname TO LOWER CASE.
    ELSE.
      TRANSLATE gv_name TO UPPER CASE.
      TRANSLATE gv_sname TO UPPER CASE.
    ENDIF.
  ENDMETHOD.

ENDCLASS.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.

  PARAMETERS: p_name TYPE c LENGTH 25 OBLIGATORY LOWER CASE,
              p_sname  TYPE c LENGTH 25 OBLIGATORY LOWER CASE,
              p_upper RADIOBUTTON GROUP abc,
              p_lower RADIOBUTTON GROUP abc.

SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

lcl_test_class=>set_name_sname(
  EXPORTING
    iv_name  = p_name
    iv_sname = p_sname ).

lcl_test_class=>translate(
  EXPORTING
    iv_uppercase = p_upper
    iv_lowercase = p_lower ).

WRITE: lcl_test_class=>gv_name, / lcl_test_class=>gv_sname.
