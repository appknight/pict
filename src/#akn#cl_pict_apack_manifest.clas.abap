class /AKN/CL_PICT_APACK_MANIFEST definition
  public
  final
  create public .

public section.

  interfaces ZIF_APACK_MANIFEST .

  methods CONSTRUCTOR .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS /AKN/CL_PICT_APACK_MANIFEST IMPLEMENTATION.


  METHOD constructor.
    zif_apack_manifest~descriptor-group_id = 'https://github.com/appknight'.
    zif_apack_manifest~descriptor-artifact_id = 'pict'.
*    zif_apack_manifest~descriptor-version = '0.2'.
    zif_apack_manifest~descriptor-git_url = 'https://github.com/appknight/pict.git'.
    zif_apack_manifest~descriptor-dependencies = VALUE #( ).
  ENDMETHOD.
ENDCLASS.
