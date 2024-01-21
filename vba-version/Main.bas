Attribute VB_Name = "Main"
' [Public variables - Classes]
Public P As New Player
Public G As New Game
Public C As New Calculations
Public T As New Textures
Public Stats As New Stats

' [Public variables - Other]
Public HasBeenInitialized As Boolean ' Checks if the game has been initialized

' [Public variables - Sheets]
Public ms As Worksheet ' Minecraft
Public ts As Worksheet ' Textures
Public ds As Worksheet ' Data

Sub StartGame()
    Init
    Move
    BindKeys
End Sub

Sub StartGame2()
    Init2
    Move
    BindKeys
End Sub

' [Initailize the game]

Sub Init2()
    ' Defines the sheets
    Set ms = ThisWorkbook.Sheets("Minecraft")
    Set ts = ThisWorkbook.Sheets("Textures")
    Set ds = ThisWorkbook.Sheets("Data")
    
    HasBeenInitialized = True
    CheckDefaultValues

    ' Applies player settings
    P.x = CInt(ds.Range("B4").value)
    P.y = CInt(ds.Range("B5").value)
    P.z = CInt(ds.Range("B6").value)
    P.yaw = CInt(ds.Range("B9").value)
    P.pitch = CInt(ds.Range("B10").value)
    
    ' Loads block textures
    T.LoadInput "grass", "block", ts.Range("AV9:CA32")
    T.LoadInput "dirt", "block", ts.Range("CJ9:DO32")
    T.LoadInput "stone", "block", ts.Range("DX9:FC32")
    T.LoadInput "wood", "block", ts.Range("FL9:GQ32")
    T.LoadInput "bedrock", "block", ts.Range("GZ9:IE32")
    T.LoadInput "cobblestone", "block", ts.Range("IN9:JS32")
    T.LoadInput "diamond", "block", ts.Range("KB9:LG32")
    T.LoadInput "gold", "block", ts.Range("LP9:MU32")
    T.LoadInput "ice", "block", ts.Range("AV43:CA66")
    T.LoadInput "sand", "block", ts.Range("CJ43:DO66")
    T.LoadInput "tnt", "block", ts.Range("DX43:FC66")
    T.LoadInput "brick", "block", ts.Range("FL43:GQ66")
    T.LoadInput "crafting", "block", ts.Range("GZ43:IE66")
    T.LoadInput "leaves", "block", ts.Range("IN43:JS66")
    T.LoadInput "rainbow", "block", ts.Range("KB43:LG66")
    T.LoadInput "stone_slab", "slab", ts.Range("CJ77:DO100")

    T.SaveTexturesToTxt()

    ' Precalculates cos, sin and tan values
End Sub

Sub Init()
    ' Defines the sheets
    Set ms = ThisWorkbook.Sheets("Minecraft")
    Set ts = ThisWorkbook.Sheets("Textures")
    Set ds = ThisWorkbook.Sheets("Data")
    
    ' Sets the sheets
    Call InsertCurrentTime("Data!E12") ' (stats) time log

    HasBeenInitialized = True
    CheckDefaultValues


    ' Applies player settings
    P.x = CInt(ds.Range("B4").value)
    P.y = CInt(ds.Range("B5").value)
    P.z = CInt(ds.Range("B6").value)
    P.yaw = CInt(ds.Range("B9").value)
    P.pitch = CInt(ds.Range("B10").value)
    
    ' Loads block textures
    T.LoadInput "grass", "block", ts.Range("AV9:CA32")
    T.LoadInput "dirt", "block", ts.Range("CJ9:DO32")
    T.LoadInput "stone", "block", ts.Range("DX9:FC32")
    T.LoadInput "wood", "block", ts.Range("FL9:GQ32")
    T.LoadInput "bedrock", "block", ts.Range("GZ9:IE32")
    T.LoadInput "cobblestone", "block", ts.Range("IN9:JS32")
    T.LoadInput "diamond", "block", ts.Range("KB9:LG32")
    T.LoadInput "gold", "block", ts.Range("LP9:MU32")
    T.LoadInput "ice", "block", ts.Range("AV43:CA66")
    T.LoadInput "sand", "block", ts.Range("CJ43:DO66")
    T.LoadInput "tnt", "block", ts.Range("DX43:FC66")
    T.LoadInput "brick", "block", ts.Range("FL43:GQ66")
    T.LoadInput "crafting", "block", ts.Range("GZ43:IE66")
    T.LoadInput "leaves", "block", ts.Range("IN43:JS66")
    T.LoadInput "rainbow", "block", ts.Range("KB43:LG66")
    T.LoadInput "stone_slab", "slab", ts.Range("CJ77:DO100")

    ds.Range("E19").value = "running" ' (stats) status log
    
    ' Precalculates cos, sin and tan values
    Dim i As Long
    For i = -90 To 359
        C.cos(i) = cos(i * (3.14159265359 / 180)) ' Calculate and set the cos values
        C.sin(i) = sin(i * (3.14159265359 / 180)) ' Calculate and set the sin values
        C.tan(i) = tan(i * (3.14159265359 / 180)) ' Calculate and set the sin values
    Next i
    Call InsertCurrentTime("Data!E13") ' (stats) time log
