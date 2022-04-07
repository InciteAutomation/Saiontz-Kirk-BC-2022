page 50127 "Escrow Account List"
{
    PageType = List;
    UsageCategory = Lists;
    SourceTable = EscrowAccounts;
    Editable = false;
    //InsertAllowed = false;
    DeleteAllowed = false;
    RefreshOnActivate = true;
    CardPageId = "Escrow Account Card";

    layout
    {
        area(content)
        {
            repeater(Cases)
            {
                field("Case Number";"Case Number")
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()begin
                        OpenCaseDetailsPage();
                    end;
                }
                field("Name";"Client Name")
                {
                    ApplicationArea = All;
                }
                field("Filevine URL";"Filevine URL")
                {
                    ApplicationArea = All;
                    ExtendedDatatype = URL;
                }
                field("Total Deposits ($)";"Total Deposits ($)")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;

                    trigger OnDrillDown()begin
                        OpenDepositsPage();
                    end;
                }
                field("Total Deposits";"Total Deposits ($)" * -1)
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnDrillDown()begin
                        OpenDepositsPage();
                    end;
                }
                field("Total Checks ($)";"Total Checks ($)")
                {
                    ApplicationArea = Basic, Suite;
                    Visible = true;

                    trigger OnDrillDown()begin
                        OpenChecksPage();
                    end;
                }
                field("Total Checks";"Total Checks ($)" * -1)
                {
                    ApplicationArea = All;
                    Visible = false;

                    trigger OnDrillDown()begin
                        OpenChecksPage();
                    end;
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

                    trigger OnDrillDown()begin
                        OpenTransferDetailsPage();
                    end;
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

                    trigger OnDrillDown()begin
                        OpenTransferDetailsPage();
                    end;
                }
                field("Total Transfers ($)";("Total Transfers In ($)") - "Total Transfers Out ($)")
                {
                    ApplicationArea = all;
                    visible = False;
                }
                //field("Balance Remaining"; (("Total Checks ($)") - ("Total Deposits ($)")) * -1)
                field("Balance Remaining";(("Total Deposits ($)") - ("Total Checks ($)") + ("Total Transfers In ($)") - "Total Transfers Out ($)"))
                {
                    ApplicationArea = All;

                    trigger OnDrillDown()begin
                        OpenCaseDetailsPage()end;
                }
                field("Archived";"Escrow Account Archive")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    local procedure OpenChecksPage()var item: Record "Check Ledger Entry";
    begin
        //Filtering out records based on the record that was selected.
        item.SetFilter("Case Number", rec."Case Number");
        PAGE.Run(PAGE::"Case Checks List Part", item);
    end;
    local procedure OpenDepositsPage()var item: Record "Posted Deposit Line";
    begin
        //Filtering out records based on the record that was selected.
        item.SetFilter("Case Number", Rec."Case Number");
        PAGE.Run(PAGE::"Case Deposit List Part", item);
    end;
    local procedure OpenCaseDetailsPage()var item: Record EscrowAccounts;
    begin
        item.SetFilter("Case Number", Rec."Case Number");
        PAGE.Run(PAGE::"Escrow Account Details", item);
    end;
    local procedure OpenTransferDetailsPage()var item: Record "G/L Entry";
    begin
        item.SetFilter("Case Number", Rec."Case Number");
        PAGE.Run(PAGE::"Transfer List Part", item);
    end;
}
