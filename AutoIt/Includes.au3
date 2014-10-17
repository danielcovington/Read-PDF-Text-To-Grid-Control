#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

;Global Variables Set here

Global $PdfFileName
Global $PdfLibrary
Global $DebugFlag = 0
Global $CurrentFileId
Global $CurrentPageNumber
Global $CurrentDocumentTotalPages
Global $RawPageExtract

;This is from Autoit help file to support sorting
Global $g_iCurCol = -1
Global $g_iSortDir = 1
Global $g_bSet = False
Global $g_iCol = -1

#include <String.au3>
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListView.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <FileConstants.au3>
#include <MsgBoxConstants.au3>
#include <Debug.au3>
#include <DebugSetUp.au3>
#include <PdfLibrary.au3>
#include <GUI.au3>