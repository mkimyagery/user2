*&---------------------------------------------------------------------*
*& Report ZCM_TEST_AF_TEST_1
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_af_email.

DATA: gs_data     TYPE zcm_s_adobeform_fdm,
      gs_outparam TYPE sfpoutputparams,
      gv_funcname TYPE funcname,
      gs_pdf      TYPE  fpformoutput,
      gv_filename TYPE string,
      gv_path     TYPE string,
      gv_fullpath TYPE string,
      gt_data_tab TYPE STANDARD TABLE OF x255,
      gv_pdf_size TYPE so_obj_len.


SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
  PARAMETERS: p_carrid TYPE s_carr_id,
              p_email  TYPE ad_smtpadr.
SELECTION-SCREEN END OF BLOCK a1.

START-OF-SELECTION.

  "Databaseden veriyi oku ve gerekli yerlere kaydet.
  SELECT SINGLE * FROM scarr   INTO       gs_data-scarr   WHERE carrid = p_carrid.
  SELECT *        FROM spfli   INTO TABLE gs_data-spfli   WHERE carrid = p_carrid.
  SELECT *        FROM sflight INTO TABLE gs_data-sflight WHERE carrid = p_carrid.

  "PDF'in acilmamasini ancak veri haline saklanmasi sagla.
  gs_outparam-getpdf   = abap_true.

  "PDF olusturmak icin JOB ac.
  CALL FUNCTION 'FP_JOB_OPEN'
    CHANGING
      ie_outputparams = gs_outparam
    EXCEPTIONS
      cancel          = 1
      usage_error     = 2
      system_error    = 3
      internal_error  = 4
      OTHERS          = 5.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

  "Adobe Formun fonksiyon ismini al.
  CALL FUNCTION 'FP_FUNCTION_MODULE_NAME'
    EXPORTING
      i_name     = 'ZAC_DEMO_EXAMPLE' "'ZCM_ADOBE_FORM_FDM'
    IMPORTING
      e_funcname = gv_funcname.

  "Adobe Formun fonksiyonunu cagir ve PDF'i veri olarak al.
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

  "PDF olusturma islemi tamamlandi. JOB kapat.
  CALL FUNCTION 'FP_JOB_CLOSE'
    EXCEPTIONS
      usage_error    = 1
      system_error   = 2
      internal_error = 3
      OTHERS         = 4.

  "Gelen PDF dosyasini BINARY formatina cevir.
  "Binary formati tamamen sayilardan olusan bir veri tipidir.
  CALL FUNCTION 'SCMS_XSTRING_TO_BINARY'
    EXPORTING
      buffer     = gs_pdf-pdf
    TABLES
      binary_tab = gt_data_tab.

  "Kendisine belirli bir bellek hakki taninmis e-mail gönderme sürecini baslatmak icin
  "gerekli class objesini olustur,
  TRY.
      DATA(go_send_request) = cl_bcs=>create_persistent( ).
    CATCH cx_send_req_bcs.
      BREAK-POINT.

  ENDTRY.

  "Eklenti olarak gönderilecek dokümanin karakter sayisini hesapla.
  gv_pdf_size = xstrlen( gs_pdf-pdf ).

  "Eklentideki dosyanin icerigini olustur.
  DATA(gt_pdf_content) = cl_document_bcs=>xstring_to_solix( ip_xstring = gs_pdf-pdf ).

  "Eklentinin PDF olacagini bildir, icerigini ve karakter sayisini ver.
  "Ayrica e-mailin konusunu belirt.
  TRY.
      DATA(go_document) = cl_document_bcs=>create_document( i_type    = 'PDF'
                                                            i_hex     = gt_pdf_content
                                                            i_length  = gv_pdf_size
                                                            i_subject = CONV #( TEXT-002 ) ).
    CATCH cx_document_bcs.
      BREAK-POINT.
  ENDTRY.

  "Yukarida olusturdugumuz bellekli objeye dokümani ver.
  TRY .
      go_send_request->set_document( go_document ).
    CATCH cx_send_req_bcs.
      BREAK-POINT.
  ENDTRY.

  "Alici olustur.
  TRY.
      DATA(go_recipient) = cl_cam_address_bcs=>create_internet_address( i_address_string = p_email ).

    CATCH cx_address_bcs.
      BREAK-POINT.
  ENDTRY.

  "Alici ekle.
  TRY .
      go_send_request->add_recipient( i_recipient = go_recipient ).
    CATCH cx_send_req_bcs.
      BREAK-POINT.
  ENDTRY.

  "E-maili gönder.
  TRY .
      DATA(gv_sent_to_all) = go_send_request->send( i_with_error_screen = 'X' ).
    CATCH cx_send_req_bcs.
      BREAK-POINT.
  ENDTRY.

  "Sonuca göre mesaj olustur.
  IF gv_sent_to_all = 'X'.
    MESSAGE 'E_Mail basarili bir sekilde gönderildi' TYPE 'S'.
    COMMIT WORK.
  ELSE.
    MESSAGE 'E_Mail gönderme islemi basarisiz oldu.' TYPE 'S' DISPLAY LIKE 'E'.
  ENDIF.
