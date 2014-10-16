#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

Func SetupDebugSession()

	_DebugSetup("Debug For Read-PDF-Text-To-Grid-Control", True)

EndFunc

Func DebugOut($ScriptFileName,$ScriptLineNumber,$Message)
	_DebugOut($ScriptFileName & " At Line:" & $ScriptLineNumber)
	_DebugOut("	"&$Message)
	EndFunc