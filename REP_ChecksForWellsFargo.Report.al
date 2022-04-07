report 50170 REP_ChecksForWellsFargo
{
    CaptionML = ENU='Wells Fargo Check Report';
    RDLCLayout = 'ReportLayouts/WellsFargoChecReport.rdl';
    WordLayout = 'ReportLayouts/WellsFargoChecReport.docx';
    PreviewMode = PrintLayout;
    //WordMergeDataItem = ;
    UseRequestPage = true;

    //SetPar(ParDocNo: Code[20])
    dataset
    {
        dataitem("Bank Account Ledger Entry";"Bank Account Ledger Entry")
        {
            RequestFilterFields = "Bank Account No.", "Document Date";

            // DataItemTableView = sorting("Posting Date");
            column(Bank_Account_No_;"Bank Account No.")
            {
            }
            Column(Document_No_;"Document No.")
            {
            }
            column(Amount;Amount)
            {
            }
            column(AmountText;AmountText)
            {
            }
            column(Posting_Date;"Posting Date")
            {
            }
            column(Document_Date;"Document Date")
            {
            }
            trigger OnAfterGetRecord()begin
                PlaceholderString:=Format(Amount);
                PlaceholderString:=DelChr(PlaceholderString, '=', '-.,');
                PlaceholderString:=DelChr(PlaceholderString, '=');
                AmountTextLen:=10 - StrLen(PlaceholderString);
                if(StrLen(PlaceholderString) >= 10)then begin
                    TempAmountText:=CopyStr(PlaceholderString, 1, 10);
                    AmountText:=TempAmountText;
                end
                else
                begin
                    TempAmountText:=PlaceholderString;
                    AmountText:=TempAmountText;
                    repeat TempAmountText:=InsStr(AmountText, '0', 1);
                        AmountText:=TempAmountText;
                    until StrLen(AmountText) = 10 end;
                if("Journal Batch Name" = 'DEFAULT') OR ("Source Code" = 'FINVOIDCHK')then begin
                    CurrReport.Skip();
                end;
            end;
        }
    }
    requestpage
    {
        SaveValues = true;
    }
    var AmountText: Text[10];
    TempAmountText: Text[10];
    AmountTextLen: Integer;
    PlaceholderString: Text;
}