End Sub

' [Unbinds the keys and resets the game]
Sub EndGame()
    FreeKeys
    Call SetBackgroundColor
    ds.Range("E19").value = "not running"
End Sub

' [Calculates the current frame]
Sub Move()
    If Not HasBeenInitialized = True Then
        Init
    End If
    ' Resets stats values
    Stats.blocks = 0
    Stats.VisibleSides = 0
    Stats.VisiblePixels = 0
    Stats.Cells = 0
    Stats.RowsDrawn = 0
    
    ds.Range("E19").value = "calculating..." ' (stats) status log
    Call InsertCurrentTime("Data!E14") ' (stats) time log
    
    If G.instantDrawing = True Then
        Application.ScreenUpdating = False
    End If
    
    Call SetBackgroundColor
    
    ' Calculates and sets pixels of the current frame
    Dim pixels As Collection
    Set pixels = CalculateSides(pixels)
    Set pixels = ApplyTexture(pixels)
    Set pixels = ConvertDraw2D(pixels)

    If G.instantDrawing = True Then
        Application.ScreenUpdating = True
    End If
    
    ' (stats) writes all stats values
    Call InsertCurrentTime("Data!E17") ' (stats) time log
    Call WritePlayer
    
    ds.Range("B13").value = Stats.blocks
    ds.Range("B16").value = Stats.VisibleSides
    ds.Range("B17").value = Stats.VisiblePixels
    ds.Range("B18").value = Stats.Cells
    ds.Range("B19").value = Stats.RowsDrawn
    ds.Range("E19").value = "running"
End Sub

' [Creates 6 Sides of a Block when creating a new Block]
Function InitBlock(middle As Variant, texture As String) As Block
    Dim b As Block
    Dim blockType As String
    Set b = New Block
    blockType = T.GetBlockType(texture)

    b.Initialize (middle)
    
    Dim side1 As side
    Set side1 = New side
    Dim side2 As side
    Set side2 = New side
    Dim side3 As side
    Set side3 = New side
    Dim side4 As side
    Set side4 = New side
    Dim side5 As side
    Set side5 = New side
    Dim side6 As side
    Set side6 = New side
    
    If blockType = "block" Then
        side1.Initialize SumTuple(middle, Array(G.blockSizeHalf, 0, 0)), "right", texture, G.blockSizeHalf, blockType
        side2.Initialize SumTuple(middle, Array(-G.blockSizeHalf, 0, 0)), "left", texture, G.blockSizeHalf, blockType
        side3.Initialize SumTuple(middle, Array(0, 0, G.blockSizeHalf)), "back", texture, G.blockSizeHalf, blockType
        side4.Initialize SumTuple(middle, Array(0, 0, -G.blockSizeHalf)), "front", texture, G.blockSizeHalf, blockType
        side5.Initialize SumTuple(middle, Array(0, G.blockSizeHalf, 0)), "up", texture, G.blockSizeHalf, blockType
        side6.Initialize SumTuple(middle, Array(0, -G.blockSizeHalf, 0)), "down", texture, G.blockSizeHalf, blockType
    Else
        side1.Initialize SumTuple(middle, Array(G.blockSizeHalf, 0, 0)), "right", texture, G.blockSizeHalf, blockType
        side2.Initialize SumTuple(middle, Array(-G.blockSizeHalf, 0, 0)), "left", texture, G.blockSizeHalf, blockType
        side3.Initialize SumTuple(middle, Array(0, 0, G.blockSizeHalf)), "back", texture, G.blockSizeHalf, blockType
        side4.Initialize SumTuple(middle, Array(0, 0, -G.blockSizeHalf)), "front", texture, G.blockSizeHalf, blockType
        side5.Initialize SumTuple(middle, Array(0, G.blockSizeHalf/2, 0)), "up", texture, G.blockSizeHalf, blockType
        side6.Initialize SumTuple(middle, Array(0, -G.blockSizeHalf/2, 0)), "down", texture, G.blockSizeHalf, blockType
    End If
    
    
    Set b.sides = New Collection
    b.sides.Add side1
    b.sides.Add side2
    b.sides.Add side3
    b.sides.Add side4
    b.sides.Add side5
    b.sides.Add side6
    Set InitBlock = b
