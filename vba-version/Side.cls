VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Side"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private distance_ As Double
Private texture_ As String
Private middlePoint_ As Variant
Private orientation_ As String
Private a_ As Variant
Private b_ As Variant
Private c_ As Variant
Private d_ As Variant

Public Property Get distance() As Double
    distance = distance_
End Property

Public Property Let distance(value As Double)
    distance_ = value
End Property

Public Property Get texture() As String
    texture = texture_
End Property

Public Property Let texture(value As String)
    texture_ = value
End Property

Public Property Get middlePoint() As Variant
    middlePoint = middlePoint_
End Property

Public Property Let middlePoint(value As Variant)
    middlePoint_ = value
End Property

Public Property Get orientation() As String
    orientation = orientation_
End Property

Public Property Let orientation(value As String)
    orientation_ = value
End Property

Public Property Get a() As Variant
    a = a_
End Property

Public Property Let a(value As Variant)
    a_ = value
End Property

Public Property Get b() As Variant
    b = b_
End Property

Public Property Let b(value As Variant)
    b_ = value
End Property

Public Property Get C() As Variant
    c = c_
End Property

Public Property Let C(value As Variant)
    c_ = value
End Property

Public Property Get d() As Variant
    d = d_
End Property

Public Property Let d(value As Variant)
    d_ = value
End Property



Public Sub Initialize(point As Variant, o As String, tex As String, blockSizeHalf As Double, blockType As String)
    middlePoint = point
    orientation = o
    texture = tex

    If blockType = "block" Then
        If o = "right" Or o = "left" Then
            a = SumTuple(middlePoint, Array(0, -blockSizeHalf, -blockSizeHalf))
            b = SumTuple(middlePoint, Array(0, blockSizeHalf, -blockSizeHalf))
            d = SumTuple(middlePoint, Array(0, -blockSizeHalf, blockSizeHalf))
            C = SumTuple(middlePoint, Array(0, blockSizeHalf, blockSizeHalf))
                
        ElseIf o = "front" Or o = "back" Then
            a = SumTuple(middlePoint, Array(-blockSizeHalf, -blockSizeHalf, 0))
            b = SumTuple(middlePoint, Array(-blockSizeHalf, blockSizeHalf, 0))
            d = SumTuple(middlePoint, Array(blockSizeHalf, -blockSizeHalf, 0))
            C = SumTuple(middlePoint, Array(blockSizeHalf, blockSizeHalf, 0))
            
        ElseIf o = "up" Or o = "down" Then
            a = SumTuple(middlePoint, Array(-blockSizeHalf, 0, -blockSizeHalf))
            b = SumTuple(middlePoint, Array(-blockSizeHalf, 0, blockSizeHalf))
            d = SumTuple(middlePoint, Array(blockSizeHalf, 0, -blockSizeHalf))
            C = SumTuple(middlePoint, Array(blockSizeHalf, 0, blockSizeHalf))
        End If
    
    ElseIf blockType = "slab" Then
        If o = "right" Or o = "left" Then
            a = SumTuple(middlePoint, Array(0, -blockSizeHalf/2, -blockSizeHalf))
            b = SumTuple(middlePoint, Array(0, blockSizeHalf/2, -blockSizeHalf))
            d = SumTuple(middlePoint, Array(0, -blockSizeHalf/2, blockSizeHalf))
            C = SumTuple(middlePoint, Array(0, blockSizeHalf/2, blockSizeHalf))
                
        ElseIf o = "front" Or o = "back" Then
            a = SumTuple(middlePoint, Array(-blockSizeHalf, -blockSizeHalf/2, 0))
            b = SumTuple(middlePoint, Array(-blockSizeHalf, blockSizeHalf/2, 0))
            d = SumTuple(middlePoint, Array(blockSizeHalf, -blockSizeHalf/2, 0))
            C = SumTuple(middlePoint, Array(blockSizeHalf, blockSizeHalf/2, 0))
            
        ElseIf o = "up" Or o = "down" Then
            a = SumTuple(middlePoint, Array(-blockSizeHalf, 0, -blockSizeHalf))
            b = SumTuple(middlePoint, Array(-blockSizeHalf, 0, blockSizeHalf))
            d = SumTuple(middlePoint, Array(blockSizeHalf, 0, -blockSizeHalf))
            C = SumTuple(middlePoint, Array(blockSizeHalf, 0, blockSizeHalf))
        End If
    End If

    
End Sub

Private Function SumTuple(v1 As Variant, v2 As Variant) As Variant
    SumTuple = Array(v1(0) + v2(0), v1(1) + v2(1), v1(2) + v2(2))
End Function

