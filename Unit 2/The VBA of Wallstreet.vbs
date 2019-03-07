Sub MultipleYearStockData()
For Each ws In Worksheets
Dim WorksheetName As String
WorksheetName = ws.Name
ws.Cells(1, 9).Value = "Ticker"
ws.Cells(1, 10).Value = "Total Volume"
Dim Ticker As String
Dim Volume As Double
Dim Summary As Double
Summary = 1
For i = 2 To 705714
If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
Ticker = ws.Cells(i, 1).Value
Volume = Volume + ws.Cells(i, 7).Value
ws.Range("I" & Summary + 1).Value = Ticker
ws.Range("J" & Summary + 1) = Volume
Summary = Summary + 1
Volume = 0
Else
Volume = Volume + ws.Cells(i, 7).Value
End If
Next i
Next ws
End Sub
