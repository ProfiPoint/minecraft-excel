Attribute VB_Name = "Keys"
Sub bindKeys()
    Application.OnKey "+Q", "lookLeft" 'w
    Application.OnKey "+E", "lookRight" 'w
    
    Application.OnKey "+W", "moveFront" 'w
    Application.OnKey "+S", "moveBack" 's
    
    Application.OnKey "+A", "moveLeft" '. strafe left
    Application.OnKey "+D", "moveRight" ', strafe right
    
    Application.OnKey "+{ }", "moveUp" 'am look up
    Application.OnKey "+X", "moveDown" 'dm look down
    
    Application.OnKey "+R", "lookUp" 'w
    Application.OnKey "+F", "lookDown" 's
End Sub

Sub moveUp()
    P.y = P.y + moveBy
    Move
End Sub

Sub moveDown()
    P.y = P.y - moveBy
    Move
End Sub
    
Sub lookUp()
    P.h = P.h + rotateBy
    If P.h > 90 Then
        P.h = 90
    End If
    Move
End Sub

Sub lookDown()
    P.h = P.h - rotateBy
    If P.h < -90 Then
        P.h = -90
    End If
    Move
End Sub

Sub moveRight()
    Dim dx As Long
    Dim dz As Long
    dx = CInt(c.sin(P.r) * moveBy)
    dz = CInt(c.cos(P.r) * moveBy)
    
    P.x = P.x + dz
    P.z = P.z - dx
    Move
End Sub

Sub moveLeft()
    Dim dx As Long
    Dim dz As Long
    dx = CInt(c.sin(P.r) * moveBy)
    dz = CInt(c.cos(P.r) * moveBy)
    
    P.x = P.x - dz
    P.z = P.z + dx
    Move
End Sub

Sub moveFront()
    Dim dx As Long
    Dim dz As Long
    dx = CInt(c.sin(P.r) * -moveBy)
    dz = CInt(c.cos(P.r) * moveBy)
    
    P.x = P.x - dx
    P.z = P.z + dz
    Move
End Sub

Sub moveBack()
    Dim dx As Long
    Dim dz As Long
    dx = CInt(c.sin(P.r) * moveBy)
    dz = CInt(c.cos(P.r) * -moveBy)
    
    P.x = P.x - dx
    P.z = P.z + dz
    Move
End Sub

Sub lookLeft()
    P.r = P.r - rotateBy
    If P.r < 0 Then
        P.r = P.r + 360
    End If
    Move
End Sub

Sub lookRight()
    P.r = P.r + rotateBy
    If P.r >= 360 Then
        P.r = P.r - 360
    End If
    Move
End Sub

Sub freeKeys()
    Application.OnKey "+W"
    Application.OnKey "+A"
    Application.OnKey "+S"
    Application.OnKey "+D"
    Application.OnKey "+{ }"
    Application.OnKey "+X"
    Application.OnKey "+Q"
    Application.OnKey "+E"
    Application.OnKey "+R"
    Application.OnKey "+F"
End Sub

