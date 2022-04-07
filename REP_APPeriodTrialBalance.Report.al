report 50114 REP_APPeriodTrialBalance
{
    CaptionML = ENU='APPeriodTrialBalance';
    RDLCLayout = 'ReportLayouts/APPeriodTrialBalance.rdl';
    WordLayout = 'ReportLayouts/APPeriodTrialBalance.docx';
    PreviewMode = PrintLayout;
    UseRequestPage = true;

    /*
    Sort by (account no)
    Filters on
     accounts with no activity
     net income loss(total) for listed accounts
     from year (date)
     account no's
     account groups
     "use rolled up amounts"

        What table?
     */
    dataset
    {
        dataitem("G/L Entry";"G/L Entry")
        {
        }
    }
}
