report 50160 REP_EscrowDepositSummary
{
    CaptionML = ENU='Escrow Deposit Summary';
    RDLCLayout = 'ReportLayouts/EscrowDepositSummary.rdl';
    WordLayout = 'ReportLayouts/EscrowDepositSummary.docx';
    PreviewMode = PrintLayout;
    //WordMergeDataItem = ;
    UseRequestPage = true;

    //SetPar(ParDocNo: Code[20])
    dataset
    {
        dataitem("Posted Deposit Line";"Posted Deposit Line")
        {
            RequestFilterFields = "Posting Date";

            column(PDL_Posting_Date;"Posting Date")
            {
            }
            column(PDL_Deposit_Type_Code;"Shortcut Dimension 1 Code")
            {
            }
            column(PDL_Memo;"Deposit Detail")
            {
            }
            column(PDL_Case_Number;"Case Number")
            {
            }
            column(Client_Name;"Client Name")
            {
            }
            column(PDL_Description;Description)
            {
            }
            column(PDL_Deposit_Detail;"Deposit Detail")
            {
            }
            column(PDL_Amount;Amount)
            {
            }
            trigger OnAfterGetRecord()begin
                if(Amount < 0)then begin
                    CurrReport.Skip();
                end;
            end;
        // trigger OnAfterGetRecord()
        // begin
        //     Message(Format("Case Number"));
        //     if ("Case Number" <> escrowCaseNo) then
        //         Message('Skipped');
        //     CurrReport.Skip();
        // end;
        }
    // dataitem("Escrow Information"; EscrowAccounts)
    //             {
    //                 column(Client_Name; "Client Name")
    //                 { }
    //                 trigger OnPostDataItem()
    //                 var
    //                     escrow: Record EscrowAccounts;
    //                     PDL: Record "Posted Deposit Line";
    //                 begin
    //                     escrow.SetFilter("Client Name", "Client Name");
    //                     escrow.SetFilter("Case Number", "Case Number");
    //                     escrow.FindLast();
    //                     escrowCaseNo := escrow."Case Number";
    //                     Message(escrowCaseNo);
    //                 end;
    //             }
    }
    var escrowCaseNo: Code[2048];
    PDLCaseNo: Code[2048];
}
