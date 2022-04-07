report 50117 REP_APVendorHistory
{
    CaptionML = ENU='APVendorHistory';
    RDLCLayout = 'ReportLayouts/APVendorHistory.rdl';
    WordLayout = 'ReportLayouts/APVendorHistory.docx';
    PreviewMode = PrintLayout;
    UseRequestPage = true;

    dataset
    {
        dataitem("Check Ledger Entry";"Check Ledger Entry")
        {
            column(Bank_Account_No_;"Bank Account No.")
            {
            }
            column(Check_No_;"Check No.")
            {
            }
            column(Posting_Date;"Posting Date")
            {
            }
            column(Entry_Status;"Entry Status")
            {
            }
            //TODO what is batch no
            column(Entry_No_;"Entry No.")
            {
            }
            //What is remit to?
            //What is payment code
            column(Bank_Payment_Type;"Bank Payment Type")
            {
            }
            column(Document_No_;"Document No.")
            {
            }
        }
    }
}
