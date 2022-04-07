page 50123 "Purch Invoice Balance Fact Box"
{
    Caption = 'Case Statistics';
    PageType = CardPart;
    SourceTable = EscrowAccounts;

    layout
    {
        area(Content)
        {
            group("Escrow Account Statistics")
            {
                field("Total Deposits ($)";"Total Deposits ($)")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()begin
                        OpenDepositsPage();
                    end;
                }
                field("Total Checks ($)";"Total Checks ($)")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()begin
                        OpenChecksPage();
                    // "Entry Status" = filter(Posted;);
                    end;
                }
                field("Total Transfers In ($)";"Total Transfers In ($)")
                {
                    ApplicationArea = All;
                    Visible = true;

                    trigger OnDrillDown()begin
                        OpenTransfersPage();
                    end;
                }
                field("Total Transfers Out ($)";"Total Transfers Out ($)")
                {
                    ApplicationArea = All;
                    Visible = true;

                    trigger OnDrillDown()begin
                        OpenTransfersPage();
                    end;
                }
                field("Total Transfers ($)";(("Total Transfers In ($)") - ("Total Transfers Out ($)")))
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Total Purchase Invoices ($)";"Total Purchase Invoices ($)")
                {
                    ApplicationArea = all;
                    visible = true;
                }
                field("Balance Remaining";(("Total Deposits ($)") - ("Total Checks ($)") + ("Total Transfers In ($)") - ("Total Transfers Out ($)")))
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
        item.SetFilter("Entry Status", 'Posted');
        PAGE.Run(PAGE::"Case Checks List Part", item);
    end;
    local procedure OpenTransfersPage()var item: Record "G/L Entry";
    begin
        item.SetFilter("Case Number", Rec."Case Number");
        PAGE.Run(PAGE::"Transfer List Part", item);
    end;
}
