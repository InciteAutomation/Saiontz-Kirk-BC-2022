report 50126 REP_EscrowSummary
{
    CaptionML = ENU='Escrow Summary';
    RDLCLayout = 'ReportLayouts/AllCaseBalanceSummary.rdl';
    WordLayout = 'ReportLayouts/AllCaseBalanceSummary.docx';
    PreviewMode = PrintLayout;
    UseRequestPage = true;

    dataset
    {
        dataitem("ALL Case Summary";EscrowAccounts)
        {
            //DataItemTableView = SORTING("Case Number");
            //PrintOnlyIfDetail = false;
            //RequestFilterFields = "Case Number";
            column(CB_Case_Number;"Case Number")
            {
            }
            column(CB_Client_Name;"Client Name")
            {
            }
            column(CB_Total_Deposits;"Total Deposits ($)")
            {
            }
            column(CB_Total_Checks;"Total Checks ($)")
            {
            }
        //trigger OnAfterGetRecord()
        //begin
        //    if System.Abs("Total Checks ($)") = System.Abs("Total Deposits ($)")
        ///   then 


        //       CurrReport.Skip();
        //end;
        }
    }
}
