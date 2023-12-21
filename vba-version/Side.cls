VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Side"
Attribute VB_GlobalNameSpace = False
Attribute VBc_reatable = False
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

Public Property Get c() As Variant
    c = c_
End Property

Public Property Let c(value As Variant)
    c_ = value
End Property

Public Property Get d() As Variant
    d = d_
End Property

Public Property Let d(value As Variant)
    d_ = value
End Property



Public Sub Initialize(p As Variant, o As String, t As String, blockSizeHalf As Double)
    middlePoint = p
    orientation = o
    texture = t

    If o = "right" Or o = "left" Then
        a = sumTuple(p, Array(0, -G.blockSizeHalf, -G.blockSizeHalf))
        b = sumTuple(p, Array(0, G.blockSizeHalf, -G.blockSizeHalf))
        d = sumTuple(p, Array(0, -G.blockSizeHalf, G.blockSizeHalf))
        c = sumTuple(p, Array(0, G.blockSizeHalf, G.blockSizeHalf))
            
    ElseIf o = "front" Or o = "back" Then
        a = sumTuple(p, Array(-G.blockSizeHalf, -G.blockSizeHalf, 0))
        b = sumTuple(p, Array(-G.blockSizeHalf, G.blockSizeHalf, 0))
        d = sumTuple(p, Array(G.blockSizeHalf, -G.blockSizeHalf, 0))
        c = sumTuple(p, Array(G.blockSizeHalf, G.blockSizeHalf, 0))
        
    ElseIf o = "up" Or o = "down" Then
        a = sumTuple(p, Array(-G.blockSizeHalf, 0, -G.blockSizeHalf))
        b = sumTuple(p, Array(-G.blockSizeHalf, 0, G.blockSizeHalf))
        d = sumTuple(p, Array(G.blockSizeHalf, 0, -G.blockSizeHalf))
        c = sumTuple(p, Array(G.blockSizeHalf, 0, G.blockSizeHalf))
    End If
End Sub

Private Function sumTuple(v1 As Variant, v2 As Variant) As Variant
    sumTuple = Array(v1(0) + v2(0), v1(1) + v2(1), v1(2) + v2(2))
End Function
