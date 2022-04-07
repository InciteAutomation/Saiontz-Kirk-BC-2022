tableextension 50130 "Purch. Inv. Line Extension" extends "Purch. Inv. Line"
{
    fields
    {
        field(50100;"Case Number";Code[30])
        {
            TableRelation = EscrowAccounts."Case Number";
        }
        field(50101;"Project ID";Code[30])
        {
            TableRelation = CaseList."Project ID";
        }
    }
}
