pageextension 50111 ConfirmFinancialVoidExt extends "Confirm Financial Void"
{
    layout
    {
        modify(VoidDate)
        {
        Visible = true;
        // trigger OnLookup(var VoidDate: Date)
        // begin
        //     Message(Format(VoidDate));
        //     VoidDate := Today();
        // end;
        }
    }
    // trigger OnClosePage()
    // begin
    //     with CheckLedgerEntry do begin
    //         VoidDate := Today();
    //         Message(Format(VoidDate));
    //     end;
    // end;
    var CheckLedgerEntry: Record "Check Ledger Entry";
}
