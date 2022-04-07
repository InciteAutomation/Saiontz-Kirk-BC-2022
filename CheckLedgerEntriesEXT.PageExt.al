pageextension 50143 CheckLedgerEntriesEXT extends "Check Ledger Entries"
{
    layout
    {
        addafter("Check No.")
        {
            field("Case Number";"Case Number")
            {
                ApplicationArea = All;
                lookup = true;
            }
            field("FileVine Project ID";"FileVine Project ID")
            {
                ApplicationArea = All;
                Lookup = true;
            }
            field("Void Date";"Void Date")
            {
                ApplicationArea = All;
            }
        }
    }
}
