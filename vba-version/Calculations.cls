VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Calculations"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Private cos_(0 To 359) As Double
Private sin_(0 To 359) As Double

' Property to get the cos array
Public Property Get cos(Index As Integer) As Double
    cos = cos_(Index)
End Property

' Property to set the cos array
Public Property Let cos(Index As Integer, value As Double)
    cos_(Index) = value
End Property

' Property to get the sin array
Public Property Get sin(Index As Integer) As Double
    sin = sin_(Index)
End Property

' Property to set the sin array
Public Property Let sin(Index As Integer, value As Double)
    sin_(Index) = value
End Property

