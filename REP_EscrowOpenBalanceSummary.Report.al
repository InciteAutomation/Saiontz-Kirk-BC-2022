report 50162 REP_EscrowOpenBalanceSummary
{
    CaptionML = ENU='Escrow Open Balance Summary';
    RDLCLayout = 'ReportLayouts/EscrowOpenBalanceSummary.rdl';
    WordLayout = 'ReportLayouts/EscrowOpenBalanceSummary.docx';
    PreviewMode = PrintLayout;
    UseRequestPage = false;

    dataset
    {
        dataitem("Case Summary";EscrowAccounts)
        {
            // DataItemTableView = SORTING("Case Number");
            // PrintOnlyIfDetail = true;
            // RequestFilterFields = "Case Number";
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
            trigger OnAfterGetRecord()begin
                if System.Abs("Total Checks ($)") = System.Abs("Total Deposits ($)")then CurrReport.Skip();
            end;
        }
    }
}
