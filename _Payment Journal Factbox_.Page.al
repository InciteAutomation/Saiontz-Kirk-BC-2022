page 50146 "Payment Journal Factbox"
{
    Caption = 'Escrow Statistics';
    PageType = CardPart;
    SourceTable = EscrowAccounts;

    layout
    {
        area(Content)
        {
            group("Escrow Account Statistics")
            {
                field("Total Deposits ($)";"Total Deposits ($)" * -1)
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()begin
                        OpenDepositsPage();
                    end;
                }
                field("Total Checks ($)";"Total Checks ($)" * -1)
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()begin
                        OpenChecksPage();
                    end;
                }
                field("Balance Remaining";("Total Checks ($)" * -1) + ("Total Deposits ($)" * -1))
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    //TODO: What does this do and what does FilterGroup(4) mean.
    trigger OnAfterGetRecord()begin
        FilterGroup(4);
        CalcFields("Total Checks ($)", "Total Deposits ($)");
    end;
    local procedure OpenDepositsPage()var item: Record "Posted Deposit Line";
    begin
        //Filtering out records based on the record that was selected.
        item.SetFilter("Case Number", Rec."Case Number");
        PAGE.Run(PAGE::"Case Deposit List Part", item);
    end;
    local procedure OpenChecksPage()var item: Record "Check Ledger Entry";
    begin
        //Filtering out records based on the record that was selected.
        item.SetFilter("Case Number", rec."Case Number");
        PAGE.Run(PAGE::"Case Checks List Part", item);
    end;
}
