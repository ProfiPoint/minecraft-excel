'[README: INSTRUCTION OF HOW TO USE THIS MODULE]
'Modified version of program can take automaticly screenshots and render frames without any user interaction.

'Add SaveRangeAsPNG Sub from this file into Main.bas
'You can create simmilar Sub like LoopThroughNumbers Sub to auto-rotate camera around the build. Add to the end of the Sub Move Sub.
'If you are using any Sub from Keys.bas, you should disable (comment with ' the Move at the end of each Key-Sub, in order to stop multiple rendering of the same time)
'After you can use any program to make gif/video out of the png frames.

' Modified version of this program can be found online on: https://github.com/ProfiPoint/minecraft-excel/tree/main/animations
' For more check https://github.com/profipoint/minecraft-excel (README.md)



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
