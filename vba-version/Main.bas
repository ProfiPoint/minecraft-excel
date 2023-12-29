Attribute VB_Name = "Main"
' [Public variables - Classes]
Public P As New Player
Public G As New Game
Public C As New Calculations
Public T As New Textures
Public Stats As New Stats

' [Public variables - Sheets]
Public ms As Worksheet ' Minecraft
Public ts As Worksheet ' Textures
Public ds As Worksheet ' Data

' [Initailize the game]
Sub Init()
    Call InsertCurrentTime("Data!E12") ' (stats) time log
    
    ' Sets the sheets
    Set ms = ThisWorkbook.Sheets("Minecraft")
    Set ts = ThisWorkbook.Sheets("Textures")
    Set ds = ThisWorkbook.Sheets("Data")
    
    CheckDefaultValues

    ' Applies player settings
    P.x = CInt(ds.Range("B4").Value)
    P.y = CInt(ds.Range("B5").Value)
    P.z = CInt(ds.Range("B6").Value)
    P.yaw = CInt(ds.Range("B9").Value)
    P.pitch = CInt(ds.Range("B10").Value)
    
    ' Loads block textures
    T.LoadInput "grass", ts.Range("K10:R17")
    T.LoadInput "dirt", ts.Range("AA10:AH35")
    T.LoadInput "stone", ts.Range("AQ10:AX35")
    T.LoadInput "wood", ts.Range("BG10:BN35")
    T.LoadInput "bedrock", ts.Range("BW10:CD35")
    T.LoadInput "cobblestone", ts.Range("CM10:CT35")
    T.LoadInput "diamond", ts.Range("DC10:DJ35")
    T.LoadInput "gold", ts.Range("DS10:DZ35")
    T.LoadInput "ice", ts.Range("EI10:EP35")
    T.LoadInput "sand", ts.Range("EY10:FF35")
    T.LoadInput "tnt", ts.Range("FO10:FV35")
    T.LoadInput "brick", ts.Range("GE10:GL35")
    T.LoadInput "crafting", ts.Range("GU10:HB35")
    T.LoadInput "leaves", ts.Range("HK10:HR35")
    T.LoadInput "rainbow", ts.Range("IA10:IH35")
    
    ds.Range("E19").value = "running" ' (stats) status log
    
    ' Precalculates cos, sin and tan values
    Dim i As Long
    For i = -90 To 359
        C.cos(i) = cos(i * (3.14159265359 / 180)) ' Calculate and set the cos values
        C.sin(i) = sin(i * (3.14159265359 / 180)) ' Calculate and set the sin values
        C.tan(i) = tan(i * (3.14159265359 / 180)) ' Calculate and set the sin values
    Next i
    Call InsertCurrentTime("Data!E13") ' (stats) time log
    Move ' Calculates the first frame
    bindKeys ' Binds the keys
End Sub

' [Unbinds the keys and resets the game]
Sub EndGame()
    freeKeys
    Call SetBackgroundColor
    ds.Range("E19").value = "not running"
End Sub

' [Calculates the current frame]
Sub Move()
    ' Resets stats values
    Stats.Blocks = 0
    Stats.VisibleSides = 0
    Stats.VisiblePixels = 0
    Stats.Cells = 0
    Stats.RowsDrawn = 0
    
    ds.Range("E19").value = "calculating..." ' (stats) status log
    Call InsertCurrentTime("Data!E14") ' (stats) time log
    
    If G.instantDrawing = TRUE Then
        Application.ScreenUpdating = FALSE
    End If
    
    Call SetBackgroundColor
    
    ' Calculates and sets pixels of the current frame
    Dim pixels As Collection
    Set pixels = CalculateSides(pixels)
    Set pixels = ApplyTexture(pixels)
    Set pixels = ConvertDraw2D(pixels)

    If G.instantDrawing = TRUE Then
        Application.ScreenUpdating = TRUE
    End If
    
    ' (stats) writes all stats values
    Call InsertCurrentTime("Data!E17") ' (stats) time log
    Call WritePlayer
    
    ds.Range("B13").Value = Stats.Blocks
    ds.Range("B16").Value = Stats.VisibleSides
    ds.Range("B17").Value = Stats.VisiblePixels
    ds.Range("B18").Value = Stats.Cells
    ds.Range("B19").Value = Stats.RowsDrawn
    ds.Range("E19").value = "running"
End Sub

