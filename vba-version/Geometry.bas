Attribute VB_Name = "Geometry"
Option Explicit

' [Calculate the sum of two tuples]
Function SumTuple(t1 As Variant, t2 As Variant) As Variant
    Dim i As Long
    Dim result() As Double
    ReDim result(LBound(t1) To UBound(t1))
    For i = LBound(t1) To UBound(t1)
        result(i) = t1(i) + t2(i)
    Next i
    SumTuple = result
End Function

' [Return the distance between point a player (0,0,0)]
Function DistancePoint(t1 As Variant) As Double
    DistancePoint = Sqr(t1(0) ^ 2 + t1(1) ^ 2 + t1(2) ^ 2)
End Function

' [Calculate the 3D position of given 3D point relative to the player's position and camera orientation]
Function CalculateCoordinates(point As Variant) As Variant
    Dim translatedVertex(0 To 2) As Double
    Dim rotatedVertexYaw(0 To 2) As Double
    Dim rotatedVertexPitch(0 To 2) As Double
    
    ' Translate the point relative to the player's position
    translatedVertex(0) = point(0) - P.x
    translatedVertex(1) = point(1) - P.y
    translatedVertex(2) = point(2) - P.z
    
    ' Rotate the point around the player's yaw
    rotatedVertexYaw(0) = translatedVertex(0) * C.cos(P.yaw) - translatedVertex(2) * C.sin(P.yaw)
    rotatedVertexYaw(1) = translatedVertex(1)
    rotatedVertexYaw(2) = translatedVertex(0) * C.sin(P.yaw) + translatedVertex(2) * C.cos(P.yaw)
    
    ' Rotate the point around the player's pitch
    rotatedVertexPitch(0) = rotatedVertexYaw(0)
    rotatedVertexPitch(1) = rotatedVertexYaw(1) * C.cos(P.pitch) - rotatedVertexYaw(2) * C.sin(P.pitch)
    rotatedVertexPitch(2) = rotatedVertexYaw(1) * C.sin(P.pitch) + rotatedVertexYaw(2) * C.cos(P.pitch)
    
    CalculateCoordinates = rotatedVertexPitch
End Function

' [Optimalization function - returns the number of square vertexes that are behind the player]
Function CountOffClips(vertexes As Collection) As Long
    Dim numberOfOffclips As Long
    numberOfOffclips = 0
    
    If vertexes(1)(2) <= 0 Then
        numberOfOffclips = numberOfOffclips + 1
    End If
    If vertexes(2)(2) <= 0 Then
        numberOfOffclips = numberOfOffclips + 1
    End If
    If vertexes(3)(2) <= 0 Then
        numberOfOffclips = numberOfOffclips + 1
    End If
    
    CountOffClips = numberOfOffclips
End Function

' [Optimalization function - checks if the point is inside the player's field of view]
Function IsPointInsideFOV(point As Variant) As Boolean
    ' Project point onto the xy-plane
    Dim projectedPoint(0 To 1) As Double
    projectedPoint(0) = Abs(point(0))
    projectedPoint(1) = Abs(point(1))
    
    Dim result As Boolean
    result = False
    ' Check if the point is behind the player
    If point(2) <= 0 Then
        IsPointInsideFOV = result
        Exit Function
    End If

    ' Calculate radius of the circle on the xy-plane assuming FOV = 90 degrees
    Dim radius As Double
    radius = C.tan(90 / 2) * point(2)
    
    
    
    ' Check if the point is inside the pyramid (frustum)
    Dim distanceToOrigin As Double
    If G.screenWidth > G.screenHeight Then
        If (radius * G.screenWidth / G.screenHeight) - projectedPoint(0) >= 0 And radius - projectedPoint(1) >= 0 Then
            result = True
        End If
    Else
        If radius - projectedPoint(0) >= 0 And (radius * G.screenHeight / G.screenWidth) - projectedPoint(1) >= 0 Then
            result = True
        End If
    End If
    
    IsPointInsideFOV = result
End Function

' [Optimalization function - Creates dictionary of column (x) pixels indexed by the row (y) to speed up pixel drawing]
' Based on Bresenham's line algorithm
' Result will look like this: {y: {min: x, max: x} ... }
Sub GetLinePixels(startPt As Variant, endPt As Variant, pixelsByY As Object)
    Dim x0 As Long
    Dim y0 As Long
    Dim x1 As Long
    Dim y1 As Long
    Dim dx As Long
    Dim dy As Long
    Dim sx As Long
    Dim sy As Long
    Dim err As Long
    Dim e2 As Long
    
    x0 = startPt(0)
    y0 = startPt(1)
    x1 = endPt(0)
    y1 = endPt(1)
    
    dx = Abs(x1 - x0)
    dy = Abs(y1 - y0)
    sx = IIf(x0 > x1, -1, 1)
    sy = IIf(y0 > y1, -1, 1)
    err = dx - dy
    
    Do While x0 <> x1 Or y0 <> y1
        If Not pixelsByY.Exists(y0) Then
            Set pixelsByY(y0) = CreateObject("Scripting.Dictionary")
            pixelsByY(y0).Add "Min", 2147483647 ' Initialize with minimum possible value
            pixelsByY(y0).Add "Max", -2147483647 ' Initialize with maximum possible value
        End If
        If y0 > 0 Then
            If x0 < pixelsByY(y0)("Min") Then
                pixelsByY(y0)("Min") = x0
            End If
            If x0 > pixelsByY(y0)("Max") Then
                pixelsByY(y0)("Max") = x0
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
