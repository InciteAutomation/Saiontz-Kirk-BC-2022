page 50134 "Case Balance List Part"
{
    PageType = ListPart;
    UsageCategory = Lists;
    SourceTable = EscrowAccounts;
    Editable = false;
    InsertAllowed = false;
    DeleteAllowed = false;
    RefreshOnActivate = true;

    //CardPageId = "Escrow Account Card";
    layout
    {
        area(content)
        {
            repeater(Cases)
            {
                field("Case Number";"Case Number")
                {
                    ApplicationArea = All;
                }
                field("Name";"Client Name")
                {
                    ApplicationArea = All;
                }
                field("Total Deposits ($)";"Total Deposits ($)")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                }
                field("Total Deposits";"Total Deposits ($)" * -1)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Total Checks ($)";"Total Checks ($)")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                }
                field("Total Checks (Posted + Draft)";"Total Checks ($)" + amount)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;
                }
                field("Total Checks";"Total Checks ($)" * -1)
                {
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Total Transfers In ($)";"Total Transfers In ($)" * -1)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                /*
                    trigger OnDrillDown()
                    begin
                        OpenChecksPage();
                    end;*/
                }
                field("Total Transfers In";"Total Transfers In ($)")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Total Transfers Out ($)";"Total Transfers Out ($)" * -1)
                {
                    ApplicationArea = Basic, Suite;
                    Visible = false;
                /*
                    trigger OnDrillDown()
                    begin
                        OpenChecksPage();
                    end;*/
                }
                field("Total Transfers Out";"Total Transfers Out ($)")
                {
                    ApplicationArea = All;
                    Visible = true;
                }
                field("Total Transfers ($)";("Total Transfers In ($)") - "Total Transfers Out ($)")
                {
                    ApplicationArea = all;
                    visible = False;
                }
                //field("Balance Remaining"; (("Total Checks ($)") - ("Total Deposits ($)")) * -1)
                field("Balance Remaining";(("Total Deposits ($)") - ("Total Checks ($)" + amount) + ("Total Transfers In ($)") - "Total Transfers Out ($)"))
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var amount: Decimal;
    procedure UpdateAmount(Var checkamount: Decimal)begin
        amount:=amount + checkamount;
    end;
    trigger OnInit()var genjrnlLine: Record "Gen. Journal Line";
    Company: Record Company;
    begin
        Company.Get(CompanyName);
        if(CompanyName = 'Escrow')then begin
            amount:=0;
            genjrnlLine.SetFilter("Case Number", Rec."Case Number");
            genjrnlLine.setfilter("Journal Template Name", 'PAYMENT');
            genjrnlLine.setfilter("Journal Batch Name", 'ESCROW');
            genjrnlLine.CalcSums(Amount);
            amount:=genjrnlLine.Amount;
            ;
            // Message('This is the amount in the Gen Journal Line ' + Format(amount));
            if(genjrnlLine.CalcSums(Amount))then amount:=genjrnlLine.Amount;
        //if ( rec.IsEmpty ) then begin end; else 
        end;
    end;
}
