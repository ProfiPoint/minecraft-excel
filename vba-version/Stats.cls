VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Stats"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit

Private Blocks_ As Long
Private VisiblePixels_ As Long
Private VisibleSides_ As Long
Private Cells_ As Long
Private RowsDrawn_ As Long

' [get; set properties for variables]
Public Property Get blocks() As Long
    blocks = Blocks_
End Property

Public Property Let blocks(value As Long)
    Blocks_ = value
End Property

Public Property Get VisiblePixels() As Long
    VisiblePixels = VisiblePixels_
End Property

Public Property Let VisiblePixels(value As Long)
    VisiblePixels_ = value
End Property

Public Property Get VisibleSides() As Long
    VisibleSides = VisibleSides_
End Property

Public Property Let VisibleSides(value As Long)
    VisibleSides_ = value
End Property

Public Property Get Cells() As Long
    Cells = Cells_
End Property

Public Property Let Cells(value As Long)
    Cells_ = value
End Property

Public Property Get RowsDrawn() As Long
    RowsDrawn = RowsDrawn_
End Property

Public Property Let RowsDrawn(value As Long)
    RowsDrawn_ = value
End Property
