Attribute VB_Name = "Visual"

' [Clears the screen]
Sub ClearBackgroundColors()
    Dim ws As Worksheet
    Set ws = ThisWorkbook.Sheets("Minecraft")

    ws.Cells.Interior.ColorIndex = xlNone
End Sub


Sub ClearScreen()
    Dim targetRange As Range
    With ThisWorkbook.Sheets("Minecraft")
        Set targetRange = .Range(.Cells(2, 2), .Cells(screen_height+1, screen_width+1))
    End With

    targetRange.Interior.Color = RGB(205,252,255)
End Sub

Sub FillCellsInRange(xmin As Long, ymin As Long, xmax As Long, ymax As Long, colorA As Variant)
    statsCells = statsCells + xmax - xmin + 1
    statsRowsDrawn = statsRowsDrawn + 1
    Dim ws As Worksheet
    Set ws = ThisWorkbook.Sheets("Minecraft")

    ' Prevents drawing outside of the screen but only if the range is not completely outside of the screen
    If xmin >= 1 And xmin <= screen_width And xmax >= 1 And xmax > screen_width Then
        xmax = screen_width
    ElseIf xmin < 1 And xmin <= screen_width And xmax >= 1 And xmax <= screen_width Then
        xmin = 1
    End If

    If ymin >= 1 And ymin <= screen_height And ymax >= 1 And ymax > screen_height Then
        ymax = screen_height
    ElseIf ymin < 1 And ymin <= screen_height And ymax >= 1 And ymax <= screen_height Then
        ymin = 1
    End If

    ' Check if the range is within the screen
    If xmin >= 1 And ymin >= 1 And xmax <= screen_width And ymax <= screen_height Then
        Dim targetRange As Range
        Set targetRange = ws.Range(ws.Cells(ymin+1, xmin+1), ws.Cells(ymax+1, xmax+1))
        targetRange.Interior.Color = colorA
    End If
End Sub

' [Sets the player variables from the Data sheet]
Sub SetPlayer() 
    P.x = Worksheets("Data").Range("B4").value
    P.y = Worksheets("Data").Range("B5").value
    P.z = Worksheets("Data").Range("B6").value
    P.r = Worksheets("Data").Range("B9").value
    P.h = Worksheets("Data").Range("B10").value
End Sub

' [Sets the enviroment variables from the Data sheet]
Sub SetVariables() 
    blockSize = Worksheets("Data").Range("E4").value
    screen_width = Worksheets("Data").Range("E5").value
    screen_height = Worksheets("Data").Range("E6").value
    moveBy = Worksheets("Data").Range("E7").value
    rotateBy = Worksheets("Data").Range("E8").value
    instantDrawing = Worksheets("Data").Range("E9").value
    blockSizeHalf = blockSize / 2
    ClearBackgroundColors
    ThisWorkbook.Sheets("Minecraft").Range(ThisWorkbook.Sheets("Minecraft").Cells(1, 1), ThisWorkbook.Sheets("Minecraft").Cells(screen_height+2, screen_width+2)).Interior.Color = RGB(0, 0, 0)
    ClearScreen
End Sub

' [Stats - Updates player's position and rotation in the Data sheet]
Sub WritePlayer()
    Worksheets("Data").Range("B4").Value = P.x
    Worksheets("Data").Range("B5").Value = P.y
    Worksheets("Data").Range("B6").Value = P.z
    Worksheets("Data").Range("B9").Value = P.r
    Worksheets("Data").Range("B10").Value = P.h
End Sub

' [Stats - Sets current timestamp to given cell]
Sub InsertCurrentTime(cellAddress As String)
    Dim currentTime As Date
    Dim milliseconds As Double
    Dim dataSheet As Worksheet
    Set dataSheet = ThisWorkbook.Sheets("Data")

    currentTime = Now
    milliseconds = Timer * 1000 Mod 1000
    dataSheet.Range(cellAddress).value = Format(currentTime, "hh:mm:ss") & "." & Format(milliseconds, "000")
End Sub