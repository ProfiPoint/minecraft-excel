'[EXAMPLE - AUTOMATIC ROTATIONG AROUND CENTER]
Sub LoopThroughNumbers()
    Dim i As Long
    For i = 1 To 101
        P.y = P.y + 50
        Move
        WritePlayer
        Application.Wait Now + TimeValue("0:00:08")
        SaveRangeAsPNG
        Next i
End Sub

'[SCREENSHOT FUNCTION (PrtSc)]
Sub SaveRangeAsPNG()
    Dim ws As Worksheet
    Dim rng As Range
    Dim filePath As String
    Dim shell As Object

    ' Set the active worksheet
    Set ws = ActiveSheet

    ' Set the range to be saved
    Set rng = ws.Range("A1:AWH720") ' Adjust the range accordingly

    ' Activate the worksheet
    ws.Activate

    ' Copy the range
    rng.Copy

    ' Simulate Win+PrtScn to take a screenshot
    keybd_event &H5B, 0, 0, 0 ' Press Win key
    keybd_event &H2C, 0, 0, 0 ' Press PrtScn key
    keybd_event &H2C, 0, 2, 0 ' Release PrtScn key
    keybd_event &H5B, 0, 2, 0 ' Release Win key
End Sub
