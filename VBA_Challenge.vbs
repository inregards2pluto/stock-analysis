Sub AllStocksAnalysisRefactored()
    Dim startTime As Single
    Dim endTime  As Single

    'Prompt users for the desired year of stock data analysis
    yearValue = InputBox("What year would you like to run the analysis on?")

    'Initate a timer to assess total duration and efficiency of subroutine
    startTime = Timer
    
    'Format the output sheet on All Stocks Analysis worksheet
    Worksheets("All Stocks Analysis").Activate
    
    Range("A1").Value = "All Stocks (" + yearValue + ")"
    
    'Create a header row
    Cells(3, 1).Value = "Ticker"
    Cells(3, 2).Value = "Total Daily Volume"
    Cells(3, 3).Value = "Return"

    'Initialize array of all tickers
    Dim tickers(12) As String
    
    tickers(0) = "AY"
    tickers(1) = "CSIQ"
    tickers(2) = "DQ"
    tickers(3) = "ENPH"
    tickers(4) = "FSLR"
    tickers(5) = "HASI"
    tickers(6) = "JKS"
    tickers(7) = "RUN"
    tickers(8) = "SEDG"
    tickers(9) = "SPWR"
    tickers(10) = "TERP"
    tickers(11) = "VSLR"
    
    'Activate data worksheet
    Worksheets(yearValue).Activate
    
    'Get the number of rows to loop over
    RowCount = Cells(Rows.Count, "A").End(xlUp).Row
    
    'Create a ticker Index
    tickerIndex = 0

    'Create three output arrays
    Dim tickerVolumes(12) As Double
    Dim tickerStartingPrices(12) As Single
    Dim tickerEndingPrices(12) As Single
    
    'Create a for loop to initialize the tickerVolumes to zero.
    For i = 0 To 12
        tickerVolumes(i) = 0
        
    Next i
           
    'Loop over all the rows in the spreadsheet.
    For i = 2 To RowCount
    
        'Increase volume for current ticker
        If Cells(i, 1).Value = tickers(tickerIndex) Then

            tickerVolumes(tickerIndex) = tickerVolumes(tickerIndex) + Cells(i, 8).Value
        
            'Check if the current row is the first row with the selected tickerIndex.
            'If it is, then assign the current price to the tickerStartingPrices variable.
            If Cells(i - 1, 1).Value <> tickers(tickerIndex) And Cells(i, 1).Value = tickers(tickerIndex) Then
    
               tickerStartingPrices(tickerIndex) = Cells(i, 6).Value
    
            End If
        
            'Check if the current row is the last row with the selected ticker.
            'If it is, then assign the current price to the tickerEndingPrices variable.
            If Cells(i + 1, 1).Value <> tickers(tickerIndex) And Cells(i, 1).Value = tickers(tickerIndex) Then
    
               tickerEndingPrices(tickerIndex) = Cells(i, 6).Value
               tickerIndex = tickerIndex + 1
    
            End If
        
        End If
        
    Next i
    
    'Loop through your arrays to output the Ticker, Total Daily Volume, and Return.
    For i = 0 To 11
        
       Worksheets("All Stocks Analysis").Activate
        
       Cells(4 + i, 1).Value = tickers(i)
       Cells(4 + i, 2).Value = tickerVolumes(i)
       Cells(4 + i, 3).Value = tickerEndingPrices(i) / tickerStartingPrices(i) - 1
        
    Next i
    
    'Formatting
    Worksheets("All Stocks Analysis").Activate
    Range("A3:C3").Font.FontStyle = "Bold"
    Range("A3:C3").Borders(xlEdgeBottom).LineStyle = xlContinuous
    Range("B4:B15").NumberFormat = "#,##0"
    Range("C4:C15").NumberFormat = "0.0%"
    Columns("B").AutoFit

    dataRowStart = 4
    dataRowEnd = 15

    For i = dataRowStart To dataRowEnd
        
        If Cells(i, 3) > 0 Then
            
            Cells(i, 3).Interior.Color = vbGreen
            
        Else
        
            Cells(i, 3).Interior.Color = vbRed
            
        End If
        
    Next i
 
    endTime = Timer
    MsgBox "This code ran in " & (endTime - startTime) & " seconds for the year " & (yearValue)

End Sub

Sub ClearWorksheet()
    
    'Clear worksheet of previous analysis
    Worksheets("All Stocks Analysis").Range("A4:C15").Clear
    
End Sub