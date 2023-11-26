VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Player"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private x_ As Integer
Private y_ As Integer
Private z_ As Integer
Private r_ As Integer
Private h_ As Integer
Private f_ As Integer

Public Property Get x() As Integer
    x = x_
End Property
Public Property Let x(ByVal value As Integer)
    x_ = value
End Property

Public Property Get y() As Integer
    y = y_
End Property
Public Property Let y(ByVal value As Integer)
    y_ = value
End Property

Public Property Get z() As Integer
    z = z_
End Property
Public Property Let z(ByVal value As Integer)
    z_ = value
End Property

Public Property Get r() As Integer
    r = r_
End Property
Public Property Let r(ByVal value As Integer)
    r_ = value
End Property

Public Property Get h() As Integer
    h = h_
End Property
Public Property Let h(ByVal value As Integer)
    h_ = value
End Property

Public Property Get f() As Integer
    f = f_
End Property
Public Property Let f(ByVal value As Integer)
    f_ = value
End Property



