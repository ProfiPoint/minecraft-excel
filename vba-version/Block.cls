VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Y_oldBlock"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
' Block Class Module
Option Explicit

Private distance_ As Double
Private point_ As Variant
Private sides_ As Collection
Private playerIsInside_ As Boolean

Public Property Get distance() As Double
    distance = distance_
End Property

Public Property Let distance(value As Double)
    distance_ = value
End Property

Public Property Get point() As Variant
    point = point_
End Property

Public Property Let point(value As Variant)
    point_ = value
End Property

Public Property Get sides() As Collection
    If sides_ Is Nothing Then
        Set sides_ = New Collection
    End If
    Set sides = sides_
End Property

Public Property Set sides(value As Collection)
    Set sides_ = value
End Property

Public Property Get playerIsInside() As Boolean
    playerIsInside = playerIsInside_
End Property

Public Property Let playerIsInside(value As Boolean)
    playerIsInside_ = value
End Property

Public Sub Initialize(P As Variant)
    point = P
End Sub


