tableextension 50145 "Detailed Vendor Led Ent EXT" extends "Detailed Vendor Ledg. Entry"
{
    fields
    {
        field(50100;"Case Number";Code[30])
        {
            TableRelation = EscrowAccounts."Case Number";
        }
        field(50101;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(50102;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
    }
}
