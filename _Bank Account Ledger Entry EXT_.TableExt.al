tableextension 50142 "Bank Account Ledger Entry EXT" extends "Bank Account Ledger Entry"
{
    fields
    {
        field(50100;"Case Number";Code[30])
        {
            TableRelation = EscrowAccounts."Case Number";
        //TODO: FIX ME
        //Taken from the example.  We will probably need validation but not sure on best way to do that. 
        // ValidateTableRelation = true;
        // trigger OnValidate();
        // begin
        //     if (Rec."Case Number" <> xRec."Case Number") then begin
        //         Error('Cannot update the rewards status of a blocked customer.');
        //     end;
        // end;
        }
    }
}
