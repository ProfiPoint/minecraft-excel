VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Calculations"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
' Class Module: ColorManager

Private colorCollections As Collection

Public Sub LoadInput(textureName As String, inputRange As Range)
    Dim c As Long, r As Long
    Dim innerCollection As Collection
    
    ' Check if the colorCollections collection is initialized
    If colorCollections Is Nothing Then
        Set colorCollections = New Collection
    End If
    
    ' Check if the textureName already exists; if not, create a new collection
    If Not CollectionExists(textureName) Then
        Dim newCollection As New Collection
        colorCollections.Add newCollection, Key:=textureName
    End If
    
    ' Store colors in the Collection of Collection associated with the textureName
    Set innerCollection = New Collection
    For r = 1 To 26
        Set innerCollection = New Collection
        For c = 1 To 8
            ' Store color in inner collection
            innerCollection.Add inputRange.Cells(27-r, c).Interior.Color
        Next c
        ' Store inner collection in the main collection associated with the textureName
        colorCollections(textureName).Add innerCollection
    Next r
End Sub

Public Function GetColorCollection(textureName As String) As Collection
    ' Return the stored color collection associated with the textureName
    Set GetColorCollection = colorCollections(textureName)
End Function

Private Function CollectionExists(key As Variant) As Boolean
    ' Check if the collection with the specified key exists
    On Error Resume Next
    CollectionExists = Not colorCollections(key) Is Nothing
    On Error GoTo 0
End Function
