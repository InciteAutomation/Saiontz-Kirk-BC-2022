tableextension 50137 "Posted Deposit Line EXT" extends "Posted Deposit Line"
{
    fields
    {
        field(50100;"Case Number";Code[30])
        {
            TableRelation = EscrowAccounts."Case Number";
        //TODO: FIX ME
        //Taken from the example.  We will probably need validation but not sure on best way to do that. 
        //ValidateTableRelation = false;
        // trigger OnValidate();
        // begin
        //     if (Rec."Case Number" <> xRec."Case Number") then begin
        //         xRec."Case Number" := FORMAT(000);
        //         Rec."Case Number" := Format(000);
        //     end;
        // end;
        }
        field(50101;"Deposit Detail";Text[500])
        {
            TableRelation = "Gen. Journal Line"."Deposit Detail";
        }
        field(50102;"Client Name";Text[2048])
        {
            TableRelation = EscrowAccounts."Client Name";
        // ValidateTableRelation = false;
        }
    }
}
