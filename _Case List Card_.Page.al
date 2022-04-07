page 50180 "Case List Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = CaseList;

    layout
    {
        area(Content)
        {
            group("General")
            {
                field("Project ID";"Project ID")
                {
                    Caption = 'Filevine Project ID';
                    ApplicationArea = Basic;
                }
                field("Case Type";"Case Type")
                {
                    ApplicationArea = Basic;
                }
                field("Project Name";"Project Name")
                {
                    ApplicationArea = Basic;
                }
                field("Incident Date";"Incident Date")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
}
