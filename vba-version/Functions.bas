Attribute VB_Name = "Functions"
Option Explicit

' [Optimalization function - delete duplicate sides in the same middle]
' Creates a disctionary with middle points as keys and sides as values and then converts it back to a collection
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

' [Returns reversed collection]
Function ReverseCollection(originalCollection As Collection) As Collection
    Dim reversedCollection As New Collection
    Dim i As Long
    
    For i = originalCollection.Count To 1 Step -1
        reversedCollection.Add originalCollection(i)
    Next i
    
    Set ReverseCollection = reversedCollection
End Function

' [Returns sides sorted from furthest to closest to player]
Function SortByDistance(collectionOfSides As Collection) As Collection
    Dim sortedSides As Collection
    Set sortedSides = New Collection
    
    Dim distances() As Double
    Dim indices() As Long
    ReDim distances(1 To collectionOfSides.Count)
    ReDim indices(1 To collectionOfSides.Count)
    
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
    
    Set SortByDistance = sortedSides
End Function

' [QuickSort algorithm - sorts an array of Doubles and an array of Longs based on the Doubles]
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