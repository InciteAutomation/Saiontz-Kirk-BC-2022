tableextension 50123 "Purchase Line Extension" extends "Purchase Line"
{
    fields
    {
        field(50100;"Case Number";Code[30])
        {
            TableRelation = EscrowAccounts."Case Number";
        }
        field(50101;"Project ID";code[30])
        {
            TableRelation = CaseList."Project ID";
        }
    }
}
