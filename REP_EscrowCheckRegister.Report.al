report 50161 REP_EscrowCheckRegister
{
    //CaptionML = ENU = 'Escrow Check Register';
    CaptionML = ENU='Check Disbursements';
    RDLCLayout = 'ReportLayouts/EscrowCheckRegister.rdl';
    WordLayout = 'ReportLayouts/EscrowCheckRegister.docx';
    PreviewMode = PrintLayout;
    //WordMergeDataItem = ;
    UseRequestPage = true;

    //SetPar(ParDocNo: Code[20])
    dataset
    {
        dataitem("Check Ledger Entry";"Check Ledger Entry")
        {
            RequestFilterFields = "Check Date", "Entry Status";

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
            column(CLE_Description;Description)
            {
            }
        }
    }
}
