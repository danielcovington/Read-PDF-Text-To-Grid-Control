#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here



Opt("GUIOnEventMode", 1) ; Change to OnEvent mode
Global $GUI_debug = 1
Dim $ListViewColumnOrder
Dim $ListViewItemArray[0]



#Region ### START Koda GUI section ### Form=C:\Git\Read-PDF-Text-To-Grid-Control\Koda\FrmMain.kxf
$FrmMain = GUICreate("PDF To Grid", 615, 779, 192, 124)
$ListView1 = GUICtrlCreateListView("Text|X Coord|Y Coord", 8, 424, 602, 342, BitOR($GUI_SS_DEFAULT_LISTVIEW,$LVS_AUTOARRANGE))
;GUICtrlRegisterListViewSort(-1, "LVSort")
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
GUICtrlSetOnEvent($ListView1,"sort")
$ListViewColumnOrder = _GUICtrlListView_GetColumnOrderArray($ListView1)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
;_GUICtrlListView_RegisterSortCallBack($ListView1,1,1)
Func sort()

_GUICtrlListView_SimpleSort($ListView1,$ListViewItemArray ,1 , 0)
$ListViewColumnOrder = _GUICtrlListView_GetColumnOrderArray($ListView1)
EndFunc

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
GUICtrlSetState($ListView1,$GUI_HIDE)
	if ubound($ListViewItemArray) > 1 Then

		for $ItemIndex = 0 to ubound($ListViewItemArray)-1
			GUICtrlDelete($ListViewItemArray[$ItemIndex])
		Next
	Endif
	ReDim $ListViewItemArray[ubound($PageDataArray)-1]

For $index = 0 to UBound($PageDataArray)-1

	$DataArray = StringSplit($PageDataArray[$index],",",3)
	If Ubound($DataArray) > 2 Then
		_CLEAN_UP_COMMAS($DataArray)
	$ListViewItemArray[$index] =	GUICtrlCreateListViewItem($DataArray[11]&"|"&$DataArray[9]&"|"&$DataArray[10]&"|",$ListView1)
	EndIf



Next

GUICtrlSetState($ListView1,$GUI_SHOW)



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
;--------------------------------------------------------------------- From Help File To support sorting
Func LVSort($hWnd, $nItem1, $nItem2, $iColumn)
	Local $sVal1, $sVal2, $iResult

	; Switch the sorting direction
	If $iColumn = $g_iCurCol Then
		If Not $g_bSet Then
			$g_iSortDir = $g_iSortDir * -1
			$g_bSet = True
		EndIf
	Else
		$g_iSortDir = 1
	EndIf
	$g_iCol = $iColumn

	$sVal1 = GetSubItemText($hWnd, $nItem1, $iColumn)
	$sVal2 = GetSubItemText($hWnd, $nItem2, $iColumn)

	; If it is the 3rd colum (column starts with 0) then compare the dates
	If $iColumn = 2 Then
		$sVal1 = StringRight($sVal1, 4) & StringMid($sVal1, 4, 2) & StringLeft($sVal1, 2)
		$sVal2 = StringRight($sVal2, 4) & StringMid($sVal2, 4, 2) & StringLeft($sVal2, 2)
	EndIf

	$iResult = 0 ; No change of item1 and item2 positions

	If $sVal1 < $sVal2 Then
		$iResult = -1 ; Put item2 before item1
	ElseIf $sVal1 > $sVal2 Then
		$iResult = 1 ; Put item2 behind item1
	EndIf

	$iResult = $iResult * $g_iSortDir

	Return $iResult
EndFunc   ;==>LVSort

; Retrieve the text of a listview item in a specified column
Func GetSubItemText($idCtrl, $idItem, $iColumn)
	Local $tLvfi = DllStructCreate("uint;ptr;int;int[2];int")

	DllStructSetData($tLvfi, 1, $LVFI_PARAM)
	DllStructSetData($tLvfi, 3, $idItem)

	Local $tBuffer = DllStructCreate("char[260]")

	Local $nIndex = GUICtrlSendMsg($idCtrl, $LVM_FINDITEM, -1, DllStructGetPtr($tLvfi));

	Local $tLvi = DllStructCreate("uint;int;int;uint;uint;ptr;int;int;int;int")

	DllStructSetData($tLvi, 1, $LVIF_TEXT)
	DllStructSetData($tLvi, 2, $nIndex)
	DllStructSetData($tLvi, 3, $iColumn)
	DllStructSetData($tLvi, 6, DllStructGetPtr($tBuffer))
	DllStructSetData($tLvi, 7, 260)

	GUICtrlSendMsg($idCtrl, $LVM_GETITEMA, 0, DllStructGetPtr($tLvi));

	Local $sItemText = DllStructGetData($tBuffer, 1)

	Return $sItemText
EndFunc   ;==>GetSubItemText