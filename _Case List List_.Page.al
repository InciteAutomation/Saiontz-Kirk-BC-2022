page 50161 "Case List List"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = CaseList;
    Editable = false;
    InsertAllowed = true;
    DeleteAllowed = true;
    RefreshOnActivate = true;
    CardPageId = "Case List Card";

    layout
    {
        area(content)
        {
            repeater(Cases)
            {
                field("Project ID";"Project ID")
                {
                    ApplicationArea = All;
                }
                field("Project Name";"Project Name")
                {
                    ApplicationArea = All;
                }
                field("Case Type";"Case Type")
                {
                    ApplicationArea = All;
                }
                field("Incident Date";"Incident Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
