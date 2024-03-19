*&---------------------------------------------------------------------*
*& Report ZCM_TEST_215
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmy_test_215.

*Alıştırma – 2: Kendinize ait STRAVELAG database tablosunun (Ör: ZCM_STRAVELAG) bütün kayıtlarını
*silin ve MANDT kolonundan hemen sonra gelecek şekilde yeni bir ID kolonu oluşturun. (Yeni bir Key
*Field) SNRO işlem kodunu kullanarak bir sayı aralığı objesi oluşturun. (4 haneli sayılar üretecek.) Yeni
*bir rapor oluşturun ve STRAVELAG tablosunun tüm satırlarını okuyun. Her satirin yeni ID hücresi için
*NUMBER_GET_NEXT fonksiyonu ve oluşturduğunuz sayı aralığı objesini kullanarak bir ID üretin ve ID
*hücresi içerisine kaydedin. Elde ettiğiniz satırı kendinize ait database tablosuna kaydedin.

DATA: gt_stravelag     TYPE TABLE OF stravelag,
      gs_stravelag     TYPE stravelag,
      gs_zcm_stravelag TYPE zcm_stravelag,
      gv_no            TYPE n LENGTH 4.

START-OF-SELECTION.

  SELECT * FROM stravelag INTO TABLE gt_stravelag.

  LOOP AT gt_stravelag INTO gs_stravelag.

    CALL FUNCTION 'NUMBER_GET_NEXT'
      EXPORTING
        nr_range_nr             = '01'
        object                  = 'ZCM_NR_001'
      IMPORTING
        number                  = gv_no
      EXCEPTIONS
        interval_not_found      = 1
        number_range_not_intern = 2
        object_not_found        = 3
        quantity_is_0           = 4
        quantity_is_not_1       = 5
        interval_overflow       = 6
        buffer_overflow         = 7
        OTHERS                  = 8.

    IF sy-subrc IS NOT INITIAL.
      LEAVE PROGRAM.
    ENDIF.

    MOVE-CORRESPONDING gs_stravelag TO gs_zcm_stravelag.

    gs_zcm_stravelag-id = gv_no.

    INSERT zcm_stravelag FROM gs_zcm_stravelag.

    BREAK-POINT.

  ENDLOOP.
