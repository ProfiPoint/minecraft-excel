Attribute VB_Name = "Module1"
Sub SetRandomColors()
    Dim rng As Range
    Dim cell As Range
    
    ' Set the range (adjust as needed)
    Set rng = Range("A1:Z100")
    
    ' Disable screen updating for improved performance
    Application.ScreenUpdating = False
    
    ' Loop through each cell in the range and set a random color
    For Each cell In rng
        cell.Interior.color = RGB(Rnd() * 255, Rnd() * 255, Rnd() * 255)
    Next cell
    
    ' Enable screen updating again
    Application.ScreenUpdating = True
End Sub

