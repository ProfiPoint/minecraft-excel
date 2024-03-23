Attribute VB_Name = "Keys"
Option Explicit

' [Bind Keys] Shift + W/A/S/D/Q/E/R/F/X/{ } to move around
' + is shift; { } is ctrl
Sub BindKeys()
    Application.OnKey "+W", "MoveFront" ' z+ (if yaw is 0) generally x,z
    Application.OnKey "+S", "MoveBack" 'z- (if yaw is 0) generally x,z

    Application.OnKey "+{ }", "MoveTop" 'y+
    Application.OnKey "+X", "MoveBottom" 'y-
    
    Application.OnKey "+A", "MoveLeft" ' x- (if yaw is 0) generally x,z
    Application.OnKey "+D", "MoveRight" ' x+ (if yaw is 0) generally x,z
    
    Application.OnKey "+R", "LookTop" ' x+ pitch
    Application.OnKey "+F", "LookBottom" ' x- pitch
    
    Application.OnKey "+Q", "LookLeft" ' y- yaw
    Application.OnKey "+E", "LookRight" 'y+ yaw
End Sub

Sub MoveTop()
    If Not HasBeenInitialized = True Then
        Init
    End If

    P.y = P.y + G.moveBy

    Move
End Sub

Sub MoveBottom()
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
    
    P.x = P.x + CInt(c.cos(P.yaw) * G.moveBy)
    P.z = P.z - CInt(c.sin(P.yaw) * G.moveBy)

    Move
End Sub

Sub MoveLeft()
    If Not HasBeenInitialized = True Then
        Init
    End If

    P.x = P.x - CInt(c.cos(P.yaw) * G.moveBy)
    P.z = P.z + CInt(c.sin(P.yaw) * G.moveBy)

    Move
End Sub

Sub MoveFront()
    If Not HasBeenInitialized = True Then
        Init
    End If

    P.x = P.x + CInt(c.sin(P.yaw) * G.moveBy)
    P.z = P.z + CInt(c.cos(P.yaw) * G.moveBy)

    Move
End Sub

Sub MoveBack()
    If Not HasBeenInitialized = True Then
        Init
    End If

    P.x = P.x - CInt(c.sin(P.yaw) * G.moveBy)
    P.z = P.z - CInt(c.cos(P.yaw) * G.moveBy)

    Move
End Sub

Sub LookTop()
    If Not HasBeenInitialized = True Then
        Init
    End If

    P.pitch = P.pitch + G.rotateBy

    If P.pitch > 90 Then
        P.pitch = 90
    End If

    Move
End Sub

Sub LookBottom()
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
    If Not HasBeenInitialized = True Then
        Init
    End If

    P.yaw = P.yaw - G.rotateBy

    If P.yaw < 0 Then
        P.yaw = P.yaw + 360
    End If

    Move
End Sub

Sub LookRight()
    If Not HasBeenInitialized = True Then
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
