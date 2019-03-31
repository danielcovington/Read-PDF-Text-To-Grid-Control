#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

If @AutoItX64 Then

	$PdfLibrary = ObjCreate("DebenuPDFLibrary64AX1013.PDFLibrary")

Else

	$PdfLibrary = ObjCreate("DebenuPDFLibraryAX1013.PDFLibrary")

EndIf

If $PdfLibrary.UnlockKey("USEKEY") <> 1 Then
		MsgBox(0, "Library Cannot Open", "ERROR")
		Exit
EndIf
