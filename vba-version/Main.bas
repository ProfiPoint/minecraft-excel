Attribute VB_Name = "Main"
Public blocks As Collection

Public P As New Player
Public c As New Calculations
Public Walls As New Collection

Public screenX As Integer
Public screenY As Integer

Public screen_width As Integer
Public screen_height As Integer
Public blockSize As Integer
Public blockSizeHalf As Double

Public allSquares2 As New Collection
Public textures As New BlockTextures
' xlwings vba edit

Sub Init()
    Call Functions.InsertCurrentTime("Data!E2")
    screen_width = 160
    screen_height = 90
    blockSize = 80
    blockSizeHalf = blockSize / 2

    P.x = 0
    P.y = -150
    P.z = 0
    P.r = 0
    P.h = 0
    P.f = 90

    
    textures.LoadInput "grass", Sheets("Textures").Range("K10:R17")
    textures.LoadInput "dirt", Sheets("Textures").Range("AA10:AH35")
    textures.LoadInput "stone", Sheets("Textures").Range("AQ10:AX35")

    Dim i As Integer
    For i = 0 To 359
        c.cos(i) = cos(i * (3.14159265359 / 180)) ' Calculate and set the cos values
        c.sin(i) = sin(i * (3.14159265359 / 180)) ' Calculate and set the sin values
    Next i
    
    Move
    Keys.bindKeys
End Sub

Sub Move()
    Call Functions.InsertCurrentTime("Data!E3")
    Application.ScreenUpdating = False
    Call ClearScreen
    Set allSquares = CalculatePositions
    Application.ScreenUpdating = True
    Call Functions.InsertCurrentTime("Data!E6")
End Sub

Sub EndGame()
    Keys.freeKeys
    Call ClearScreen
End Sub

Function SumTuple(t1 As Variant, t2 As Variant) As Variant
    Dim i As Integer
    Dim result() As Double
    ReDim result(LBound(t1) To UBound(t1))
    For i = LBound(t1) To UBound(t1)
        result(i) = t1(i) + t2(i)
    Next i
    SumTuple = result
End Function

Function DistancePoint(t1 As Variant) As Double
    DistancePoint = Sqr(t1(0) ^ 2 + t1(1) ^ 2 + t1(2) ^ 2)
End Function

Function ConvertToString(t1 As Variant) As String
    ConvertToString = CStr(t1(0)) & "," & CStr(t1(1)) & "," & CStr(t1(2))
End Function