' [Creates 6 Sides of a Block when creating a new Block]
Function InitBlock(middle As Variant, texture As String) As Block
    Dim b As Block
    Set b = New Block
    b.Initialize (middle)
    
    Dim side1 As Side
    Set side1 = New Side
    Dim side2 As Side
    Set side2 = New Side
    Dim side3 As Side
    Set side3 = New Side
    Dim side4 As Side
    Set side4 = New Side
    Dim side5 As Side
    Set side5 = New Side
    Dim side6 As Side
    Set side6 = New Side
    
    side1.Initialize SumTuple(middle, Array(G.blockSizeHalf, 0, 0)), "right", texture, G.blockSizeHalf
    side2.Initialize SumTuple(middle, Array(-G.blockSizeHalf, 0, 0)), "left", texture, G.blockSizeHalf
    side3.Initialize SumTuple(middle, Array(0, 0, G.blockSizeHalf)), "back", texture, G.blockSizeHalf
    side4.Initialize SumTuple(middle, Array(0, 0, -G.blockSizeHalf)), "front", texture, G.blockSizeHalf
    side5.Initialize SumTuple(middle, Array(0, G.blockSizeHalf, 0)), "up", texture, G.blockSizeHalf
    side6.Initialize SumTuple(middle, Array(0, -G.blockSizeHalf, 0)), "down", texture, G.blockSizeHalf
    
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
        If ds.Cells(i, 7).Value <> "NONE" Then
            Stats.Blocks = Stats.Blocks + 1
            blocks.Add InitBlock(Array(ds.Cells(i, 8).Value, ds.Cells(i, 9).Value, ds.Cells(i, 10).Value), ds.Cells(i, 7).Value)
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
    
    Dim s As Side
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

' [Apply textures to the Sides]
Function ApplyTexture(allSidesPre As Collection) As Collection
    Dim allSquares As New Collection
    Dim sIndex As Variant
    Dim s As Side
    Dim x As Long
    Dim y As Long
    Dim bPixel As Pixel
    Dim cPixel As Pixel
    Dim dPixel As Pixel
    Dim newPixel As New pixel
    Dim textureColor As Collection
    
    ' Applies textures to the Sides
    For Each sIndex In allSidesPre
        Stats.VisibleSides = Stats.VisibleSides + 1
        Set s = sIndex
        Set textureColor = T.GetColorCollection(s.texture)
        For x = 0 To 7
            For y = 0 To 7
                Dim col As Long
                Dim ad As Variant
                Dim ab As Variant
                Dim a3 As Variant
                Dim b3 As Variant
                Dim c3 As Variant
                Dim d3 As Variant
                
                ' Calculates the vector ad and ab of the Side
                ad = Array((s.d(0) - s.a(0)) / 8, (s.d(1) - s.a(1)) / 8, (s.d(2) - s.a(2)) / 8)
                ab = Array((s.b(0) - s.a(0)) / 8, (s.b(1) - s.a(1)) / 8, (s.b(2) - s.a(2)) / 8)
                
                ' Calculates the corners of the current Pixel based on the vectors and current Pixel position
                a3 = SumTuple(SumTuple(s.a, Array(ad(0) * x, ad(1) * x, ad(2) * x)), Array(ab(0) * y, ab(1) * y, ab(2) * y))
                b3 = SumTuple(SumTuple(s.a, Array(ad(0) * x, ad(1) * x, ad(2) * x)), Array(ab(0) * (y + 1), ab(1) * (y + 1), ab(2) * (y + 1)))
                c3 = SumTuple(SumTuple(s.a, Array(ad(0) * (x + 1), ad(1) * (x + 1), ad(2) * (x + 1))), Array(ab(0) * (y + 1), ab(1) * (y + 1), ab(2) * (y + 1)))
                d3 = SumTuple(SumTuple(s.a, Array(ad(0) * (x + 1), ad(1) * (x + 1), ad(2) * (x + 1))), Array(ab(0) * (y), ab(1) * (y), ab(2) * (y)))
                
                ' Picks a pixel from the correct texture based on the orientation of the Side
                If s.orientation = "up" Then
                    col = textureColor(y+1+18)(8-x)
                ElseIf s.orientation = "down" Then
                    col = textureColor(y+1)(8-x)
                Else
                    ' Ensures that the texture will be drawn from the correct side (not mirrored)
                    If a3(0) > d3(0) Then
                        col = textureColor(y+1+9)(8-x)
                    Else
                        col = textureColor(y+1+9)(x+1)
                    End If
                End If
                
                ' Checks if the Pixel is inside the field of view and not behind the player
                If IsPointInsideFOV(a3) = TRUE Or IsPointInsideFOV(b3) = TRUE Or IsPointInsideFOV(c3) = TRUE Or IsPointInsideFOV(d3) = TRUE Then
                    Stats.VisiblePixels = Stats.VisiblePixels + 1
                    Set newPixel = New pixel
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
        If CountOffclips(squareVertexes) = 0 Then
            ' Gets the line of the Pixel
            For i = 1 To 4
                startPoint = squareVertices2d(i)
                endPoint = squareVertices2d((i Mod 4) + 1)
                Call GetLinePixels(startPoint, endPoint, pixelsByY)
            Next i
            
            ' Gets the minimum and maximum y value of the Pixel	
            For Each vertices In squareVertices2d
                Dim currentY As Long
                currentY = vertices(1)
                
                If currentY < minY Then
                    minY = currentY
                End If
                
                If currentY > maxY Then
                    maxY = currentY
                End If
            Next vertices
            
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