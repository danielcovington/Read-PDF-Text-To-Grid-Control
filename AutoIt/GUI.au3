#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GUIListView.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Region ### START Koda GUI section ### Form=C:\Git\Read-PDF-Text-To-Grid-Control\Koda\FrmMain.kxf
$FrmMain = GUICreate("PDF To Grid", 615, 779, 192, 124)
$ListView1 = GUICtrlCreateListView("Text|X Coord|Y Coord", 8, 424, 602, 342, BitOR($GUI_SS_DEFAULT_LISTVIEW,$LVS_AUTOARRANGE))
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 50)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 50)
GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 50)
_GUICtrlListView_JustifyColumn(GUICtrlGetHandle($ListView1), 1, 2)
_GUICtrlListView_JustifyColumn(GUICtrlGetHandle($ListView1), 2, 2)
$btnOpenFile = GUICtrlCreateButton("Open File", 8, 4, 75, 25)
$tbFilename = GUICtrlCreateInput("", 8, 40, 601, 21)
$tbPageNumber = GUICtrlCreateInput("", 90, 4, 121, 21)
$Label1 = GUICtrlCreateLabel(" Of ", 210, 4, 21, 17, BitOR($SS_CENTER,$SS_CENTERIMAGE))
$tbTotalPages = GUICtrlCreateInput("", 232, 4, 121, 21)
$btnPageBack = GUICtrlCreateButton("<", 360, 6, 75, 25)
$btnPageForward = GUICtrlCreateButton(">", 444, 6, 75, 25)
$tbXLeft = GUICtrlCreateInput("", 12, 120, 121, 21)
$tbXRight = GUICtrlCreateInput("", 259, 120, 121, 21)
$tbYTop = GUICtrlCreateInput("", 136, 88, 121, 21)
$tbYBottom = GUICtrlCreateInput("", 136, 145, 121, 21)
$lblxleft = GUICtrlCreateLabel("X Left", 18, 96, 32, 17)
$lblxright = GUICtrlCreateLabel("X Right", 270, 93, 39, 17)
$lblytop = GUICtrlCreateLabel("Y Top", 142, 71, 33, 17)
$lblybottom = GUICtrlCreateLabel("Y Bottom", 145, 128, 47, 17)
$tbExtractedText = GUICtrlCreateEdit("", 12, 234, 593, 173)s
$cbExtractText = GUICtrlCreateCheckbox("cbExtractText", 12, 210, 97, 17)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

	EndSwitch
WEnd