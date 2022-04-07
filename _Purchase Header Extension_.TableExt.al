tableextension 50122 "Purchase Header Extension" extends "Purchase Header"
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
