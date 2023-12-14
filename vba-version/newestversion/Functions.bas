Attribute VB_Name = "Functions"

Public rotated_vertex(0 To 2) As Double

Function SumTuple(t1 As Variant, t2 As Variant) As Variant
    Dim result(0 To 0) As Double
    Dim i As Long
    For i = 0 To 2
        result(i) = t1(i) + t2(i)
    Next i
    SumTuple = result
End Function

Function DistancePoint(t1 As Variant) As Double
    DistancePoint = Sqr(t1(0) * t1(0) + t1(1) * t1(1) + t1(2) * t1(2))
End Function

Function ConvertToString(t1 As Variant) As String
    ConvertToString = CStr(t1(0)) & "," & CStr(t1(1)) & "," & CStr(t1(2))
End Function


Function CalculateRotation(Point As Variant) As Variant
    Dim translated_vertex(0 To 2) As Double
    Dim rotated_vertex_yaw(0 To 2) As Double
    Dim rotated_vertex_pitch(0 To 2) As Double

    ' Translate the point relative to the player's position
    translated_vertex(0) = Point(0) - P.x
    translated_vertex(1) = Point(1) - P.y
    translated_vertex(2) = Point(2) - P.z

    rotated_vertex_yaw(0) = translated_vertex(0) * c.cos(P.r) - translated_vertex(2) * c.sin(P.r)
    rotated_vertex_yaw(1) = translated_vertex(1)
    rotated_vertex_yaw(2) = translated_vertex(0) * c.sin(P.r) + translated_vertex(2) * c.cos(P.r)

    rotated_vertex_pitch(0) = rotated_vertex_yaw(0)
    rotated_vertex_pitch(1) = rotated_vertex_yaw(1) * c.cos(P.h) - rotated_vertex_yaw(2) * c.sin(P.h)
    rotated_vertex_pitch(2) = rotated_vertex_yaw(1) * c.sin(P.h) + rotated_vertex_yaw(2) * c.cos(P.h)

    ' Return the rotated vertex
    CalculateRotation = rotated_vertex_pitch
End Function

Sub RemoveDuplicateSides(allSidesPre As Collection)
    Dim sideDict As Object
    Set sideDict = CreateObject("Scripting.Dictionary")
    
    Dim side As Side
    For Each side In allSidesPre
        Dim middlePointKey As String
        middlePointKey = CStr(side.middlePoint(0)) & "-" & CStr(side.middlePoint(1)) & "-" & CStr(side.middlePoint(2))
        
        ' If the middlePoint is already in the dictionary, overwrite the existing entry
        If sideDict.Exists(middlePointKey) Then
            Set sideDict(middlePointKey) = side
        Else
            ' Otherwise, add the side to the dictionary
            sideDict.Add middlePointKey, side
        End If
    Next side
    
    ' Clear the original collection
    Set allSidesPre = New Collection
    
    ' Convert the dictionary back to the collection
    Dim key As Variant
    For Each key In sideDict.Keys
        allSidesPre.Add sideDict(key)
    Next key
End Sub


Function SortSidesByDistance(collectionOfSides As Collection) As Collection
    Dim sortedSides As Collection
    Set sortedSides = New Collection
    
    ' Create an array to store the distances and indices
    Dim distances() As Double
    Dim indices() As Long
    ReDim distances(1 To collectionOfSides.Count)
    ReDim indices(1 To collectionOfSides.Count)
    
    ' Populate the array with distances and indices
    Dim i As Long
    For i = 1 To collectionOfSides.Count
        distances(i) = collectionOfSides(i).distance
        indices(i) = i
    Next i
    
    ' Sort the array of distances and indices
    QuickSort distances, indices, 1, collectionOfSides.Count
    
    ' Populate the sortedSides collection based on sorted distances and indices
    For i = 1 To collectionOfSides.Count
        sortedSides.Add collectionOfSides(indices(i))
    Next i
    
    ' Return the sorted collection
    Set SortSidesByDistance = sortedSides
End Function


Function SortBlocksByDistance2(collectionOfSides As Collection) As Collection
    Dim sortedSides As Collection
    Set sortedSides = New Collection
    
    ' Create an array to store the distances and indices
    Dim distances() As Double
    Dim indices() As Long
    ReDim distances(1 To collectionOfSides.Count)
    ReDim indices(1 To collectionOfSides.Count)
    
    ' Populate the array with distances and indices
    Dim i As Long
    For i = 1 To collectionOfSides.Count
        distances(i) = collectionOfSides(i).distance
        indices(i) = i
    Next i
    
    ' Sort the array of distances and indices
    QuickSort distances, indices, 1, collectionOfSides.Count
    
    ' Populate the sortedSides collection based on sorted distances and indices
    For i = 1 To collectionOfSides.Count
        sortedSides.Add collectionOfSides(indices(i))
    Next i
    
    ' Return the sorted collection
    Set SortBlocksByDistance2 = sortedSides
