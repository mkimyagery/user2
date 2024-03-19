class ZYMESSAGE_TYPES_CM definition
  public
  final
  create public .

public section.

  methods SHOW_MESSAGE
    importing
      !IV_SUCCESS type CHAR1
      !IV_ERROR type CHAR1
      !IV_WARNING type CHAR1
      !IV_INFORMATION type CHAR1 .
protected section.
private section.
ENDCLASS.



CLASS ZYMESSAGE_TYPES_CM IMPLEMENTATION.


  METHOD SHOW_MESSAGE.

    IF iv_success = abap_true.

      MESSAGE s000.

    ELSEIF iv_error = abap_true.

      MESSAGE e000.

    ELSEIF iv_warning = abap_true.

      MESSAGE w000.

    ELSEIF iv_information = abap_true.

      MESSAGE i000.

    ENDIF.

  ENDMETHOD.
ENDCLASS.
