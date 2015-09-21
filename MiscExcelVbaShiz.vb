Sub UnhideSheets()
  Dim ws As Worksheet
  For Each ws In Worksheets
    ws.Visible = True
  Next
End Sub

Sub rename()

    For Each c In Range("Table1[Column1]")
	Cells.Replace What:=(c.value) _
	, Replacement:=(c.offset(0,1).value) _
	, LookAt:=xlPart _
	, SearchOrder:=xlByRows _
	, MatchCase:=False _
	, SearchFormat:=False _
	, ReplaceFormat:=False
    Next c
    msgbox "success"
End Sub



Public Function rangeConcat(ByVal aRange As Range, Optional ByVal delimiter As String) As String
    Dim ouputString As String
    For Each c In aRange.Cells
        outputString = outputString & c.Value & delimiter
    Next c
    If delimiter = "" Then
        rangeConcat = outputString
    Else
        rangeConcat = Left(outputString, Len(outputString) - 1)
    End If
End Function

Function removeSpecial(sInput As String) As String
    Dim sSpecialChars As String
    Dim i As Long
    sSpecialChars = "\/:*?™""®<>|.&@#(_+`©~);-+=^$!,'" 'This is your list of characters to be removed
    For i = 1 To Len(sSpecialChars)
        sInput = Replace$(sInput, Mid$(sSpecialChars, i, 1), " ")
    Next
    removeSpecial = sInput
End Function

Function getRGB1(rcell) As String
    Dim sColor As String

    sColor = Right("000000" & Hex(rcell.Interior.Color), 6)
    getRGB1 = Right(sColor, 2) & Mid(sColor, 3, 2) & Left(sColor, 2)
End Function

'all datatables must be unfiltered and all rows/columns must be unhidden
Sub MakeSimple()
  Dim ws As Worksheet
  For Each ws In Worksheets
    ws.Visible = True
    ws.Activate
    Cells.Select
    Selection.Copy
    Selection.PasteSpecial Paste:=xlPasteValues, Operation:=xlNone, SkipBlanks _
        :=False, Transpose:=False
    Application.CutCopyMode = False
  Next
  Msgbox "Complete"
End Sub

'Password Cracker fro Excel 97-03
Sub PasswordBreaker()
  'Author unknown but submitted by brettdj of www.experts-exchange.com
  
  Dim i As Integer, j As Integer, k As Integer
  Dim l As Integer, m As Integer, n As Integer
  Dim i1 As Integer, i2 As Integer, i3 As Integer
  Dim i4 As Integer, i5 As Integer, i6 As Integer
  On Error Resume Next
  For i = 65 To 66: For j = 65 To 66: For k = 65 To 66
  For l = 65 To 66: For m = 65 To 66: For i1 = 65 To 66
  For i2 = 65 To 66: For i3 = 65 To 66: For i4 = 65 To 66
  For i5 = 65 To 66: For i6 = 65 To 66: For n = 32 To 126
     
        
 ActiveSheet.Unprotect Chr(i) & Chr(j) & Chr(k) & _
      Chr(l) & Chr(m) & Chr(i1) & Chr(i2) & Chr(i3) & _
      Chr(i4) & Chr(i5) & Chr(i6) & Chr(n)
  If ActiveSheet.ProtectContents = False Then
      Debug.Print "One usable password is " & Chr(i) & Chr(j) & _
          Chr(k) & Chr(l) & Chr(m) & Chr(i1) & Chr(i2) & _
          Chr(i3) & Chr(i4) & Chr(i5) & Chr(i6) & Chr(n)
   'ActiveWorkbook.Sheets(1).Select
   PrintVal = Chr(i) & Chr(j) & _
          Chr(k) & Chr(l) & Chr(m) & Chr(i1) & Chr(i2) & _
          Chr(i3) & Chr(i4) & Chr(i5) & Chr(i6) & Chr(n)
    Debug.Print PrintVal
       Exit Sub
  End If
  Next: Next: Next: Next: Next: Next
  Next: Next: Next: Next: Next: Next


End Sub


'Function: The function will return the result for the first test that evaluates to true
'Usage: Enter this function into your spreadsheet with the required arguements
'Basic Syntax: Switch2(Test1, Result1, Test2, Result2, etc...)
'Rules: You must have at least one test/result pair.
'You'll have to add to the code if you want more than 14 tests.
'Example:'=Switch2(C4="Apple","Red",C4="Grape","Purple",C4="Orange","Orange", TRUE, "No Color Match")
'Note the use of the test/result combination "True, "No Color Match" so that the function will return
'something if none of the tests evaluate to true

Function Switch2(Test1 As String, Result1 As String, _
	Optional Test2 As String, Optional Result2 As String, _
	Optional Test3 As String, Optional Result3 As String, _
	Optional Test4 As String, Optional Result4 As String, _
	Optional Test5 As String, Optional Result5 As String, _
	Optional Test6 As String, Optional Result6 As String, _
	Optional Test7 As String, Optional Result7 As String, _
	Optional Test8 As String, Optional Result8 As String, _
	Optional Test9 As String, Optional Result9 As String, _
	Optional Test10 As String, Optional Result10 As String, _
	Optional Test11 As String, Optional Result11 As String, _
	Optional Test12 As String, Optional Result12 As String, _
	Optional Test13 As String, Optional Result13 As String, _
	Optional Test14 As String, Optional Result14 As String)
 
Switch2 = Switch(Test1, Result1, _
	Test2, Result2, _
	Test3, Result3, _
	Test4, Result4, _
	Test5, Result5, _
	Test6, Result6, _
	Test7, Result7, _
	Test8, Result8, _
	Test9, Result9, _
	Test10, Result10, _
	Test11, Result11, _
	Test12, Result12, _
	Test13, Result13, _
	Test14, Result14)
End Function