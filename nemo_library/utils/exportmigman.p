define temp-table ttImportPrograms no-undo
  field MenuName           as character format 'x(60)':U        label 'Main Menu Description':U
  field MenuNameDE         as character format 'x(60)':U        label 'Main Menu Description in German':U
  field MenuFolder         as character format 'x(60)':U        label 'Main Menu Category':U
  field ClassInstance      as character format 'x(60)':U        label 'Class':U
  field ShortDescription   as character format 'x(60)':U        label 'Instance Description':U
  field ClassAttr          as character format 'x(99)':U
  field Container          like DRC_Instance.DRC_Instance_ID
  field mainmenu           as character format 'x(99)':U

  index Main is primary
    MenuName
    ClassInstance 
  .
  
define variable pa-Sprache as character no-undo init 'D':U.
&GLOBAL-DEFINE pa_DefaultSprache 'D':U

PROCEDURE fill-tt :
/* Description ---------------------------------------------------------------*/
/*                                                                            */
/* Fills the ttImportPrograms according to repository information             */
/*                                                                            */
/* Notes ---------------------------------------------------------------------*/
/*                                                                            */
/*                                                                            */
/*                                                                            */
/* Parameters ----------------------------------------------------------------*/
/*                                                                            */
/* <none>                                                                     */
/*                                                                            */
/* Examples ------------------------------------------------------------------*/
/*                                                                            */
/*                                                                            */
/*                                                                            */
/*----------------------------------------------------------------------------*/

/* Variables -----------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/

/* Buffers -------------------------------------------------------------------*/

define buffer bDRC_Instance         for DRC_Instance.
define buffer bDRC_InstanceCls      for DRC_Instance.
define buffer bDBM_NavItem          for DBM_NavItem.
define buffer bDBM_NavMenu          for DBM_NavMenu.
define buffer bDBM_ShortDescription for DBM_ShortDescription.

/*----------------------------------------------------------------------------*/
/* Processing                                                                 */
/*----------------------------------------------------------------------------*/

/* first reset the tt */
empty temp-table ttImportPrograms.

for each bDRC_Instance
  where bDRC_Instance.DRC_Instance_ID begins 'ditmig00.w#':U
  no-lock
  on error undo, next:

  /* search for the entry within main menu     */
  /* find first, cause the index is not unique */
  find first bDBM_NavItem
    where bDBM_NavItem.DRC_Instance_Obj = bDRC_Instance.DRC_Instance_Obj
    no-lock no-error.

  /* There are instances without entry within main menu. */
  /* Thus, jump to next one.                             */
  if not available bDBM_NavItem then
    next.

  /* Find the corresponding "Folder/Menu" in the main menu */
  find bDBM_NavMenu
    where bDBM_NavMenu.DBM_NavMenu_Obj = bDBM_NavItem.DBM_NavMenu_Obj
    no-lock.

  /* search for its description */
  {adm/incl/d__spr00.if
    &Tabelle  = "bDBM_ShortDescription"
    &Selekt   = "where bDBM_ShortDescription.owning_obj = bDBM_NavMenu.DBM_NavMenu_Obj"
  }

  create ttImportPrograms.
  assign
    ttImportPrograms.MenuFolder    = bDBM_ShortDescription.ShortDesc1
    ttImportPrograms.ClassInstance = entry(2, bDBM_NavItem.Attributelist, '=':U)
    ttImportPrograms.ClassAttr     = bDBM_NavItem.Attributelist
    ttImportPrograms.Container     = bDRC_Instance.DRC_Instance_ID
    ttImportPrograms.mainmenu      = bDBM_NavItem.DBM_NavItem_Obj
    .
  validate ttImportPrograms.

  /* The short description of instance Ditmig00.w# must cointain the name of  */
  /* the import program menu item in German.                                  */
  {adm/incl/d__spr00.if
    &Tabelle  = "bDBM_ShortDescription"
    &Selekt   = "where bDBM_ShortDescription.owning_obj = bDRC_Instance.DRC_Instance_Obj"
  }

  ttImportPrograms.MenuNameDE = bDBM_ShortDescription.ShortDesc1.

  find bDRC_InstanceCls
    where bDRC_InstanceCls.DRC_Instance_ID = substring(ttImportPrograms.ClassInstance, index(ttImportPrograms.ClassInstance,'.cls.':U) + 5) + '.cls':U
    no-lock.

  /* search for the description of the instance */
  {adm/incl/d__spr00.if
    &Tabelle  = "bDBM_ShortDescription"
    &Selekt   = "where bDBM_ShortDescription.owning_obj = bDRC_InstanceCls.DRC_Instance_Obj"
  }

  assign
    /* hier Infos zur "*svo.cls"                                                                            */
    /* Bezeichnung "Datenmigration Ressourcen" dabei aber nur den Teil hinter dem 1. Leerzeichen mitnehmen. */
    /* Wegen der Sortierbarkeit im Browser!                                                                 */
    ttImportPrograms.ShortDescription  = (if num-entries(bDBM_ShortDescription.ShortDesc1, ' ':U) = 2 then
                                            entry(2, bDBM_ShortDescription.ShortDesc1, ' ':U)
                                          else
                                            '':U).

  /* search for the description within main menu */
  {adm/incl/d__spr00.if
    &Tabelle  = "bDBM_ShortDescription"
    &Selekt   = "where bDBM_ShortDescription.owning_obj = bDBM_NavItem.DBM_NavItem_Obj"
  }

  assign
    ttImportPrograms.MenuName         = bDBM_ShortDescription.ShortDesc1
    /* Fallback für Instanz-Bezeichnung, wenn leer. */
    ttImportPrograms.ShortDescription = bDBM_ShortDescription.ShortDesc1
      when ttImportPrograms.ShortDescription = '':U
    .

end. /* for each bDRC_Instance */

end procedure. /* fill-tt */

run fill-tt.

define variable oDataTransfer         as class adm.import.cls.DICCommonMigBaseSvo no-undo.

for each ttImportPrograms
  on error undo, throw:
    
  oDataTransfer = cast(adm.method.cls.DMCDISvc:oCreateInstance(ttImportPrograms.ClassInstance),
                       adm.import.cls.DICCommonMigBaseSvo).
  oDataTransfer:prpcTitle = ttImportPrograms.MenuName.
  oDataTransfer:ExportHeaders().
    
end.
