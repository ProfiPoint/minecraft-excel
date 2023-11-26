Attribute VB_Name = "Functions"


Function SumTuple(t1 As Variant, t2 As Variant) As Variant
    Dim result(0 To 0) As Double
    Dim i As Integer
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
    Dim rotated_vertex_pitch(0 To 2) As Double
    Dim rotated_vertex(0 To 2) As Double

    translated_vertex(0) = Point(0) - P.x
    translated_vertex(1) = Point(1) - P.y
    translated_vertex(2) = Point(2) - P.z

    rotated_vertex_pitch(0) = translated_vertex(0)
    rotated_vertex_pitch(1) = translated_vertex(1) * c.cos(P.h) - translated_vertex(2) * c.sin(P.h)
    rotated_vertex_pitch(2) = translated_vertex(1) * c.sin(P.h) + translated_vertex(2) * c.cos(P.h)

    rotated_vertex(0) = rotated_vertex_pitch(0) * c.cos(P.r) - rotated_vertex_pitch(2) * c.sin(P.r)
    rotated_vertex(1) = rotated_vertex_pitch(1)
    rotated_vertex(2) = rotated_vertex_pitch(0) * c.sin(P.r) + rotated_vertex_pitch(2) * c.cos(P.r)

    CalculateRotation = rotated_vertex
End Function


Function SortSidesByDistance(collectionOfSides As Collection) As Collection
    Dim sortedSides As Collection
    Set sortedSides = New Collection
    
    ' Create an array to store the distances and indices
    Dim distances() As Double
    Dim indices() As Integer
    ReDim distances(1 To collectionOfSides.Count)
    ReDim indices(1 To collectionOfSides.Count)
    
    ' Populate the array with distances and indices
    Dim i As Integer
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

' QuickSort algorithm with corresponding indices
Sub QuickSort(arr() As Double, indices() As Integer, low As Integer, high As Integer)
    Dim pivot As Double
    Dim temp As Double
    Dim tempIndex As Integer
    Dim i As Integer
    Dim j As Integer
    
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
    Dim i As Integer

    ' Add items from originalCollection to reversedCollection in reverse order
    For i = originalCollection.Count To 1 Step -1
        reversedCollection.Add originalCollection(i)
    Next i

    ' Return the reversed collection
    Set ReverseCollection = reversedCollection
End Function

Function InsertCurrentTime(cellAddress As String) As String
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