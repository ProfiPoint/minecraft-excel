VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Pixel"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private color_ As Long
Private opacity_ As Long
Private a3_ As Variant
Private b3_ As Variant
Private c3_ As Variant
Private d3_ As Variant

' [get; set properties for variables]
Public Property Get color() As Long
    color = color_
End Property

Public Property Let color(value As Long)
    color_ = value
End Property

Public Property Get a3() As Variant
    a3 = a3_
End Property

Public Property Let a3(value As Variant)
    a3_ = value
End Property

Public Property Get b3() As Variant
    b3 = b3_
End Property

Public Property Let b3(value As Variant)
    b3_ = value
End Property

Public Property Get c3() As Variant
    c3 = c3_
End Property

Public Property Let c3(value As Variant)
    c3_ = value
End Property

Public Property Get d3() As Variant
    d3 = d3_
End Property

Public Property Let d3(value As Variant)
    d3_ = value
End Property

Public Property Get opacity() As Double
    opacity = opacity_
End Property

Public Property Let opacity(value As Double)
    opacity_ = value
End Property

' [Initialize method]
Public Sub Initialize(A As Variant, B As Variant, c As Variant, d As Variant, col As Long, trans As Double)
    color = col
    a3 = A
    b3 = B
    c3 = c
    d3 = d
    opacity = trans
End Sub
