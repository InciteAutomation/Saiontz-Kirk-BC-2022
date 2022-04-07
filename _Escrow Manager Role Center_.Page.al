page 50145 "Escrow Manager Role Center"
{
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
        }
    }
    actions
    {
        area(Creation)
        {
        }
        area(Sections)
        {
            group("Escrow Navigation")
            {
                Caption = 'Escrow Navigation';

                action("Escrow Account List")
                {
                    ToolTip = 'Escrow Account List';
                    ApplicationArea = EscrowApplication;
                    RunObject = Page "Escrow Account List";
                }
                action("Vendors")
                {
                    ToolTip = 'List of Vendors.';
                    ApplicationArea = EscrowApplication;
                    RunObject = Page "Vendor List";
                }
                action("Bank Account")
                {
                    ApplicationArea = EscrowApplication;
                    RunObject = Page "Bank Account List";
                }
                action("List of GLs")
                {
                    ToolTip = 'Chart of Accounts';
                    ApplicationArea = EscrowApplication;
                    RunObject = Page "Chart of Accounts";
                }
            }
            group("Escrow Actions")
            {
                Caption = 'Escrow Actions';

                //Runs action to create new deposits
                action("Transfer Funds")
                {
                    //var pageGen : Page "General Journal";
                    ToolTip = 'Transfer funds from the Escrow Manager Archive or between Escrow Accounts in Business Central.';
                    ApplicationArea = EscrowApplication;
                    RunObject = Page "General Journal";
                // RunPageView = where("Document No." = const('TRANSFER'));
                // RunPageLink = "Document No." = filter('TRANSFER');
                //RunObject = codeunit "OpenGenJournalPage";
                //Run(PAGE::"General Journal", GLItem);
                //RunPageLink = "Document No." = const('TRANSFER');
                }
                action("Register Deposits")
                {
                    ToolTip = 'List of deposits that still need to be posted.';
                    ApplicationArea = EscrowApplication;
                    RunObject = Page "Deposits";
                }
                action("Register Payments")
                {
                    ToolTip = 'Add new Invoice to write a Check against.';
                    ApplicationArea = EscrowApplication;
                    RunObject = Page "Vendor Ledger Entries";
                    RunPageView = WHERE("Document Type"=Const(Invoice), "Open"=filter('Yes'));
                }
                //Runs action to create a new payment entry.  
                //RunPageView sets the needed filters so it only shows payment journals.
                action("Write Checks")
                {
                    ApplicationArea = EscrowApplication;
                    RunObject = Page "General Journal Batches";
                    RunPageView = WHERE("Template Type"=CONST(Payments), Recurring=CONST(false));
                    ToolTip = 'Register payments to vendors. A payment journal is a type of general journal that is used to post outgoing payment transactions to G/L, bank, customer, vendor, employee, and fixed assets accounts. The Suggest Vendor Payments functions automatically fills the journal with payments that are due. When payments are posted, you can export the payments to a bank file for upload to your bank if your system is set up for electronic banking. You can also issue computer checks from the payment journal.';
                }
                action("Bank Account Reconciliation")
                {
                    ToolTip = 'Reconcile the Bank Account';
                    ApplicationArea = EscrowApplication;
                    RunObject = page "Bank Acc. Reconciliation List";
                }
                action("Payment Reconciliation Journal")
                {
                    ToolTip = 'Reconcile the Bank Account from the Payment Reconciliation Journal';
                    ApplicationArea = EscrowApplication;
                    RunObject = page "Payment Reconciliation Journal";
                }
            }
            group("Purchasing")
            {
                action("Purchase Invoices")
                {
                    ToolTip = 'Purchase Invoices';
                    ApplicationArea = EscrowApplication;
                    RunObject = Page "Purchase Invoices";
                }
                action("Posted Purchase Invoices")
                {
                    ToolTip = 'Posted Purchase Invoices';
                    ApplicationArea = EscrowApplication;
                    RunObject = Page "Posted Purchase Invoices";
                }
            }
            group("Reports")
            {
                Caption = 'Reports';

                //action("Escrow Account Activity Report")
                //{
                //    ApplicationArea = EscrowApplication;
                //    RunObject = report REP_EscrowActivity;
                //    ToolTip = 'List of Vendors.';
                //}
                action("Wells Fargo Check Output")
                {
                    ApplicationArea = all;
                    RunObject = report REP_ChecksForWellsFargoEscrow;
                }
                action("Deposit Summary")
                {
                    ApplicationArea = EscrowApplication;
                    RunObject = report REP_EscrowDepositSummary;
                }
                action("Check Disbursements")
                {
                    ApplicationArea = EscrowApplication;
                    RunObject = report REP_EscrowCheckRegister;
                }
                action("Open Balance Case Summary")
                {
                    ApplicationArea = EscrowApplication;
                    RunObject = report REP_EscrowOpenBalanceSummary;
                }
                action("Voided Checks")
                {
                    ApplicationArea = EscrowApplication;
                    RunObject = report REP_EscrowVoidCheckRegister;
                }
                action("Escrow Monthly Summary")
                {
                    ApplicationArea = EscrowApplication;
                    RunObject = report REP_EscrowSummary;
                }
                action("Report Inbox")
                {
                    ApplicationArea = EscrowApplication;
                    RunObject = page "Report Inbox";
                }
            }
            group("Administration")
            {
                action("Import/Upload Center")
                {
                    ApplicationArea = EscrowApplication;
                    RunObject = Page "Escrow Manager Administration";
                }
                action("Case List")
                {
                    ApplicationArea = All;
                    RunObject = Page "Case List List";
                }
            }
        }
    }
}