End Function

' [Loads all Blocks (type and coordinates) from the data sheet]
Function LoadBlocks(blocks As Collection) As Collection
    Dim i As Long

    For i = 4 To 256
        If ds.Cells(i, 7).value <> "NONE" and ds.Cells(i, 7).value <> "" Then
            Stats.blocks = Stats.blocks + 1
            blocks.Add InitBlock(Array(ds.Cells(i, 8).value, ds.Cells(i, 9).value, ds.Cells(i, 10).value), ds.Cells(i, 7).value)
        End If
    Next i
    
    Set LoadBlocks = blocks
End Function

' [Calculates the positions and rotations of Block Sides based on the player in 3D space]
Function CalculateSides(allSquares2 As Collection) As Collection
    Dim blocks As Collection
    Set blocks = New Collection
    Set blocks = LoadBlocks(blocks)
    Dim allSidesPre As New Collection
    
    
    Dim b As Block
    For Each b In blocks
        b.point = CalculateCoordinates(b.point) ' Calculates the rotation and position of the middle Block
        b.distance = DistancePoint(b.point) ' Calculates the distance of the Block from the player
    Next b
    
    ' Sorting Blocks by distance
    Set blocks = SortByDistance(blocks)
    
    Dim currentBlockSidesPre As New Collection
    Dim currentBlockSides As Collection
    
    Dim s As side
    For Each b In blocks
        Set currentBlockSidesPre = New Collection
        
        ' Calculates the rotation and position of the corners and middle of the Sides
        For Each s In b.sides
            s.middlePoint = CalculateCoordinates(s.middlePoint)
            s.a = CalculateCoordinates(s.a)
            s.b = CalculateCoordinates(s.b)
            s.c = CalculateCoordinates(s.c)
            s.d = CalculateCoordinates(s.d)
            s.distance = DistancePoint(s.middlePoint)
            
            currentBlockSidesPre.Add s
        Next s
        
        ' Sorting Sides by distance
        Set currentBlockSides = SortByDistance(currentBlockSidesPre)
        Set currentBlockSides = ReverseCollection(currentBlockSides)
        
        ' Optimizing the number of Sides to be drawn if the player is near the block
        If b.distance <= G.blockSize * Sqr(3) Then
            For i = 1 To 6
                allSidesPre.Add currentBlockSides(i)
            Next i
        Else
            For i = 1 To 3
                allSidesPre.Add currentBlockSides(i)
            Next i
        End If
    Next b
    
    ' Sorting Sides by distance - to prevent drawing of the Sides that are behind other Sides
    Set allSidesPre = SortByDistance(allSidesPre)
    RemoveDuplicateSides allSidesPre

    Set CalculateSides = allSidesPre
End Function


Function CompareAngles(A As Variant, B As Variant) As Boolean
    ' Calculate the angle between the origin (0, 0, 0) and point A
    Dim angle_A As Double

    If A(0) = 0 Or B(0) = 0 Then
        If A(0) > B(0) Then
        CompareAngles = True
        Else
            CompareAngles = False
        End If
    Else
        angle_A = A(2) / A(0)
        ' Calculate the angle between the origin (0, 0, 0) and point B
        Dim angle_B As Double
        angle_B = B(2) / B(0)

        ' Compare the angles and return the result
        If angle_A > angle_B Then
            CompareAngles = True
        Else
            CompareAngles = False
        End If
    End If

End Function



