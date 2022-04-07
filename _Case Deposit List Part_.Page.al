page 50132 "Case Deposit List Part"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Posted Deposit Line";
    Caption = 'Posted Deposits';
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
                field(Name;"Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Check No.";"Document No.")
                {
                    ApplicationArea = All;
                }
                // field("Dimension1"; "Shortcut Dimension 1 Code") { ApplicationArea = All; Caption = 'Deposit Type Code'; }
                field("Deposit Detail";"Deposit Detail")
                {
                    ApplicationArea = All;
                    Caption = 'Memo';
                }
                field("Amount (LCY) ";Amount)
                {
                    ApplicationArea = All;
                }
                field("Account No.";"Account No.")
                {
                    ApplicationArea = All;
                    Caption = 'Balance #';
                }
                field("Account Type";"Account Type")
                {
                    ApplicationArea = All;
                    Caption = 'Balance Description';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;
            }
        }
    }
}
