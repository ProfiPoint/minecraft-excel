Attribute VB_Name = "Main"
Public blocks As Collection

Public P As New Player
Public C As New Calculations
Public Textures As New BlockTextures

Public screenX As Long
Public screenY As Long
Public screen_width As Long
Public screen_height As Long
Public blockSize As Long
Public blockSizeHalf As Double
Public moveBy As Long
Public rotateBy As Long
Public instantDrawing As Boolean

Public allSquares2 As New Collection


Public startTime As Long
Public endTime As Long

Public valuesSet As Boolean


Public statsBlocks As Long
Public statsVisiblePixels As Long
Public statsVisibleSides As Long
Public statsCells As Long
Public statsRowsDrawn As Long

' xlwings vba edit

Sub CheckDefaultValues()
    If Not valuesSet Then
        SetPlayer
        SetVariables
        valuesSet = True
    End If
End Sub

Sub Init()
    CheckDefaultValues
    Call InsertCurrentTime("Data!E12")

    P.x = CInt(Sheets("Data").Range("B4").Value)
    P.y = CInt(Sheets("Data").Range("B5").Value)
    P.z = CInt(Sheets("Data").Range("B6").Value)
    P.r = CInt(Sheets("Data").Range("B9").Value)
    P.h = CInt(Sheets("Data").Range("B10").Value)

    Textures.LoadInput "grass", Sheets("Textures").Range("K10:R17")
    Textures.LoadInput "dirt", Sheets("Textures").Range("AA10:AH35")
    Textures.LoadInput "stone", Sheets("Textures").Range("AQ10:AX35")
    Textures.LoadInput "wood", Sheets("Textures").Range("BG10:BN35")
    Textures.LoadInput "bedrock", Sheets("Textures").Range("BW10:CD35")
    Textures.LoadInput "cobblestone", Sheets("Textures").Range("CM10:CT35")
    Textures.LoadInput "diamond", Sheets("Textures").Range("DC10:DJ35")
    Textures.LoadInput "gold", Sheets("Textures").Range("DS10:DZ35")
    Textures.LoadInput "ice", Sheets("Textures").Range("EI10:EP35")
    Textures.LoadInput "sand", Sheets("Textures").Range("EY10:FF35")
    Textures.LoadInput "tnt", Sheets("Textures").Range("FO10:FV35")
    Textures.LoadInput "brick", Sheets("Textures").Range("GE10:GL35")
    Textures.LoadInput "crafting", Sheets("Textures").Range("GU10:HB35")
    Textures.LoadInput "leaves", Sheets("Textures").Range("HK10:HR35")
    Textures.LoadInput "rainbow", Sheets("Textures").Range("IA10:IH35")


    Worksheets("Data").Range("E19").value = "running"
    

    Dim i As Long
    For i = -90 To 359
        C.cos(i) = cos(i * (3.14159265359 / 180)) ' Calculate and set the cos values
        C.sin(i) = sin(i * (3.14159265359 / 180)) ' Calculate and set the sin values
        C.tan(i) = tan(i * (3.14159265359 / 180)) ' Calculate and set the sin values
    Next i
    Call InsertCurrentTime("Data!E13")
    Move
    Keys.bindKeys

    

End Sub






Sub Move()
    statsBlocks = 0
    statsVisibleSides = 0
    statsVisiblePixels = 0
    statsCells = 0
    statsRowsDrawn = 0
    Worksheets("Data").Range("E19").value = "calculating..."
    Call InsertCurrentTime("Data!E14")
    
    If instantDrawing = True Then
        Application.ScreenUpdating = False
    End If

    Call ClearScreen
    Set allSquares = CalculatePositions

    If instantDrawing = True Then
        Application.ScreenUpdating = True
    End If

    Call InsertCurrentTime("Data!E17")
    Call WritePlayer
    Worksheets("Data").Range("E19").value = "running"
    Dim ws As Worksheet
    Set ws = ThisWorkbook.Sheets("Data")

    ws.Range("B13").Value = statsBlocks
    ws.Range("B16").Value = statsVisibleSides
    ws.Range("B17").Value = statsVisiblePixels
    ws.Range("B18").Value = statsCells
    ws.Range("B19").Value = statsRowsDrawn
End Sub

Sub EndGame()
    Keys.freeKeys
    Call ClearScreen
    Worksheets("Data").Range("E19").value = "not running"
