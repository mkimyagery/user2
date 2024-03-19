*&---------------------------------------------------------------------*
*& Report ZCM_TEST_350
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_352.

DATA : gs_data        TYPE zcm_s_adobeform_fdm2,
       gs_outparams   TYPE sfpoutputparams,
       gv_funcname    TYPE funcname,
       gs_pdf         TYPE fpformoutput,
       gt_data_binary TYPE TABLE OF sdokcntbin,
       gv_filename    TYPE string,
       gv_path        TYPE string,
       gv_fullpath    TYPE string,
       gv_pdf_size    TYPE so_obj_len.
.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS : p_carrid TYPE s_carr_id,
               p_email  TYPE adr6-smtp_addr.
SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  SELECT SINGLE * FROM scarr   INTO gs_data-scarr         WHERE carrid = p_carrid.
  SELECT *        FROM spfli   INTO TABLE gs_data-spfli   WHERE carrid = p_carrid.
  SELECT *        FROM sflight INTO TABLE gs_data-sflihgt WHERE carrid = p_carrid.

  "LP01 penceresinden kurtul.
  gs_outparams-getpdf = abap_true.


  "PDF i oluşturmak için Job aç!
  CALL FUNCTION 'FP_JOB_OPEN'
    CHANGING
      ie_outputparams = gs_outparams
    EXCEPTIONS
      cancel          = 1
      usage_error     = 2
      system_error    = 3
      internal_error  = 4
      OTHERS          = 5.

  CALL FUNCTION 'FP_FUNCTION_MODULE_NAME'
    EXPORTING
      i_name     = 'ZCM_ADOBE_FORM_FDM'
    IMPORTING
      e_funcname = gv_funcname.

  "2.derste üstünden geçilecek diyorum
  CALL FUNCTION gv_funcname
    EXPORTING
      is_input           = gs_data
    IMPORTING
      /1bcdwb/formoutput = gs_pdf
    EXCEPTIONS
      usage_error        = 1
      system_error       = 2
      internal_error     = 3
      OTHERS             = 4.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

  CALL FUNCTION 'FP_JOB_CLOSE'
    EXCEPTIONS
      usage_error    = 1
      system_error   = 2
      internal_error = 3
      OTHERS         = 4.

  "Sisteme bir gönderi yapacagimizi haber verelim.
  TRY.
      DATA(go_send_request) = cl_bcs=>create_persistent( ).
    CATCH cx_send_req_bcs.
      BREAK-POINT.
*      MESSAGE
  ENDTRY.


  gv_pdf_size = xstrlen( gs_pdf-pdf ).

  "Dokümanin icerigini SOLIX tipinde bir tablonun icine at.
  DATA(gt_pdf_content) = cl_document_bcs=>xstring_to_solix( ip_xstring = gs_pdf-pdf ).

  "Mail eklentisi olarak gönderilecek PDF dokümanini olustur.
  DATA(go_document) = cl_document_bcs=>create_document( EXPORTING i_type         = 'PDF'
                                                                  i_subject      = 'Detaylari dosyada görebilirsiniz.'
                                                                  i_length       = gv_pdf_size
                                                                  i_hex          = gt_pdf_content ).

  "Gönderi talebinin icerisine dokümani yerlestir.
  go_send_request->set_document( i_document = go_document ).

  "Bir adet alici olustur.
  DATA(go_recipient) = cl_cam_address_bcs=>create_internet_address( i_address_string = p_email ).

  "Aliciyi gönderi talebinin icerisine yerlestir.
  go_send_request->add_recipient(  EXPORTING i_recipient  = go_recipient ).

  "E-maili gönder ve sonucunu al.
  DATA(gv_sent) = go_send_request->send( i_with_error_screen = abap_true ).

  "Sonuca göre mesaj ver.
  IF gv_sent IS NOT INITIAL.
    MESSAGE 'E-mail gönderildi' TYPE 'S'.
  ELSE.
    MESSAGE 'Basarisiz' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
*
