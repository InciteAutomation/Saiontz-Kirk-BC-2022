report 50116 REP_APTrialBalance
{
    CaptionML = ENU='APTrialBalance';
    RDLCLayout = 'ReportLayouts/APTrialBalance.rdl';
    WordLayout = 'ReportLayouts/APTrialBalance.docx';
    PreviewMode = PrintLayout;
    UseRequestPage = true;

    /*
    Filter on:
sort by: account no.
filter on
include accounts with no activity (bool)
for year (date)/mo 
from accoun no. (range)
from account group
use rolled up amounts (bool)
     */
    dataset
    {
        dataitem("G/L Entry";"G/L Entry")
        {
            column(Bal__Account_No_;"Bal. Account No.")
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