End Sub




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

    side1.Initialize SumTuple(middle, Array(blockSizeHalf, 0, 0)), "right", texture
    side2.Initialize SumTuple(middle, Array(-blockSizeHalf, 0, 0)), "left", texture
    side3.Initialize SumTuple(middle, Array(0, 0, blockSizeHalf)), "back", texture
    side4.Initialize SumTuple(middle, Array(0, 0, -blockSizeHalf)), "front", texture
    side5.Initialize SumTuple(middle, Array(0, blockSizeHalf, 0)), "up", texture
    side6.Initialize SumTuple(middle, Array(0, -blockSizeHalf, 0)), "down", texture

    Set b.sides = New Collection
    b.sides.Add side1
    b.sides.Add side2
    b.sides.Add side3
    b.sides.Add side4
    b.sides.Add side5
    b.sides.Add side6
    Set InitBlock = b
End Function

Function loadBlocks(blocks As Collection) As Collection
    Dim ws As Worksheet
    Dim i As Long
    Set ws = ThisWorkbook.Sheets("Data")
    
    For i = 4 To 256
        If ws.Cells(i, 7).Value <> "NONE" Then
            statsBlocks = statsBlocks + 1
            blocks.Add InitBlock(Array(ws.Cells(i, 8).Value, ws.Cells(i, 9).Value, ws.Cells(i, 10).Value), ws.Cells(i, 7).Value)
        End If
    Next i

    Set loadBlocks = blocks
End Function



Function CalculatePositions() As Collection
    Dim blocks As Collection
    Set blocks = New Collection
    Dim allSidesPre As New Collection
    Set blocks = loadBlocks(blocks)

    Dim b As Block
    For Each b In blocks
        b.point = CalculateRotation(b.point)
        b.distance = DistancePoint(b.point)
    Next b

    ' Sorting blocks by distance
    Set blocks = SortBlocksByDistance2(blocks)

    Dim currentBlockSidesPre As New Collection
    Dim currentBlockSides As Collection

    Dim s As Side
    For Each b In blocks
        Set currentBlockSidesPre = New Collection

        For Each s In b.sides
            s.middlePoint = CalculateRotation(s.middlePoint)
            s.a = CalculateRotation(s.a)
            s.b = CalculateRotation(s.b)
            s.c = CalculateRotation(s.c)
            s.d = CalculateRotation(s.d)
            s.distance = DistancePoint(s.middlePoint)

            currentBlockSidesPre.Add s
        Next s

        ' Sorting sides by distance
        Set currentBlockSides = SortSidesByDistance(currentBlockSidesPre)
        Set currentBlockSides = ReverseCollection(currentBlockSides)

        If b.distance <= blockSize * Sqr(3) Then
            For i = 1 To 6
                allSidesPre.Add currentBlockSides(i)
            Next i
        Else
            For i = 1 To 3
                allSidesPre.Add currentBlockSides(i)
            Next i
        End If
    Next b

    ' Sorting sides by distance
    Set allSidesPre = SortSidesByDistance(allSidesPre)
    'RemoveDuplicateSides allSidesPre
    Dim allSquares As New Collection

    Dim sIndex As Variant
    Dim x As Long
    Dim y As Long

    Dim bPixel As Pixel
    Dim cPixel As Pixel
    Dim dPixel As Pixel

    Dim newPixel As New pixel
    Dim textureColor As Collection

    ' works until here, tested
    For Each sIndex In allSidesPre
        statsVisibleSides = statsVisibleSides + 1
        Set s = sIndex
        Set textureColor = Textures.GetColorCollection(s.texture)
        For x = 0 To 7
            For y = 0 To 7
                Dim col As Long
                Dim ad As Variant
                Dim ab As Variant
                Dim a3 As Variant
                Dim b3 As Variant
                Dim c3 As Variant
                Dim d3 As Variant

                

               

                ad = Array((s.d(0) - s.a(0)) / 8, (s.d(1) - s.a(1)) / 8, (s.d(2) - s.a(2)) / 8)
                ab = Array((s.b(0) - s.a(0)) / 8, (s.b(1) - s.a(1)) / 8, (s.b(2) - s.a(2)) / 8)

                a3 = SumTuple(SumTuple(s.a, Array(ad(0) * x, ad(1) * x, ad(2) * x)), Array(ab(0) * y, ab(1) * y, ab(2) * y))
                b3 = SumTuple(SumTuple(s.a, Array(ad(0) * x, ad(1) * x, ad(2) * x)), Array(ab(0) * (y + 1), ab(1) * (y + 1), ab(2) * (y + 1)))
                c3 = SumTuple(SumTuple(s.a, Array(ad(0) * (x + 1), ad(1) * (x + 1), ad(2) * (x + 1))), Array(ab(0) * (y + 1), ab(1) * (y + 1), ab(2) * (y + 1)))
                d3 = SumTuple(SumTuple(s.a, Array(ad(0) * (x + 1), ad(1) * (x + 1), ad(2) * (x + 1))), Array(ab(0) * (y), ab(1) * (y), ab(2) * (y)))


                If s.orientation = "up" Then
                    col = textureColor(y+1+18)(8-x)
                ElseIf s.orientation = "down" Then
                    col = textureColor(y+1)(8-x)
                Else
                    If a3(0) > d3(0) Then
                        col = textureColor(y+1+9)(8-x)
                    Else
                        col = textureColor(y+1+9)(x+1)
                    End If
                End If 


                

                If a3(2) > 0 Or b3(2) > 0 Or c3(2) > 0 Or d3(2) > 0 Then
                    If IsPointInsideFOV(a3) = True Or IsPointInsideFOV(b3) = True Or IsPointInsideFOV(c3) = True Or IsPointInsideFOV(d3) = True Then
                        statsVisiblePixels = statsVisiblePixels + 1
                        Set newPixel = New pixel
                        newPixel.Initialize a3, b3, c3, d3, col 'RGB(col Mod 256, (3057486 \ 256) Mod 256, (3057486 \ 256 \ 256) Mod 256)
                        allSquares.Add newPixel
                    End If
                End If
            Next y
        Next x
    Next sIndex
    Call InsertCurrentTime("Data!E15")
    Set allSquares2 = Calculate(allSquares)

    Set CalculatePositions = allSquares2
