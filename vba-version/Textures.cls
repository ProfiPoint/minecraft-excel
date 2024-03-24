VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Textures"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private colorCollections As Collection
Private opacityCollections As Collection
Private blockTypeCollections As Collection
Private Type_ As String

' [get; set properties for variables]
Public Property Get textureType() As String
    textureType = Type_
End Property

Public Property Let textureType(value As String)
    Type_ = value
End Property

' [Loads the given range of cells from sheet Textures]
Public Sub LoadInput(textureName As String, blockType As String, inputRange As Range)
    Dim c As Long, r As Long
    Dim innerCollection As Collection
    Dim innerCollection2 As Collection

    ' Check if the colorCollections collection is initialized
    If colorCollections Is Nothing Then
        Set colorCollections = New Collection
    End If

    If opacityCollections Is Nothing Then
        Set opacityCollections = New Collection
    End If

    If blockTypeCollections Is Nothing Then
        Set blockTypeCollections = New Collection
    End If
    
    ' Check if the textureName already exists; if not, create a new collection
    If Not CollectionExists(textureName) Then
        Dim newCollection As New Collection
        colorCollections.Add newCollection, key:=textureName
    End If

    If Not BlockCollectionExists(textureName) Then
        Dim newCollection2 As New Collection
        blockTypeCollections.Add newCollection2, key:=textureName
    End If

    If Not OpacityCollectionsExists(textureName) Then
        Dim newCollection3 As New Collection
        opacityCollections.Add newCollection3, key:=textureName
    End If
    
    blockTypeCollections(textureName).Add blockType

    ' Store colors in the Collection of Collection associated with the textureName
    Set innerCollection = New Collection
    Set innerCollection2 = New Collection
    Dim cellText As Variant
    For r = 1 To 24
        Set innerCollection = New Collection
        Set innerCollection2 = New Collection
        For c = 1 To 32
            ' Store color in inner collection
            innerCollection.Add inputRange.Cells(25 - r, c).Interior.color
            
            ' Check if the text is empty, add 1 instead of 0
            If inputRange.Cells(25 - r, c).Text = "" Then
                cellText = Val(100)
            Else
                cellText = Replace(inputRange.Cells(25 - r, c).Text, ",", ".")
                Dim periodPosition As Integer
                periodPosition = InStr(cellText, ".")
                
                ' Convert the text to a decimal number
                If periodPosition > 0 Then
                    cellText = Replace(cellText, ".", "")
                    cellText = "0" & cellText
                Else
                    cellText = cellText & "00"
                End If
                cellText = CInt(cellText)
                cellText = cellText * 100
            End If

            innerCollection2.Add cellText
        Next c
        ' Store inner collection in the main collection associated with the textureName
        colorCollections(textureName).Add innerCollection
        opacityCollections(textureName).Add innerCollection2
    Next r
End Sub

' [Functions ready to be called from the Main module]
Public Function GetColorCollection(textureName As String) As Collection
    Set GetColorCollection = colorCollections(textureName)
End Function

Public Function GetBlockType(textureName As String) As String
    GetBlockType = blockTypeCollections(textureName)(1)
End Function

Public Function GetOpacity(textureName As String) As Collection
    Set GetOpacity = opacityCollections(textureName)
End Function

' [Preventing creating a new collection if the key already exists]
Private Function CollectionExists(key As Variant) As Boolean
    On Error Resume Next
    CollectionExists = Not colorCollections(key) Is Nothing
    On Error GoTo 0
End Function

Private Function BlockCollectionExists(key As Variant) As Boolean
    On Error Resume Next
    BlockCollectionExists = Not blockTypeCollections(key) Is Nothing
    On Error GoTo 0
End Function

Private Function OpacityCollectionsExists(key As Variant) As Boolean
    On Error Resume Next
    OpacityCollectionsExists = Not opacityCollections(key) Is Nothing
    On Error GoTo 0
End Function


