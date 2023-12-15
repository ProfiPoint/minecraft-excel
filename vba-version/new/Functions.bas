Attribute VB_Name = "Functions"

Function CalculateTimeDifference(hhmmss1 As String, hhmmss2 As String) As String
    ' Extract hours, minutes, and seconds from the time text
    Dim h1 As Integer, m1 As Integer, s1 As Double
    Dim h2 As Integer, m2 As Integer, s2 As Double

    ' Convert time text to hours, minutes, and seconds
    h1 = CInt(Left(hhmmss1, 2))
    m1 = CInt(Mid(hhmmss1, 4, 2))
    s1 = CDbl(Left(hhmmss1, 7))

    h2 = CInt(Left(hhmmss2, 2))
    m2 = CInt(Mid(hhmmss2, 4, 2))
    s2 = CDbl(Left(hhmmss2, 7))

    ' Calculate the time difference
    Dim hDiff As Integer, mDiff As Integer, sDiff As Double
    hDiff = h2 - h1
    mDiff = m2 - m1
    sDiff = s2 - s1

    ' Adjust for negative differences
    If sDiff < 0 Then
        sDiff = sDiff + 60
        mDiff = mDiff - 1
    End If
    If mDiff < 0 Then
        mDiff = mDiff + 60
        hDiff = hDiff - 1
    End If

    ' Convert the time difference to a text string
    CalculateTimeDifference = hDiff & "h " & mDiff & "m " & Format(sDiff, "0.000") & "s"
End Function

Function ConvertToString(t1 As Variant) As String
    ConvertToString = CStr(t1(0)) & "," & CStr(t1(1)) & "," & CStr(t1(2))
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



Function SortBlocksByDistance(blocks As Collection) As Collection
    Dim sortedBlocks As New Collection
    Dim b As Block

    For Each b In blocks
        sortedBlocks.Add b, CStr(b.distance)
    Next b

    Set SortBlocksByDistance = sortedBlocks
End Function



