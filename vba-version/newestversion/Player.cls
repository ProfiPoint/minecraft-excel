VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Player"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private x_ As Long
Private y_ As Long
Private z_ As Long
Private r_ As Long
Private h_ As Long
Private f_ As Long

Public Property Get x() As Long
    x = x_
End Property
Public Property Let x(ByVal value As Long)
    x_ = value
End Property

Public Property Get y() As Long
    y = y_
End Property
Public Property Let y(ByVal value As Long)
    y_ = value
End Property

Public Property Get z() As Long
    z = z_
End Property
Public Property Let z(ByVal value As Long)
    z_ = value
End Property

Public Property Get r() As Long
    r = r_
End Property
Public Property Let r(ByVal value As Long)
    r_ = value
End Property

Public Property Get h() As Long
    h = h_
End Property
Public Property Let h(ByVal value As Long)
    h_ = value
End Property

Public Property Get f() As Long
    f = f_
End Property
Public Property Let f(ByVal value As Long)
    f_ = value
End Property