Function CalculatePositions() As Collection
    Dim blocks As Collection
    Set blocks = New Collection

    Dim block As Block
    Set block = New Block
    block.Initialize (Array(0, 0, 0))

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

    side1.Initialize SumTuple(Array(0, 0, 0), Array(blockSizeHalf, 0, 0)), "right", "grass"
    side2.Initialize SumTuple(Array(0, 0, 0), Array(-blockSizeHalf, 0, 0)), "left", "grass"
    side3.Initialize SumTuple(Array(0, 0, 0), Array(0, 0, blockSizeHalf)), "back", "grass"
    side4.Initialize SumTuple(Array(0, 0, 0), Array(0, 0, -blockSizeHalf)), "front", "grass"
    side5.Initialize SumTuple(Array(0, 0, 0), Array(0, blockSizeHalf, 0)), "up", "grass"
    side6.Initialize SumTuple(Array(0, 0, 0), Array(0, -blockSizeHalf, 0)), "down", "grass"

    Set block.sides = New Collection
    block.sides.Add side1
    block.sides.Add side2
    block.sides.Add side3
    block.sides.Add side4
    block.sides.Add side5
    block.sides.Add side6

    blocks.Add block


    Dim allSidesPre As New Collection

    Dim b As Block
    For Each b In blocks
        b.point = CalculateRotation(b.point)
        b.distance = DistancePoint(b.point)
    Next b

    ' Sorting blocks by distance
    Set blocks = SortBlocksByDistance(blocks)

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
    Dim allSquares As New Collection

    Dim sIndex As Variant
    Dim x As Integer
    Dim y As Integer

    Dim bPixel As Pixel
    Dim cPixel As Pixel
    Dim dPixel As Pixel

    Dim newPixel As New pixel
    Dim textureColor As Collection

    ' works until here, tested
    For Each sIndex In allSidesPre
        Set s = sIndex
        Set textureColor = textures.GetColorCollection(s.texture)
        For x = 0 To 7
            For y = 0 To 7
                Dim col As Long
                Dim ad As Variant
                Dim ab As Variant
                Dim a3 As Variant
                Dim b3 As Variant
                Dim c3 As Variant
                Dim d3 As Variant

                If s.orientation = "up" Then
                    col = textureColor(y+1+18)(x+1)
                ElseIf s.orientation = "down" Then
                    col = textureColor(y+1)(x+1)
                Else
                    col = textureColor(y+1+9)(x+1)
                End If

               

                ad = Array((s.d(0) - s.a(0)) / 8, (s.d(1) - s.a(1)) / 8, (s.d(2) - s.a(2)) / 8)
                ab = Array((s.b(0) - s.a(0)) / 8, (s.b(1) - s.a(1)) / 8, (s.b(2) - s.a(2)) / 8)

                a3 = SumTuple(SumTuple(s.a, Array(ad(0) * x, ad(1) * x, ad(2) * x)), Array(ab(0) * y, ab(1) * y, ab(2) * y))
                b3 = SumTuple(SumTuple(s.a, Array(ad(0) * x, ad(1) * x, ad(2) * x)), Array(ab(0) * (y + 1), ab(1) * (y + 1), ab(2) * (y + 1)))
                c3 = SumTuple(SumTuple(s.a, Array(ad(0) * (x + 1), ad(1) * (x + 1), ad(2) * (x + 1))), Array(ab(0) * (y + 1), ab(1) * (y + 1), ab(2) * (y + 1)))
                d3 = SumTuple(SumTuple(s.a, Array(ad(0) * (x + 1), ad(1) * (x + 1), ad(2) * (x + 1))), Array(ab(0) * (y), ab(1) * (y), ab(2) * (y)))

                If a3(1) > 0 Or b3(1) > 0 Or c3(1) > 0 Or d3(1) > 0 Then
                    Set newPixel = New pixel
                    newPixel.Initialize a3, b3, c3, d3, col 'RGB(col Mod 256, (3057486 \ 256) Mod 256, (3057486 \ 256 \ 256) Mod 256)
                    allSquares.Add newPixel
                End If
            Next y
        Next x
    Next sIndex
    Call Functions.InsertCurrentTime("Data!E4")
    Set allSquares2 = Calculate(allSquares)

    Set CalculatePositions = allSquares2
End Function

Function SortBlocksByDistance(blocks As Collection) As Collection
    Dim sortedBlocks As New Collection
    Dim b As Block

    For Each b In blocks
        sortedBlocks.Add b, CStr(b.distance)
    Next b

    Set SortBlocksByDistance = sortedBlocks
End Function

Sub ClearScreen()
     ' Define the range A1:FD90
    Dim targetRange As Range
    Set targetRange = ThisWorkbook.Sheets("Minecraft").Range("A1:FD90") ' Replace "YourSheetName" with the actual sheet name

    ' Set the fill color to RGB(220, 220, 255)
    targetRange.Interior.Color = RGB(220, 220, 255)
End Sub

Sub DrawPoints(x As Integer, y As Integer, c As Variant)
    If 0 <= x And x < screen_width And 0 <= y And y < screen_height Then
        Worksheets("Minecraft").Cells(y + 1, x + 1).Interior.Color = c
    End If
End Sub