' [Apply textures to the Sides]
Function ApplyTexture(allSidesPre As Collection) As Collection
    Dim allSquares As New Collection
    Dim sIndex As Variant
    Dim s As side
    Dim x As Long
    Dim y As Long
    Dim bPixel As Pixel
    Dim cPixel As Pixel
    Dim dPixel As Pixel
    Dim newPixel As New Pixel
    Dim textureColor As Collection
    Dim blockType As String
    Dim yIter As Long

    ' Applies textures to the Sides
    For Each sIndex In allSidesPre
        Stats.VisibleSides = Stats.VisibleSides + 1
        Set s = sIndex
        Set textureColor = T.GetColorCollection(s.texture)
        blockType = T.GetBlockType(s.texture)
        yIter = 3

        If blockType = "block" Or s.orientation = "down" Or s.orientation = "up" Then
            yIter = 7
        End If

        For x = 0 To 7
            For y = 0 To yIter
                Dim col As Long
                Dim ad As Variant
                Dim ab As Variant
                Dim a3 As Variant
                Dim b3 As Variant
                Dim c3 As Variant
                Dim d3 As Variant
                
                ' Calculates the vector ad and ab of the Side
                If blockType = "block" Then
                    ad = Array((s.d(0) - s.a(0)) / 8, (s.d(1) - s.a(1)) / 8, (s.d(2) - s.a(2)) / 8)
                    ab = Array((s.b(0) - s.a(0)) / 8, (s.b(1) - s.a(1)) / 8, (s.b(2) - s.a(2)) / 8)
                Else
                    If s.orientation = "down" Or s.orientation = "up" Then
                        ad = Array((s.d(0) - s.a(0)) / 8, (s.d(1) - s.a(1)) / 8, (s.d(2) - s.a(2)) / 8)
                        ab = Array((s.b(0) - s.a(0)) / 8, (s.b(1) - s.a(1)) / 8, (s.b(2) - s.a(2)) / 8)
                    Else
                        ad = Array((s.d(0) - s.a(0)) / 8, (s.d(1) - s.a(1)) / 4, (s.d(2) - s.a(2)) / 8)
                        ab = Array((s.b(0) - s.a(0)) / 8, (s.b(1) - s.a(1)) / 4, (s.b(2) - s.a(2)) / 8)
                    End If
                End If
                
                
                ' Calculates the corners of the current Pixel based on the vectors and current Pixel position
                a3 = SumTuple(SumTuple(s.a, Array(ad(0) * x, ad(1) * x, ad(2) * x)), Array(ab(0) * y, ab(1) * y, ab(2) * y))
                b3 = SumTuple(SumTuple(s.a, Array(ad(0) * x, ad(1) * x, ad(2) * x)), Array(ab(0) * (y + 1), ab(1) * (y + 1), ab(2) * (y + 1)))
                c3 = SumTuple(SumTuple(s.a, Array(ad(0) * (x + 1), ad(1) * (x + 1), ad(2) * (x + 1))), Array(ab(0) * (y + 1), ab(1) * (y + 1), ab(2) * (y + 1)))
                d3 = SumTuple(SumTuple(s.a, Array(ad(0) * (x + 1), ad(1) * (x + 1), ad(2) * (x + 1))), Array(ab(0) * (y), ab(1) * (y), ab(2) * (y)))
                
                
                
                ' Picks a pixel from the correct texture based on the orientation of the Side
                If s.orientation = "down" Then
                    col = textureColor(y + 1)(x+1+8)
                ElseIf s.orientation = "up" Then
                    col = textureColor(y + 1+8+8)(x+1+8)
                ElseIf s.orientation = "left" Then
                    If CompareAngles(a3, d3) = True Then
                        col = textureColor(y + 1 + 8)(x+1)
                    Else
                        col = textureColor(y + 1 + 8)(8-x)
                    End If
                ElseIf s.orientation = "front" Then
                    If CompareAngles(a3, d3) = True Then
                        col = textureColor(y + 1 + 8)(x+1+8)
                    Else
                        col = textureColor(y + 1 + 8)(8-x+8)
                    End If
                ElseIf s.orientation = "right" Then
                   If CompareAngles(a3, d3) = True Then
                        col = textureColor(y + 1 + 8)(x+1+8+8)
                    Else
                        col = textureColor(y + 1 + 8)(8-x+8+8)
                    End If
                ElseIf s.orientation = "back" Then
                    If CompareAngles(a3, d3) = True Then
                        col = textureColor(y + 1 + 8)(x+1+8+8+8)
                    Else
                        col = textureColor(y + 1 + 8)(8-x+8+8+8)
                    End If
                End If
                
                ' Checks if the Pixel is inside the field of view and not behind the player
                If IsPointInsideFOV(a3) = True Or IsPointInsideFOV(b3) = True Or IsPointInsideFOV(c3) = True Or IsPointInsideFOV(d3) = True Then
                    Stats.VisiblePixels = Stats.VisiblePixels + 1
                    Set newPixel = New Pixel
                    newPixel.Initialize a3, b3, c3, d3, col
                    allSquares.Add newPixel
                End If
            Next y
        Next x
    Next sIndex
    Call InsertCurrentTime("Data!E15") ' (stats) time log

    Set ApplyTexture = allSquares
