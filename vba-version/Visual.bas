Attribute VB_Name = "Visual"
Option Explicit

' [Clears the screen]
Sub ClearScreen()
    ms.Cells.Interior.ColorIndex = xlNone
End Sub

' [Sets the background color of the screen]
Sub SetBackgroundColor()
    Dim targetRange As Range

    Set targetRange = ms.Range(ms.Cells(2, 2), ms.Cells(G.screenHeight+1, G.screenWidth+1))

    
    targetRange.Interior.Color = RGB(205,252,255)
End Sub

' [Draws filled rectangle on the screen (in this case, xmin = xmax; so it's based on row)]
Sub FillCellsInRange(xmin As Long, ymin As Long, xmax As Long, ymax As Long, colorA As Variant)
    Stats.Cells = Stats.Cells + xmax - xmin + 1
    Stats.RowsDrawn = Stats.RowsDrawn + 1
    
    ' Prevents drawing outside of the screen but only if the range is not completely outside of the screen
    If xmin >= 1 And xmin <= G.screenWidth And xmax >= 1 And xmax > G.screenWidth Then
        xmax = G.screenWidth
    ElseIf xmin < 1 And xmin <= G.screenWidth And xmax >= 1 And xmax <= G.screenWidth Then
        xmin = 1
    End If
    
    If ymin >= 1 And ymin <= G.screenHeight And ymax >= 1 And ymax > G.screenHeight Then
        ymax = G.screenHeight
    ElseIf ymin < 1 And ymin <= G.screenHeight And ymax >= 1 And ymax <= G.screenHeight Then
        ymin = 1
    End If
    
    ' Check if the range is within the screen
    If xmin >= 1 And ymin >= 1 And xmax <= G.screenWidth And ymax <= G.screenHeight Then
        Dim targetRange As Range
        Set targetRange = ms.Range(ms.Cells(ymin+1, xmin+1), ms.Cells(ymax+1, xmax+1))
        targetRange.Interior.Color = colorA
    End If
End Sub

' [Checks if settings are set and sets them if not]
Sub CheckDefaultValues()
    If Not G.valuesSet Then
        SetPlayer
        SetVariables
        G.valuesSet = TRUE
    End If
End Sub

' [Sets the player variables from the Data sheet]
Sub SetPlayer()
    If Not HasBeenInitialized = TRUE Then
        Init
    End If
    P.x = ds.Range("B4").value
    P.y = ds.Range("B5").value
    P.z = ds.Range("B6").value
    P.yaw = ds.Range("B9").value
    P.pitch = ds.Range("B10").value
End Sub

' [Sets the enviroment variables from the Data sheet]
Sub SetVariables()
    If Not HasBeenInitialized = TRUE Then
        Init
    End If
    G.blockSize = ds.Range("E4").value
    G.screenWidth = ds.Range("E5").value
    G.screenHeight = ds.Range("E6").value
    G.moveBy = ds.Range("E7").value
    G.rotateBy = ds.Range("E8").value
    G.instantDrawing = ds.Range("E9").value
    G.blockSizeHalf = G.blockSize / 2
    ClearScreen
    ms.Range(ms.Cells(1, 1), ms.Cells(G.screenHeight+2, G.screenWidth+2)).Interior.Color = RGB(0, 0, 0)
    SetBackgroundColor
End Sub

' [Stats - Updates player's position and rotation in the Data sheet]
Sub WritePlayer()
    ds.Range("B4").Value = P.x
    ds.Range("B5").Value = P.y
    ds.Range("B6").Value = P.z
    ds.Range("B9").Value = P.yaw
    ds.Range("B10").Value = P.pitch
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