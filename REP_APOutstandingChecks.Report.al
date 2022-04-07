report 50113 REP_APOutstandingChecks
{
    CaptionML = ENU='AP DisbursementJournal';
    RDLCLayout = 'ReportLayouts/APOutstandingChecks.rdl';
    WordLayout = 'ReportLayouts/APOutstandingChecks.docx';
    PreviewMode = PrintLayout;
    UseRequestPage = true;

    //TODO what table is this?
    //Filters on transaction date
    /*application (what is this)
    reconciliation status
  
    */
    dataset
    {
        dataitem("Bank Acc. Reconciliation";"Bank Acc. Reconciliation")
        {
            column(Bank_Account_No_;"Bank Account No.")
            {
            }
            //TODO get Srce. Appl.
            //column(Srce; "")
            column(Statement_No_;"Statement No.")
            {
            }
            //TODO get reconcilation status
            //column("Reconciliation Status")
            column(Statement_Date;"Statement Date")
            {
            }
            column(Total_Transaction_Amount;"Total Transaction Amount")
            {
            }
            column(Total_Applied_Amount;"Total Applied Amount")
            {
            }
            column(Total_Outstd_Payments;"Total Outstd Payments")
            {
            }
        //TODO What is cleared amount, what is write-off amount
        }
    }
}
