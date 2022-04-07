report 50163 REP_EscrowVoidCheckRegister
{
    CaptionML = ENU='Escrow Void Check Register';
    RDLCLayout = 'ReportLayouts/EscrowVoidCheckRegister.rdl';
    WordLayout = 'ReportLayouts/EscrowVoidCheckRegister.docx';
    PreviewMode = PrintLayout;
    //WordMergeDataItem = ;
    UseRequestPage = true;

    //SetPar(ParDocNo: Code[20])
    dataset
    {
        dataitem("Check Ledger Entry";"Check Ledger Entry")
        {
            RequestFilterFields = "Check Date";

            column(CLE_Document_Date;"Check Date")
            {
            }
            column(CLE_Check_No;"Check No.")
            {
            }
            column(CLE_Check_Type_Code;"Global Dimension 2 Code")
            {
            }
            column(CLE_Memo;Memo)
            {
            }
            column(CLE_Entry_Status;"Entry Status")
            {
            }
            column(CLE_Void_Date;"Void Date")
            {
            }
            column(Posting_Date;"Posting Date")
            {
            }
            column(Amount;Amount)
            {
            }
            column(CLE_CaseNumber;"Case Number")
            {
            }
            trigger OnAfterGetRecord()begin
                if("Entry Status" <> "Entry Status"::"Financially Voided") AND ("Entry Status" <> "Entry Status"::Voided)then CurrReport.Skip();
            end;
        }
    }
}