End Function

' [Projects 3D points to 2D points and draws them]
Function ConvertDraw2D(allSquares As Collection) As Collection
    Dim currentSquare As Pixel
    Dim pixelsByY As Object
    Dim squareVertices2d As New Collection
    Dim squareVertexes As New Collection
    Dim intersectionPoint As Variant
    Dim i As Long
    Dim startPoint As Variant
    Dim endPoint As Variant
    Dim minY As Long
    Dim maxY As Long
    Dim y As Long
    Dim x As Long
    
    For Each currentSquare In allSquares
        Set pixelsByY = CreateObject("Scripting.Dictionary")
        Set squareVertices2d = New Collection
        Set squareVertexes = New Collection
        
        minY = 2147483647 ' Initialize the maximum possible value
        maxY = 0
        
        For Each intersectionPoint In Array(currentSquare.a3, currentSquare.b3, currentSquare.c3, currentSquare.d3)
            squareVertexes.Add intersectionPoint
        
            ' Projects 3D points to 2D points
            If Int(intersectionPoint(2)) = 0 Then
                intersectionPoint = Array(intersectionPoint(0), intersectionPoint(1), 1)
            End If
            
            projectedX = intersectionPoint(0) / intersectionPoint(2)
            projectedY = intersectionPoint(1) / intersectionPoint(2)
            
            ' Multiplies the projected points by the screen size
            If G.screenHeight < G.screenWidth Then
                screenX = Int((projectedX + 1) * 0.5 * G.screenHeight + (G.screenWidth - G.screenHeight) / 2)
                screenY = Int((1 - projectedY) * 0.5 * G.screenHeight)
            Else
                screenX = Int((projectedX + 1) * 0.5 * G.screenWidth)
                screenY = Int((1 - projectedY) * 0.5 * G.screenWidth + (G.screenHeight - G.screenWidth) / 2)
            End If
            
            squareVertices2d.Add Array(screenX, screenY)
        Next intersectionPoint
        
        ' Draws the Pixel on the screen if all 4 vertices are inside the field of view
        If CountOffClips(squareVertexes) = 0 Then
            ' Gets the line of the Pixel
            For i = 1 To 4
                startPoint = squareVertices2d(i)
                endPoint = squareVertices2d((i Mod 4) + 1)
                Call GetLinePixels(startPoint, endPoint, pixelsByY)
            Next i
            
            ' Gets the minimum and maximum y value of the Pixel
            For Each Vertices In squareVertices2d
                Dim currentY As Long
                currentY = Vertices(1)
                
                If currentY < minY Then
                    minY = currentY
                End If
                
                If currentY > maxY Then
                    maxY = currentY
                End If
            Next Vertices
            
            If minY <= 0 Then
                minY = 1
            End If
            If maxY > G.screenHeight Then
                maxY = G.screenHeight
            End If
            
            Call InsertCurrentTime("Data!E16") ' (stats) time log
            
            ' Draws the Pixel on the screen
            For y = minY To maxY
                If pixelsByY.Exists(y) Then
                    If pixelsByY(y).Count > 0 Then
                        Call FillCellsInRange(CInt(pixelsByY(y)("Min")), y, CInt(pixelsByY(y)("Max")), y, currentSquare.color)
                    End If
                End If
            Next y
        End If
    Next currentSquare
    
    Set ConvertDraw2D = allSquares
End Function
