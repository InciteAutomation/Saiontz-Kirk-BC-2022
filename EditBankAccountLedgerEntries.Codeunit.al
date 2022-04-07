codeunit 50104 EditBankAccountLedgerEntries
{
    Permissions = TableData "Bank Account Ledger Entry"=rimd;
    TableNo = "Bank Account Ledger Entry";

    trigger OnRun()begin
        EditEntry();
    end;
    procedure EditEntry()begin
        //Right table
        Rec.Get('2607');
        Rec."Remaining Amount":=-425.00;
        Rec.Open:=true;
        Rec."Statement Status":=Rec."Statement Status"::Open;
        Rec.Modify();
        Rec.Get('2585');
        Rec."Remaining Amount":=-50.00;
        Rec.Open:=true;
        Rec."Statement Status":=Rec."Statement Status"::Open;
        Rec.Modify();
        Rec.Get('2447');
        Rec."Remaining Amount":=-4000.00;
        Rec.Open:=true;
        Rec."Statement Status":=Rec."Statement Status"::Open;
        Rec.Modify();
        Rec.Get('2417');
        Rec."Remaining Amount":=-15.73;
        Rec.Open:=true;
        Rec."Statement Status":=Rec."Statement Status"::Open;
        Rec.Modify();
        Rec.Get('2379');
        Rec."Remaining Amount":=-2666.00;
        Rec.Open:=true;
        Rec."Statement Status":=Rec."Statement Status"::Open;
        Rec.Modify();
        Rec.Get('2255');
        Rec."Remaining Amount":=-3000.00;
        Rec.Open:=true;
        Rec."Statement Status":=Rec."Statement Status"::Open;
        Rec.Modify();
        Rec.Get('2239');
        Rec."Remaining Amount":=-375.00;
        Rec.Open:=true;
        Rec."Statement Status":=Rec."Statement Status"::Open;
        Rec.Modify();
        Rec.Get('2169');
        Rec."Remaining Amount":=-360.00;
        Rec.Open:=true;
        Rec."Statement Status":=Rec."Statement Status"::Open;
        Rec.Modify();
        Rec.Get('2155');
        Rec."Remaining Amount":=-36.00;
        Rec.Open:=true;
        Rec."Statement Status":=Rec."Statement Status"::Open;
        Rec.Modify();
        Rec.Get('2117');
        Rec."Remaining Amount":=-175.00;
        Rec.Open:=true;
        Rec."Statement Status":=Rec."Statement Status"::Open;
        Rec.Modify();
        Rec.Get('2069');
        Rec."Remaining Amount":=-4000.00;
        Rec.Open:=true;
        Rec."Statement Status":=Rec."Statement Status"::Open;
        Rec.Modify();
        Rec.Get('2021');
        Rec."Remaining Amount":=-181.00;
        Rec.Open:=true;
        Rec."Statement Status":=Rec."Statement Status"::Open;
        Rec.Modify();
        Rec.Get('1525');
        Rec."Remaining Amount":=-1600.00;
        Rec.Open:=true;
        Rec."Statement Status":=Rec."Statement Status"::Open;
        Rec.Modify();
        Rec.Get('1175');
        Rec."Remaining Amount":=-73.00;
        Rec.Open:=true;
        Rec."Statement Status":=Rec."Statement Status"::Open;
        Rec.Modify();
        Rec.Get('1079');
        Rec."Remaining Amount":=-710.00;
        Rec.Open:=true;
        Rec."Statement Status":=Rec."Statement Status"::Open;
        Rec.Modify();
        Rec.Get('693');
        Rec."Remaining Amount":=-1000.00;
        Rec.Open:=true;
        Rec."Statement Status":=Rec."Statement Status"::Open;
        Rec.Modify();
        //Left Table
        Rec.Get('1915');
        Rec."Remaining Amount":=0;
        Rec.Open:=false;
        Rec."Statement Status":=Rec."Statement Status"::Closed;
        Rec.Modify();
        Rec.Get('1841');
        Rec."Remaining Amount":=0;
        Rec.Open:=false;
        Rec."Statement Status":=Rec."Statement Status"::Closed;
        Rec.Modify();
        Rec.Get('1611');
        Rec."Remaining Amount":=0;
        Rec.Open:=false;
        Rec."Statement Status":=Rec."Statement Status"::Closed;
        Rec.Modify();
        Rec.Get('1541');
        Rec."Remaining Amount":=0;
        Rec.Open:=false;
        Rec."Statement Status":=Rec."Statement Status"::Closed;
        Rec.Modify();
        Rec.Get('1521');
        Rec."Remaining Amount":=0;
        Rec.Open:=false;
        Rec."Statement Status":=Rec."Statement Status"::Closed;
        Rec.Modify();
        Rec.Get('1389');
        Rec."Remaining Amount":=0;
        Rec.Open:=false;
        Rec."Statement Status":=Rec."Statement Status"::Closed;
        Rec.Modify();
        Rec.Get('1283');
        Rec."Remaining Amount":=0;
        Rec.Open:=false;
        Rec."Statement Status":=Rec."Statement Status"::Closed;
        Rec.Modify();
        Rec.Get('1147');
        Rec."Remaining Amount":=0;
        Rec.Open:=false;
        Rec."Statement Status":=Rec."Statement Status"::Closed;
        Rec.Modify();
        Rec.Get('1067');
        Rec."Remaining Amount":=0;
        Rec.Open:=false;
        Rec."Statement Status":=Rec."Statement Status"::Closed;
        Rec.Modify();
        Rec.Get('935');
        Rec."Remaining Amount":=0;
        Rec.Open:=false;
        Rec."Statement Status":=Rec."Statement Status"::Closed;
        Rec.Modify();
        Rec.Get('953');
        Rec."Remaining Amount":=0;
        Rec.Open:=false;
        Rec."Statement Status":=Rec."Statement Status"::Closed;
        Rec.Modify();
        Rec.Get('641');
        Rec."Remaining Amount":=0;
        Rec.Open:=false;
        Rec."Statement Status":=Rec."Statement Status"::Closed;
        Rec.Modify();
        Rec.Get('725');
        Rec."Remaining Amount":=0;
        Rec.Open:=false;
        Rec."Statement Status":=Rec."Statement Status"::Closed;
        Rec.Modify();
        Rec.Get('719');
        Rec."Remaining Amount":=0;
        Rec.Open:=false;
        Rec."Statement Status":=Rec."Statement Status"::Closed;
        Rec.Modify();
        Rec.Get('243');
        Rec."Remaining Amount":=0;
        Rec.Open:=false;
        Rec."Statement Status":=Rec."Statement Status"::Closed;
        Rec.Modify();
        Rec.Get('79');
        Rec."Remaining Amount":=0;
        Rec.Open:=false;
        Rec."Statement Status":=Rec."Statement Status"::Closed;
        Rec.Modify();
    end;
    var Rec: Record "Bank Account Ledger Entry";
}