End Function


' QuickSort algorithm with corresponding indices
Sub QuickSort(arr() As Double, indices() As Long, low As Long, high As Long)
    Dim pivot As Double
    Dim temp As Double
    Dim tempIndex As Long
    Dim i As Long
    Dim j As Long
    
    If low < high Then
        pivot = arr((low + high) \ 2)
        i = low
        j = high
        
        Do
            Do While arr(i) > pivot
                i = i + 1
            Loop
            Do While arr(j) < pivot
                j = j - 1
            Loop
            If i <= j Then
                ' Swap values at i and j, and corresponding indices
                temp = arr(i)
                arr(i) = arr(j)
                arr(j) = temp
                
                tempIndex = indices(i)
                indices(i) = indices(j)
                indices(j) = tempIndex
                
                i = i + 1
                j = j - 1
            End If
        Loop While i <= j
        
        ' Recursively sort the sub-arrays
        If low < j Then QuickSort arr, indices, low, j
        If i < high Then QuickSort arr, indices, i, high
    End If
End Sub

Function ReverseCollection(originalCollection As Collection) As Collection
    Dim reversedCollection As New Collection
    Dim i As Long

    ' Add items from originalCollection to reversedCollection in reverse order
    For i = originalCollection.Count To 1 Step -1
        reversedCollection.Add originalCollection(i)
    Next i

    ' Return the reversed collection
    Set ReverseCollection = reversedCollection
End Function

Function InsertCurrentTime2(cellAddress As String) As String
    ' Define variables
    Dim currentTime As Date
    Dim milliseconds As Double
    Dim dataSheet As Worksheet

    ' Set the reference to the "Data" sheet
    Set dataSheet = ThisWorkbook.Sheets("Data")

    ' Get the current time
    currentTime = Now

    ' Extract milliseconds
    milliseconds = Timer * 1000 Mod 1000

    dataSheet.Range(cellAddress).value = Format(currentTime, "hh:mm:ss") & "." & Format(milliseconds, "000")

    ' Return the inserted time as a string
    InsertCurrentTime = currentTime
End Function

Sub InsertCurrentTime(cellAddress As String)
    ' Define variables
    Dim currentTime As Date
    Dim milliseconds As Double
    Dim dataSheet As Worksheet

    ' Set the reference to the "Data" sheet
    Set dataSheet = ThisWorkbook.Sheets("Data")

    ' Get the current time
    currentTime = Now

    ' Calculate milliseconds since midnight
    milliseconds = Timer * 1000 Mod 1000

    ' Set the value in the specified cell with Unix timestamp
    dataSheet.Range(cellAddress).value = Format(currentTime, "hh:mm:ss") & "." & Format(milliseconds, "000")
End Sub

Sub SetPlayer() 
    P.x = Worksheets("Data").Range("B4").value
    P.y = Worksheets("Data").Range("B5").value
    P.z = Worksheets("Data").Range("B6").value
    P.r = Worksheets("Data").Range("B9").value
    P.h = Worksheets("Data").Range("B10").value
    P.f = 90 'not implemented as it is not needed
End Sub

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

Sub WritePlayer()
    Worksheets("Data").Range("B4").Value = P.x
    Worksheets("Data").Range("B5").Value = P.y
    Worksheets("Data").Range("B6").Value = P.z
    Worksheets("Data").Range("B9").Value = P.r
    Worksheets("Data").Range("B10").Value = P.h
End Sub

Sub ClearBackgroundColors()
    Dim ws As Worksheet
    Set ws = ThisWorkbook.Sheets("Minecraft") ' Change "Minecraft" to the name of your sheet

    ' Clear background color in all cells on the specified sheet
    ws.Cells.Interior.ColorIndex = xlNone
End Sub

Sub CreateNewSidesCollection()
    Dim allSidesPre As Collection
    Dim allSidesNew As Collection
    Dim sideDict As Object
    Dim side As Object
    Dim middleKey As String

    ' Initialize collections and dictionary
    Set allSidesPre = New Collection
    Set allSidesNew = New Collection
    Set sideDict = CreateObject("Scripting.Dictionary")

    ' Assuming allSidesPre is already populated with Side objects
    
    ' Loop through each Side in allSidesPre
    For Each side In allSidesPre
        ' Extract the middle values as a key for the dictionary
        middleKey = Join(side.middle, ",")
        
        ' Check if middleKey already exists in the dictionary
        If sideDict.Exists(middleKey) Then
            ' If exists, overwrite the existing side with the new side
            Set sideDict(middleKey) = side
        Else
            ' If not exists, add the middleKey to the dictionary and add the side to allSidesNew
            sideDict.Add middleKey, side
            allSidesNew.Add side
        End If
    Next side

    ' Now allSidesNew contains only unique sides based on Side.middle
    ' You can use allSidesNew as needed in your code
End Sub
