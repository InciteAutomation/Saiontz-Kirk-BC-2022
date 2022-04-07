page 50147 "Pending List Part"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Gen. Journal Line";
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Document Date";"Document DAte")
                {
                    ApplicationArea = All;
                }
                field("Description";Description)
                {
                    ApplicationArea = All;
                }
                field("Memo";"Deposit Detail")
                {
                    ApplicationArea = All;
                }
                field("Amount";ABS(Amount))
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
