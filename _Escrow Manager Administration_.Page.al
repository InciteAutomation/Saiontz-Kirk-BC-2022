page 50152 "Escrow Manager Administration"
{
    PageType = Worksheet;
    ApplicationArea = All;
    UsageCategory = Administration;

    actions
    {
        area(Navigation)
        {
            group("1 - Escrow Accounts")
            {
                action("Escrow Account Import")
                {
                    ToolTip = 'Import Escrow Accounts from an CSV file.';
                    ApplicationArea = All;

                    trigger OnAction()begin
                        Xmlport.Run(Xmlport::"Escrow Account Import/Export", false, true);
                    end;
                }
            }
            group("2 & 3 - Vendors")
            {
                action("Vendors Import")
                {
                    ToolTip = 'Import Vendors from an CSV file.';
                    ApplicationArea = All;

                    trigger OnAction()begin
                        Xmlport.Run(Xmlport::"Vendors Import/Export", false, true);
                    end;
                }
            }
            group("4 - Deposit Header - Manually Add One")
            {
                action("Deposit Header - Manually Add One")
                {
                    ToolTip = 'Import Vendors from an CSV file.';
                    ApplicationArea = All;

                    trigger OnAction()begin
                    end;
                }
            }
            group("5 - Deposits")
            {
                action("General Ledger Entries - Deposits")
                {
                    ToolTip = 'Import GL Journal Entries from a CSV file.';
                    ApplicationArea = All;

                    trigger OnAction()begin
                        Xmlport.Run(Xmlport::"GL Import", true, true);
                    end;
                }
                action("Bank Account Ledger Import")
                {
                    ToolTip = 'Import Bank Account Ledger from an CSV file.';
                    ApplicationArea = All;

                    trigger OnAction()begin
                        Xmlport.Run(Xmlport::"Bank Account Ledger", true, true);
                    end;
                }
                action("Posted Deposit Line Import")
                {
                    ToolTip = 'Import Posted Deposit Line from an CSV file.';
                    ApplicationArea = All;

                    trigger OnAction()begin
                        Xmlport.Run(Xmlport::"Posted Deposit Line", true, true);
                    end;
                }
                action("Posted Deposit Line Export")
                {
                    ToolTip = 'Export Posted Deposit Line from an CSV file.';
                    ApplicationArea = All;

                    trigger OnAction()begin
                        Xmlport.Run(Xmlport::"Posted Deposit Line", false, false);
                    end;
                }
            }
            group("6 - Checks")
            {
                action("Check Ledger Entries")
                {
                    ToolTip = 'Import Check Ledger Entries from a CSV file.';
                    ApplicationArea = All;

                    trigger OnAction()begin
                        Xmlport.Run(Xmlport::"Checks Import/Export", true, true);
                    end;
                }
                action("General Ledger Entries - Checks")
                {
                    ToolTip = 'Import GL Journal Entries from a CSV file.';
                    ApplicationArea = All;

                    trigger OnAction()begin
                        Xmlport.Run(Xmlport::"GL Check Import", true, true);
                    end;
                }
                action("Vendor Ledger Entires")
                {
                    ToolTip = 'Import Vendor Ledger from an CSV file.';
                    ApplicationArea = All;

                    trigger OnAction()begin
                        Xmlport.Run(Xmlport::"Vendor Ledger Entry Import", true, true);
                    end;
                }
                action("Bank Account Ledger Entries")
                {
                    ToolTip = 'Import Bank Account Ledger from an CSV file.';
                    ApplicationArea = All;

                    trigger OnAction()begin
                        Xmlport.Run(Xmlport::"Bank Account Ledger Entry", true, true);
                    end;
                }
                action("Detailed Vendor Ledger Entries")
                {
                    ToolTip = 'Import Detailed Vendor Ledger from an CSV file.';
                    ApplicationArea = All;

                    trigger OnAction()begin
                        Xmlport.Run(Xmlport::"Detailed Vendor Ledger Entry", true, true);
                    end;
                }
            }
        }
        area(Reporting)
        {
            group("Recal Totals")
            {
                action("Recalc Totals")
                {
                    ToolTip = 'Recalculates all totals in the database';
                    ApplicationArea = All;

                    trigger OnAction()var EscrowAccounts: Record EscrowAccounts;
                    begin
                        EscrowAccounts.SetAutoCalcFields("Total Deposits ($)", "Total Checks ($)");
                    end;
                }
            }
        }
    }
}
