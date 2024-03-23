VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Player"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private x_ As Long
Private y_ As Long
Private z_ As Long
Private yaw_ As Long
Private pitch_ As Long

' [get; set properties for variables]
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

Public Property Get yaw() As Long
    yaw = yaw_
End Property

Public Property Let yaw(ByVal value As Long)
    yaw_ = value
End Property

Public Property Get pitch() As Long
    pitch = pitch_
End Property

Public Property Let pitch(ByVal value As Long)
    pitch_ = value
End Property



