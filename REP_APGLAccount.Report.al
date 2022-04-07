report 50118 REP_APGLAccount
{
    CaptionML = ENU='APGLAccount';
    RDLCLayout = 'ReportLayouts/APGLAccount.rdl';
    WordLayout = 'ReportLayouts/APGLAccount.docx';
    PreviewMode = PrintLayout;
    UseRequestPage = true;

    dataset
    {
        dataitem("G/L Entry";"G/L Entry")
        {
            column(Bal__Account_No_;"Bal. Account No.")
            {
            }
            //What would "Account Group be"?
            column(Description;Description)
            {
            }
        //What would status be?
        //what is structure code
        //what is control account
        //what is allocations allowed?
        }
    }
}