Sub GetLinePixels(start As Variant, endPt As Variant, pixels_by_y As Object, colorA As Variant)
    Dim x0 As Integer
    Dim y0 As Integer
    Dim x1 As Integer
    Dim y1 As Integer
    Dim dx As Integer
    Dim dy As Integer
    Dim sx As Integer
    Dim sy As Integer
    Dim err As Integer
    Dim e2 As Integer

    x0 = start(0)
    y0 = start(1)
    x1 = endPt(0)
    y1 = endPt(1)

    dx = Abs(x1 - x0)
    dy = Abs(y1 - y0)
    sx = IIf(x0 > x1, -1, 1)
    sy = IIf(y0 > y1, -1, 1)
    err = dx - dy

    Do While x0 <> x1 Or y0 <> y1
        If Not pixels_by_y.Exists(y0) Then
            Set pixels_by_y(y0) = CreateObject("Scripting.Dictionary")
            pixels_by_y(y0).Add "Min", 32767 ' Initialize with minimum possible value
            pixels_by_y(y0).Add "Max", -32767  ' Initialize with maximum possible value
        End If
        If y0 > 0 Then
            If x0 < pixels_by_y(y0)("Min") Then
                pixels_by_y(y0)("Min") = x0
            End If
            If x0 > pixels_by_y(y0)("Max") Then
                pixels_by_y(y0)("Max") = x0
            End If
        End If
        e2 = 2 * err
        If e2 > -dy Then
            err = err - dy
            x0 = x0 + sx
        End If
        If e2 < dx Then
            err = err + dx
            y0 = y0 + sy
        End If
    Loop
End Sub

Function Calculate(allSquares As Collection) As Collection
    'Set allSquares = ReverseCollection(allSquares)
    Dim squaresA As Pixel
    Dim display As Boolean
    Dim colorA As Long
    Dim pixels_by_y As Object
    Dim allpixels As New Collection
    Dim square_vertices_2d As New Collection
    Dim resal As New Collection
    Dim intersection_point As Variant
    Dim i As Integer
    Dim start_point As Variant
    Dim end_point As Variant
    Dim min_y As Integer
    Dim max_y As Integer
    Dim y As Integer
    Dim x As Integer
    
    For Each squaresA In allSquares
        display = True
        'colorA = squaresA.color
        Set pixels_by_y = CreateObject("Scripting.Dictionary")
        Set allpixels = New Collection
        Set square_vertices_2d = New Collection
        Set resal = New Collection

            min_y = 32767
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

            screen_x = Int((projected_x + 1) * 0.5 * screen_height + (screen_width - screen_height) / 2)
            screen_y = Int((1 - projected_y) * 0.5 * screen_height)
            square_vertices_2d.Add Array(screen_x, screen_y)
        Next intersection_point

        If CountOffclips(resal) = 0 Then
            For i = 1 To 4
                start_point = square_vertices_2d(i)
                end_point = square_vertices_2d((i Mod 4) + 1)
                Call GetLinePixels(start_point, end_point, pixels_by_y, colorA)
            Next i

            For Each vertices In square_vertices_2d
                Dim current_y As Integer
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

            For y = min_y To max_y
                If pixels_by_y.Exists(y) Then
                    If pixels_by_y(y).Count > 0 Then
                        Dim xIndex As Variant
                            For x = CInt(pixels_by_y(y)("Min")) To CInt(pixels_by_y(y)("Max"))
                                allpixels.Add Array(x, y)
                                'colorA = RGB(squaresA.color(1), squaresA.color(1), squaresA.color(2))
                                colorA = squaresA.color
                                'Call DrawPoints(x, y, colorA)
                            Next x
                    End If
                End If
            Next y
        End If
    Next squaresA
    Call Functions.InsertCurrentTime("Data!E5")
    Set Calculate = allSquares
End Function

Function CountOffClips(resal As Collection) As Integer
    Dim numberOfOffclips As Integer
    numberOfOffclips = 0

    If resal(1)(2) <= 0 Then
        numberOfOffclips = numberOfOffclips + 1
    End If
    If resal(2)(2) <= 0 Then
        numberOfOffclips = numberOfOffclips + 1
    End If
    If resal(3)(2) <= 0 Then
        numberOfOffclips = numberOfOffclips + 1
    End If

    CountOffClips = numberOfOffclips
End Function