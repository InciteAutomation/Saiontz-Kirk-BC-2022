tableextension 50144 "GL Entry EXT" extends "G/L Entry"
{
    fields
    {
        field(50100;"Case Number";Code[30])
        {
            TableRelation = EscrowAccounts; // ."Case Number";
        }
        field(50101;"Client Name";Text[2048])
        {
        }
        field(50102;"Deposit Detail";Text[2048])
        {
        }
        field(50106;"FileVine Project ID";Code[30])
        {
            TableRelation = CaseList;
        }
    }
}
