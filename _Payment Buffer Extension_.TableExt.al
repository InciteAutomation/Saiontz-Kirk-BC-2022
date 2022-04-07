tableextension 50171 "Payment Buffer Extension" extends "Payment Buffer"
{
    fields
    {
        field(50100;"Case Number";Code[30])
        {
            TableRelation = EscrowAccounts; // ."Case Number";
        }
        field(50101;"FileVine Project ID";Code[30])
        {
            TableRelation = CaseList;
        }
    }
}
