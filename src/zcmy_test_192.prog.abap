*&---------------------------------------------------------------------*
*& Report ZCM_TEST_192
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZCMY_TEST_192.

"Contains any

DATA: gv_text TYPE string VALUE 'Tükenmez Kalem'.


*IF gv_text CA 'çığöşü'.
*
*  WRITE: 'gv_text degiskeni Türkce karakter icermektedir.'.
*
*ENDIF.

*IF gv_text NA 'çığöşü'.
*  WRITE: 'gv_text degiskeni Türkce karakter icermemektedir.'.
*ELSE.
*  WRITE: 'gv_text degiskeni Türkce karakter icermektedir.'.
*ENDIF.

*IF gv_text NS 'ada'.
* BREAK-POINT.
*ENDIF.
*
*IF gv_text NS 'aDa'.
* BREAK-POINT.
*ENDIF.

*IF gv_text CP 'TÜ*'.
* BREAK-POINT.
*ENDIF.
*
*IF gv_text CP 'Ad*'.
* BREAK-POINT.
*ENDIF.

*IF gv_text CP '*LEM'.
* BREAK-POINT.
*ENDIF.
*
*IF gv_text CP '*EM'.
* BREAK-POINT.
*ENDIF.
*
*IF gv_text CP '*M'.
* BREAK-POINT.
*ENDIF.
*
*IF gv_text CP '*RAM'.
* BREAK-POINT.
*ENDIF.

IF gv_text NP '*m'.
  BREAK-POINT.
ENDIF.

IF gv_text NP '*K'.
  BREAK-POINT.
ENDIF.
