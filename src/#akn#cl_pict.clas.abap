class /AKN/CL_PICT definition
  public
  create public .

public section.

  data MO_PICTURE type ref to CL_GUI_PICTURE .

  methods DISPLAY
    importing
      !LOGO_NAME type CLIKE
      !CONTAINER type ref to CL_GUI_CONTAINER
      !DISP_MODE type I default CL_GUI_PICTURE=>DISPLAY_MODE_FIT_CENTER .
protected section.
private section.
ENDCLASS.



CLASS /AKN/CL_PICT IMPLEMENTATION.


  METHOD display.

    DATA query_table    TYPE STANDARD TABLE OF w3query.
    DATA query_line     TYPE w3query.
    DATA html_table     TYPE STANDARD TABLE OF w3html .
    DATA html_line      TYPE w3html .
    DATA return_code    TYPE w3param-ret_code.
    DATA content_type   TYPE w3param-cont_type.
    DATA content_length TYPE w3param-cont_len.
    DATA pic_data       TYPE STANDARD TABLE OF w3mime .
    DATA url            TYPE c LENGTH 1000.

    query_line-name = '_OBJECT_ID'.
    query_line-value = logo_name.
    APPEND query_line TO query_table.

    CALL FUNCTION 'WWW_GET_MIME_OBJECT'
      TABLES
        query_string        = query_table
        html                = html_table
        mime                = pic_data
      CHANGING
        return_code         = return_code
        content_type        = content_type
        content_length      = content_length
      EXCEPTIONS
        object_not_found    = 1
        parameter_not_found = 2
        OTHERS              = 3.
    CHECK sy-subrc = 0.

    CALL FUNCTION 'DP_CREATE_URL'
      EXPORTING
        type     = 'image'
        subtype  = cndp_sap_tab_unknown
        size     = content_length
        lifetime = cndp_lifetime_transaction
      TABLES
        data     = pic_data
      CHANGING
        url      = url
      EXCEPTIONS
        OTHERS   = 1.

    CREATE OBJECT mo_picture
      EXPORTING
        parent = container.

    mo_picture->load_picture_from_url( url ).
    mo_picture->set_display_mode( disp_mode ).

  ENDMETHOD.
ENDCLASS.
