Attribute VB_Name = "Keys"
Option Explicit

' [Bind Keys] Shift + W/A/S/D/Q/E/R/F/X/{ } to move around
' + is shift; { } is ctrl
Sub bindKeys()
    Application.OnKey "+W", "moveFront" ' z+ (if yaw is 0) generally x,z
    Application.OnKey "+S", "moveBack" 'z- (if yaw is 0) generally x,z

    Application.OnKey "+{ }", "moveUp" 'y+
    Application.OnKey "+X", "moveDown" 'y-
    
    Application.OnKey "+A", "moveLeft" ' x- (if yaw is 0) generally x,z
    Application.OnKey "+D", "moveRight" ' x+ (if yaw is 0) generally x,z
    
    Application.OnKey "+R", "lookUp" ' x+ pitch
    Application.OnKey "+F", "lookDown" ' x- pitch
    
    Application.OnKey "+Q", "lookLeft" ' y- yaw 
    Application.OnKey "+E", "lookRight" 'y+ yaw
End Sub

Sub moveUp()
    P.y = P.y + G.moveBy
    Move
End Sub

Sub moveDown()
    P.y = P.y - G.moveBy
    Move
End Sub

Sub lookUp()
    P.pitch = P.pitch + G.rotateBy
    If P.pitch > 90 Then
        P.pitch = 90
    End If
    Move
End Sub

Sub lookDown()
    P.pitch = P.pitch - G.rotateBy
    If P.pitch < -90 Then
        P.pitch = -90
    End If
    Move
End Sub

Sub moveRight()
    Dim dx As Long
    Dim dz As Long
    dx = CInt(C.sin(P.yaw) * G.moveBy)
    dz = CInt(C.cos(P.yaw) * G.moveBy)
    
    P.x = P.x + dz
    P.z = P.z - dx
    Move
End Sub

Sub moveLeft()
    Dim dx As Long
    Dim dz As Long
    dx = CInt(C.sin(P.yaw) * G.moveBy)
    dz = CInt(C.cos(P.yaw) * G.moveBy)
    
    P.x = P.x - dz
    P.z = P.z + dx
    Move
End Sub

Sub moveFront()
    Dim dx As Long
    Dim dz As Long
    dx = CInt(C.sin(P.yaw) * -G.moveBy)
    dz = CInt(C.cos(P.yaw) * G.moveBy)
    
    P.x = P.x - dx
    P.z = P.z + dz
    Move
End Sub

Sub moveBack()
    Dim dx As Long
    Dim dz As Long
    dx = CInt(C.sin(P.yaw) * G.moveBy)
    dz = CInt(C.cos(P.yaw) * -G.moveBy)
    
    P.x = P.x - dx
    P.z = P.z + dz
    Move
End Sub

Sub lookLeft()
    P.yaw = P.yaw - G.rotateBy
    If P.yaw < 0 Then
        P.yaw = P.yaw + 360
    End If
    Move
End Sub

Sub lookRight()
    P.yaw = P.yaw + G.rotateBy
    If P.yaw >= 360 Then
        P.yaw = P.yaw - 360
    End If
    Move
End Sub

' [Free Keys] Unbinds all keys
Sub freeKeys()
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