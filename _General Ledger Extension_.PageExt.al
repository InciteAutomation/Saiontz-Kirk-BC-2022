pageextension 50172 "General Ledger Extension" extends "General Ledger Entries"
{
    layout
    {
        modify("External Document No.")
        {
        Visible = false;
        }
        modify("Gen. Posting Type")
        {
        Visible = false;
        }
        modify("Gen. Bus. Posting Group")
        {
        Visible = false;
        }
        modify("Gen. Prod. Posting Group")
        {
        Visible = false;
        }
        addafter(Amount)
        {
            field("Debit Amount42277";"Debit Amount")
            {
                ApplicationArea = All;
            }
            field("Credit Amount40534";"Credit Amount")
            {
                ApplicationArea = All;
            }
        }
        modify(Amount)
        {
        Visible = false;
        }
        addafter("G/L Account No.")
        {
            field("G/L Account Name20999";"G/L Account Name")
            {
                ApplicationArea = All;
            }
        }
        modify(Description)
        {
        Visible = false;
        }
        addafter("Document No.")
        {
            field("Case Number";"Case Number")
            {
                ApplicationArea = All;
            // trigger OnValidate()
            // var
            //     EscrowAccount: Record EscrowAccounts;
            // begin
            //     EscrowAccount.Get(rec."Case Number");
            //     "Case Number" := EscrowAccount."Case Number"
            // end;
            }
        }
    }
}
