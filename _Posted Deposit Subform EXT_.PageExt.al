pageextension 50138 "Posted Deposit Subform EXT" extends "Posted Deposit Subform"
{
    layout
    {
        addafter("Account No.")
        {
            field("Case Number";"Case Number")
            {
                ApplicationArea = EscrowApplication;
                lookup = true;
            }
        }
        addafter(Description)
        {
            field("Deposit Detail";"Deposit Detail")
            {
                ApplicationArea = AccountsPayable;
                Lookup = true;
            }
        }
    }
}
