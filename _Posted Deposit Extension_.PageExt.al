pageextension 50173 "Posted Deposit Extension" extends "Posted Deposit Lines"
{
    layout
    {
        addfirst(Control1)
        {
            field("Posting Date";"Posting Date")
            {
                ApplicationArea = All;
            }
        }
        moveafter("Posting Date";"Document No.")
        moveafter("Document No.";Description)
        moveafter(Description;Amount)
        //
        modify("Deposit No.")
        {
        Visible = false;
        }
        addafter(Description)
        {
            field("Deposit Detail";"Deposit Detail")
            {
                ApplicationArea = All;
                Caption = 'Memo';
            }
        }
        modify("Account Type")
        {
        Visible = false;
        ApplicationArea = All;
        }
        addafter("Document No.")
        {
            field("Account Type15297";"Account Type")
            {
                ApplicationArea = All;
            }
        }
        modify("Document Date")
        {
        Visible = false;
        ApplicationArea = All;
        }
        modify("Document Type")
        {
        Visible = false;
        ApplicationArea = All;
        }
        modify("Shortcut Dimension 2 Code")
        {
        Visible = false;
        ApplicationArea = All;
        }
        modify("Shortcut Dimension 1 Code")
        {
        Visible = false;
        ApplicationArea = All;
        }
    }
}
