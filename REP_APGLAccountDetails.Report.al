report 50115 REP_APGLAccountDetails
{
    CaptionML = ENU='APGLAccountDetails';
    RDLCLayout = 'ReportLayouts/APGLAccountDetails.rdl';
    WordLayout = 'ReportLayouts/APGLAccountDetails.docx';
    PreviewMode = PrintLayout;
    UseRequestPage = true;

    /*
    Filter on:
Include Accounts with no activity (bool)
include balances and net changes (bool)
include posting seq. and batch entry (bool)
include trans. optional fields (bool)
from year - period (year/mo)

sort by:
    transactions by date
    account no
    account group
    year closed
    last posting sequence
    use rolled up amounts (bool)
    date
     */
    dataset
    {
        dataitem("G/L Entry";"G/L Entry")
        {
            column(Bal__Account_No_;"Bal. Account No.")
            {
            }
            //What is source?
            column(Document_Date;"Document Date")
            {
            }
            column(Description;Description)
            {
            }
            //What is posting seq.
            //what is batch entry
            column(Debit_Amount;"Debit Amount")
            {
            }
            column(Credit_Amount;"Credit Amount")
            {
            }
        //Add calculated field (net change)--difference between deb/cred
        //Where does balance come from?
        }
    }
}
