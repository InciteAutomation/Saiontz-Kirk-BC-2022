tableextension 50149 "Bank Account ReconLine Ext" extends "Bank Acc. Reconciliation Line"
{
    fields
    {
        modify("Transaction Date")
        {
        trigger OnAfterValidate()begin
        // Rec."Transaction Date" := Today;
        end;
        }
    }
// trigger OnBeforeInsert()
// begin
//     Message('This is working date ' + Format(WorkDate()));
//     Rec."Transaction Date" := Today;
// end;
// trigger OnAfterInsert()
// begin
//     Message('This is working date ' + Format(WorkDate()));
//     Rec."Transaction Date" := Today;
// end;
}
