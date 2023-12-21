VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Game"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private screenWidth_ As Long
Private screenHeight_ As Long
Private blockSize_ As Long
Private blockSizeHalf_ As Double
Private moveBy_ As Long
Private rotateBy_ As Long
Private instantDrawing_ As Boolean
Private valuesSet_ As Boolean

Public Property Get screenWidth() As Long
    screenWidth = screenWidth_
End Property

Public Property Let screenWidth(value As Long)
    screenWidth_ = value
End Property

Public Property Get screenHeight() As Long
    screenHeight = screenHeight_
End Property

Public Property Let screenHeight(value As Long)
    screenHeight_ = value
End Property

Public Property Get blockSize() As Long
    blockSize = blockSize_
End Property

Public Property Let blockSize(value As Long)
    blockSize_ = value
End Property

Public Property Get blockSizeHalf() As Double
    blockSizeHalf = blockSizeHalf_
End Property

Public Property Let blockSizeHalf(value As Double)
    blockSizeHalf_ = value
End Property

Public Property Get moveBy() As Long
    moveBy = moveBy_
End Property

Public Property Let moveBy(value As Long)
    moveBy_ = value
End Property

Public Property Get rotateBy() As Long
    rotateBy = rotateBy_
End Property

Public Property Let rotateBy(value As Long)
    rotateBy_ = value
End Property

Public Property Get instantDrawing() As Boolean
    instantDrawing = instantDrawing_
End Property

Public Property Let instantDrawing(value As Boolean)
    instantDrawing_ = value
End Property

Public Property Get valuesSet() As Boolean
    valuesSet = valuesSet_
End Property

Public Property Let valuesSet(value As Boolean)
    valuesSet_ = value
End Property