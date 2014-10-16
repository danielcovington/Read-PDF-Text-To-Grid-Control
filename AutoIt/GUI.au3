#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here



Opt("GUIOnEventMode", 1) ; Change to OnEvent mode
Global $GUI_debug = 1



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
$tbExtractedText = GUICtrlCreateEdit("", 12, 234, 593, 173)
$cbExtractText = GUICtrlCreateCheckbox("cbExtractText", 12, 210, 97, 17)
GUISetOnEvent($GUI_EVENT_CLOSE, "CLOSEButton")
GUICtrlSetOnEvent($btnOpenFile,"OpenFile")
GUICtrlSetOnEvent($btnPageBack,"PageBack")
GUICtrlSetOnEvent($btnPageForward,"PageForward")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###


Func OpenFile()

	$PdfFileName = FileOpenDialog("Select PDF File to Open",@ScriptDir,"PDF (*.pdf)")

		If FileExists($PdfFileName) Then

			If ($DebugFlag = 1 and $GUI_debug = 1 ) Then
				DebugOut("GUI.au3",@ScriptLineNumber,$PdfFileName & " Exists.")
			EndIf

		$CurrentFileID = $PdfLibrary.LoadFromFile($PdfFileName,"")

			If Not $CurrentFileID Then
				GUICtrlSetData($tbFilename,"File Cannot Be Opened")

					If ($DebugFlag = 1 and $GUI_debug = 1 ) Then
						DebugOut("GUI.au3",@ScriptLineNumber,$PdfFileName & " Cannot Be Opened")
					EndIf

			Else
				DebugOut("GUI.au3",@ScriptLineNumber,"Current File ID Is:" & $CurrentFileID)
				$PdfLibrary.SelectPage(1)
				$CurrentPageNumber = 1
				$CurrentDocumentTotalPages = $PdfLibrary.PageCount()
				$RawPageExtract =  StringSplit($PdfLibrary.GetPageText("3"),@CRLF,1)

				GUICtrlSetData($tbExtractedText,$PdfLibrary.GetPageText("3"))
				GUICtrlSetData($tbFilename,$PdfFileName)
				GUICtrlSetData($tbPageNumber,$CurrentPageNumber)
				GUICtrlSetData($tbTotalPages,$CurrentDocumentTotalPages)
				UpdateListView($RawPageExtract)

			EndIF




		EndIf


EndFunc

Func PageBack()
		If $CurrentPageNumber = 1 Then
			$CurrentPageNumber = $CurrentDocumentTotalPages
			GUICtrlSetData($tbPageNumber,$CurrentPageNumber)
		Else
			$CurrentPageNumber -=1
			GUICtrlSetData($tbPageNumber,$CurrentPageNumber)
		EndIf

		$PdfLibrary.SelectPage($CurrentPageNumber)
		$RawPageExtract =  StringSplit($PdfLibrary.GetPageText("3"),@CRLF,3)

		GUICtrlSetData($tbExtractedText,$PdfLibrary.GetPageText("3"))
		UpdateListView($RawPageExtract)
EndFunc



Func PageForward()
		If $CurrentPageNumber = $CurrentDocumentTotalPages Then
			$CurrentPageNumber = 1
			GUICtrlSetData($tbPageNumber,$CurrentPageNumber)
		Else
			$CurrentPageNumber +=1
			GUICtrlSetData($tbPageNumber,$CurrentPageNumber)
		EndIf

		$PdfLibrary.SelectPage($CurrentPageNumber)
		$RawPageExtract =  StringSplit($PdfLibrary.GetPageText("3"),@CRLF,3)
		GUICtrlSetData($tbExtractedText,$PdfLibrary.GetPageText("3"))
		UpdateListView($RawPageExtract)
EndFunc

Func CLOSEButton()

	If $DebugFlag = 1 Then

		DebugOut("GUI.au3",@ScriptLineNumber,"Window Is Closed Close This Window")

	EndIf
    Exit
EndFunc   ;==>CLOSEButton

Func UpdateListView(ByRef $PageDataArray)

For $index = 0 to UBound($PageDataArray)-1

	$DataArray = StringSplit($PageDataArray[$index],",",3)
	If Ubound($DataArray) > 2 Then
		_CLEAN_UP_COMMAS($DataArray)
		GUICtrlCreateListViewItem($DataArray[11]&"|"&$DataArray[9]&"|"&$DataArray[10]&"|",$ListView1)
	EndIf



Next





EndFunc
Func _CLEAN_UP_COMMAS(ByRef $A_Array)
	For $j = 0 To (UBound($A_Array) - 1) Step 1
		If (StringLeft($A_Array[$j], 1) = '"' and StringRight($A_Array[$j], 1) <> '"') Then
				$A_Array[$j] = $A_Array[$j] & "," & $A_Array[$j + 1]
				_ArrayDelete($A_Array, ($j + 1))
				_ArrayAdd($A_Array, "")
				$j -= 1
			EndIf
Next
EndFunc