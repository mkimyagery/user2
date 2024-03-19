*&---------------------------------------------------------------------*
*& Report ZCMM_TEST_10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zcmmy_test_10.

"Definitions. (Tanimlamalar)
TYPES: BEGIN OF gty_structure,
         id      TYPE n  LENGTH 8,
         name    TYPE c LENGTH 40,
         surname TYPE c LENGTH 40,
         job     TYPE c LENGTH 20,
         salary  TYPE i,
         curr    TYPE c LENGTH 3,
         gsm     TYPE string,
         e_mail  TYPE string,
       END OF gty_structure.

DATA: gs_structure TYPE gty_structure,
      gt_table     TYPE TABLE OF gty_structure,
      gv_id_start  TYPE n LENGTH 8 VALUE '20240001'.

CONSTANTS: gc_satir TYPE c LENGTH 6 VALUE 'Satir:'.

"Program bu noktadan itibaren execute edilmeye basliyor.
START-OF-SELECTION.

"Internal tabloya 10 satir ekleyelim.
DO 10 TIMES.

  "Ilk eklemeden sonraki her eklemede ID numarasini 1 arttiralim.
  IF sy-index > 1.
    gv_id_start = gv_id_start + 1.
  ENDIF.

  "Satiri dolduralim.
  gs_structure-id      = gv_id_start.
  gs_structure-name    = 'Ali'.
  gs_structure-surname = 'Öztürk'.
  gs_structure-job     = 'Doctor'.
  gs_structure-salary  = 4000.
  gs_structure-curr    = 'EUR'.
  gs_structure-gsm     = '+4917653554647'.
  gs_structure-e_mail  = 'aliozturk@gmail.com'.

  "Satiri tabloya ekleyelim.
  APPEND gs_structure TO gt_table.

  "Kullanilan satirin icini temizleyelim.
  CLEAR: gs_structure.

ENDDO.

"Doldurulan tabloda loop etmeye baslayalim.
LOOP AT gt_table INTO gs_structure.

  IF sy-tabix > 3.
    EXIT.
  ENDIF.

  "mevcut satiri yazdiralim.
  WRITE: / gc_satir, sy-tabix,
         / gs_structure-id,
         / gs_structure-name,
         / gs_structure-surname,
         / gs_structure-job,
         / gs_structure-salary,
         / gs_structure-curr,
         / gs_structure-gsm,
         / gs_structure-e_mail.

  "Satirin altini cizelim.
  ULINE.

  "1satir bosluk birakalim.
  SKIP.

ENDLOOP.
