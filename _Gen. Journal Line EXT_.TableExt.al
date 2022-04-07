tableextension 50134 "Gen. Journal Line EXT" extends "Gen. Journal Line"
{
    fields
    {
        field(50100;"Case Number";Code[30])
        {
            //TableRelation = EscrowAccounts."Case Number";
            TableRelation = EscrowAccounts;
        }
        field(50101;"Client Name";Text[250])
        {
            TableRelation = EscrowAccounts."Client Name";
            ValidateTableRelation = false;
        }
        field(50102;"Deposit Detail";Text[500])
        {
        }
        field(50103;"Balance Description";Text[500])
        {
        }
        field(50104;"G/L Account No.";Code[30])
        {
            TableRelation = "G/L Entry"."G/L Account No.";
        }
        field(50105;"G/L Account Name";Code[30])
        {
            TableRelation = "G/L Entry"."G/L Account Name";
        }
        field(50106;"FileVine Project ID";Code[30])
        {
            TableRelation = CaseList;
        }
    }
}
