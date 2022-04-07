tableextension 50143 "Vendor Ledger Entry EXT" extends "Vendor Ledger Entry"
{
    fields
    {
        field(50100;"Case Number";Code[30])
        {
            TableRelation = EscrowAccounts."Case Number";
        }
        field(50101;"Client Name";Text[2048])
        {
            TableRelation = EscrowAccounts."Client Name";
        }
        field(50102;"Project ID";Code[30])
        {
            TableRelation = CaseList."Project ID";
        }
    }
    trigger OnBeforeInsert()var vname: Text;
    vend: Record Vendor;
    begin
        Vend.Get(Rec."Vendor No.");
        vname:=vend.Name;
        rec."Vendor Name":=vname;
    end;
}