End Function









Function Calculate(allSquares As Collection) As Collection
    'Set allSquares = ReverseCollection(allSquares)
    Dim squaresA As Pixel
    Dim display As Boolean
    Dim colorA As Long
    Dim pixels_by_y As Object
    Dim square_vertices_2d As New Collection
    Dim resal As New Collection
    Dim intersection_point As Variant
    Dim i As Long
    Dim start_point As Variant
    Dim end_point As Variant
    Dim min_y As Long
    Dim max_y As Long
    Dim y As Long
    Dim x As Long

    For Each squaresA In allSquares
        display = True
        'colorA = squaresA.color
        Set pixels_by_y = CreateObject("Scripting.Dictionary")
        Set square_vertices_2d = New Collection
        Set resal = New Collection

            min_y = 2147483647 ' Initialize with maximum possible value
            max_y = 0

        For Each intersection_point In Array(squaresA.a3, squaresA.b3, squaresA.c3, squaresA.d3)
            resal.Add intersection_point

            If Int(intersection_point(2)) <> 0 Then
                projected_x = intersection_point(0) / intersection_point(2)
                projected_y = intersection_point(1) / intersection_point(2)
            Else
                intersection_point = Array(intersection_point(0), intersection_point(1), 1)
                projected_x = intersection_point(0) / intersection_point(2)
                projected_y = intersection_point(1) / intersection_point(2)
            End If


            If screen_height < screen_width Then
                screen_x = Int((projected_x + 1) * 0.5 * screen_height + (screen_width - screen_height) / 2)
                screen_y = Int((1 - projected_y) * 0.5 * screen_height)
            Else
                screen_x = Int((projected_x + 1) * 0.5 * screen_width)
                screen_y = Int((1 - projected_y) * 0.5 * screen_width + (screen_height - screen_width) / 2)
            End If

            square_vertices_2d.Add Array(screen_x, screen_y)
        Next intersection_point


        If CountOffclips(resal) = 0 Then
            For i = 1 To 4
                start_point = square_vertices_2d(i)
                end_point = square_vertices_2d((i Mod 4) + 1)
                Call GetLinePixels(start_point, end_point, pixels_by_y, colorA)
            Next i

            For Each vertices In square_vertices_2d
                Dim current_y As Long
                current_y = vertices(1)

                If current_y < min_y Then
                    min_y = current_y
                End If
                
                If current_y > max_y Then
                    max_y = current_y
                End If
            Next vertices

            If min_y <= 0 Then
                min_y = 1
            End If
            If max_y > screen_height Then
                max_y = screen_height
            End If

            Call InsertCurrentTime("Data!E16")

            For y = min_y To max_y
                If pixels_by_y.Exists(y) Then
                    If pixels_by_y(y).Count > 0 Then
                        colorA = squaresA.color
                        Call FillCellsInRange(CInt(pixels_by_y(y)("Min")), y, CInt(pixels_by_y(y)("Max")), y, colorA)
                    End If
                End If
            Next y
        End If
    Next squaresA
    
    Set Calculate = allSquares
End Function

