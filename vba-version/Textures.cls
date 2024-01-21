Option Explicit

Private colorCollections As Collection
Private blockTypeCollections As Collection
Private Type_ As String

Public Property Get textureType() As String
    textureType = Type_
End Property

Public Property Let textureType(value As String)
    Type_ = value
End Property

Public Sub LoadInput(textureName As String, blockType As String, inputRange As Range)
    Dim c As Long, r As Long
    Dim innerCollection As Collection
    
    ' Check if the colorCollections collection is initialized
    If colorCollections Is Nothing Then
        Set colorCollections = New Collection
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
    
    blockTypeCollections(textureName).Add blockType

    ' Store colors in the Collection of Collection associated with the textureName
    Set innerCollection = New Collection
    For r = 1 To 24
        Set innerCollection = New Collection
        For c = 1 To 32
            ' Store color in inner collection
            innerCollection.Add inputRange.Cells(25 - r, c).Interior.color
        Next c
        ' Store inner collection in the main collection associated with the textureName
        colorCollections(textureName).Add innerCollection
    Next r
End Sub

Public Function GetColorCollection(textureName As String) As Collection
    ' Return the stored color collection associated with the textureName
    Set GetColorCollection = colorCollections(textureName)
End Function

Public Function GetBlockType(textureName As String) As String
    ' Return the stored color collection associated with the textureName
    GetBlockType = blockTypeCollections(textureName)(1)
End Function

Public Sub SaveTexturesToTxt()
    ' Save textures to a text file (C:/Users/profpoint/result.txt)
    Dim filePath As String
    Dim fileNumber As Integer
    Dim textureName As Variant
    
    ' Set the file path
    filePath = "C:/Users/profpoint/result.txt"
    
    ' Open the file for writing
    fileNumber = FreeFile
    Open filePath For Output As fileNumber
    
    ' Loop through each textureName in colorCollections
    For Each textureName In colorCollections.Keys
        ' Write texture information to the file
        Print #fileNumber, textureName & "," & blockTypeCollections(textureName)(1) & "," & GetHexColors(textureName)
    Next textureName
    
    ' Close the file
    Close fileNumber
End Sub

Private Function GetHexColors(textureName As String) As String
    ' Convert colors to hex and concatenate them
    Dim hexColors As String
    Dim innerCollection As Collection
    Dim color As Variant
    
    Set innerCollection = colorCollections(textureName)
    
    For Each color In innerCollection
        hexColors = hexColors & "," & RGBToHex(color)
    Next color
    
    GetHexColors = Mid(hexColors, 2) ' Remove the leading comma
End Function

Private Function RGBToHex(rgbColor As Long) As String
    ' Convert RGB color to hex
    RGBToHex = Right("000000" & Hex(rgbColor), 6)
End Function

Private Function CollectionExists(key As Variant) As Boolean
    ' Check if the collection with the specified key exists
    On Error Resume Next
    CollectionExists = Not colorCollections(key) Is Nothing
    On Error GoTo 0
End Function

Private Function BlockCollectionExists(key As Variant) As Boolean
    ' Check if the collection with the specified key exists
    On Error Resume Next
    BlockCollectionExists = Not blockTypeCollections(key) Is Nothing
    On Error GoTo 0
End Function
