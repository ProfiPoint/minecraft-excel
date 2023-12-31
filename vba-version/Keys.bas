Attribute VB_Name = "Keys"
Option Explicit

' [Bind Keys] Shift + W/A/S/D/Q/E/R/F/X/{ } to move around
' + is shift; { } is ctrl
Sub BindKeys()
    Application.OnKey "+W", "MoveFront" ' z+ (if yaw is 0) generally x,z
    Application.OnKey "+S", "MoveBack" 'z- (if yaw is 0) generally x,z

    Application.OnKey "+{ }", "MoveUp" 'y+
    Application.OnKey "+X", "MoveDown" 'y-
    
    Application.OnKey "+A", "MoveLeft" ' x- (if yaw is 0) generally x,z
    Application.OnKey "+D", "MoveRight" ' x+ (if yaw is 0) generally x,z
    
    Application.OnKey "+R", "LookUp" ' x+ pitch
    Application.OnKey "+F", "LookDown" ' x- pitch
    
    Application.OnKey "+Q", "LookLeft" ' y- yaw 
    Application.OnKey "+E", "LookRight" 'y+ yaw
End Sub

Sub MoveUp()
    If Not HasBeenInitialized = True Then
        Init
    End If
    P.y = P.y + G.moveBy
    Move
End Sub

Sub MoveDown()
    If Not HasBeenInitialized = True Then
        Init
    End If
    P.y = P.y - G.moveBy
    Move
End Sub

Sub MoveRight()
    If Not HasBeenInitialized = True Then
        Init
    End If
    Dim dx As Long
    Dim dz As Long
    dx = CInt(C.sin(P.yaw) * G.moveBy)
    dz = CInt(C.cos(P.yaw) * G.moveBy)
    
    P.x = P.x + dz
    P.z = P.z - dx
    Move
End Sub

Sub MoveLeft()
    If Not HasBeenInitialized = True Then
        Init
    End If
    Dim dx As Long
    Dim dz As Long
    dx = CInt(C.sin(P.yaw) * G.moveBy)
    dz = CInt(C.cos(P.yaw) * G.moveBy)
    
    P.x = P.x - dz
    P.z = P.z + dx
    Move
End Sub

Sub MoveFront()
    If Not HasBeenInitialized = True Then
        Init
    End If
    Dim dx As Long
    Dim dz As Long
    dx = CInt(C.sin(P.yaw) * G.moveBy)
    dz = CInt(C.cos(P.yaw) * G.moveBy)
    
    P.x = P.x + dx
    P.z = P.z + dz
    Move
End Sub

Sub MoveBack()
    If Not HasBeenInitialized = True Then
        Init
    End If
    If Not HasBeenInitialized = True Then
        Init
    End If
    Dim dx As Long
    Dim dz As Long
    dx = CInt(C.sin(P.yaw) * G.moveBy)
    dz = CInt(C.cos(P.yaw) * G.moveBy)
    
    P.x = P.x - dx
    P.z = P.z - dz
    Move
End Sub

Sub LookUp()
    If Not HasBeenInitialized = True Then
        Init
    End If
    P.pitch = P.pitch + G.rotateBy
    If P.pitch > 90 Then
        P.pitch = 90
    End If
    Move
End Sub

Sub LookDown()
    If Not HasBeenInitialized = True Then
        Init
    End If
    P.pitch = P.pitch - G.rotateBy
    If P.pitch < -90 Then
        P.pitch = -90
    End If
    Move
End Sub

Sub LookLeft()
    If Not HasBeenInitialized = TRUE Then
        Init
    End If
    P.yaw = P.yaw - G.rotateBy
    If P.yaw < 0 Then
        P.yaw = P.yaw + 360
    End If
    Move
End Sub

Sub LookRight()
    If Not HasBeenInitialized = TRUE Then
        Init
    End If
    P.yaw = P.yaw + G.rotateBy
    If P.yaw >= 360 Then
        P.yaw = P.yaw - 360
    End If
    Move
End Sub

' [Free Keys] Unbinds all keys
Sub FreeKeys()
    Application.OnKey "+W"
    Application.OnKey "+S"
    Application.OnKey "+{ }"
    Application.OnKey "+X"
    Application.OnKey "+A"
    Application.OnKey "+D"
    Application.OnKey "+R"
    Application.OnKey "+F"
    Application.OnKey "+Q"
    Application.OnKey "+E"
End Sub