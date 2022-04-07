pageextension 50120 "Extend Navigation Area" extends "Business Manager Role Center"
{
    actions
    {
        addfirst(Sections)
        {
            group("Escrow Manager")
            {
                //if ((CompanyName = 'Escrow Manager Full Import') OR (CompanyName = 'SK - Escrow')) 
                visible = ((CompanyName = 'Escrow') OR (CompanyName = 'SK - Escrow'));

                action("Escrow Account List")
                {
                    //visible = ((CompanyName = 'Escrow Manager Full Import') OR (CompanyName = 'SK - Escrow'));
                    ApplicationArea = EscrowApplication;
                    RunObject = page "Escrow Account List";
                }
            }
        }
        addafter("Excel Reports")
        {
            action("Payment Reconciliation Journal")
            {
                ApplicationArea = AccountsPayable;
                RunObject = page "Payment Reconciliation Journal";
            }
        }
        addbefore("Financial Statements")
        {
            action("Wells Fargo Check Output")
            {
                ApplicationArea = AccountsPayable;
                RunObject = report REP_ChecksForWellsFargo;
                image = ListPage;
            }
            action("Check Disbursements")
            {
                ApplicationArea = AccountsPayable;
                RunObject = report REP_APCheckRegister;
                Image = CheckJournal;
            }
            action("Domo Export")
            {
                ApplicationArea = AccountsPayable;
                RunObject = report REP_DomoExport;
                Image = GL;
            }
        }
        addbefore("Services & Extensions")
        {
            action("Case List Import")
            {
                ToolTip = 'Import Case List from an CSV file.';
                ApplicationArea = All;
                RunObject = page "Case List List";
            // RunObject = xmlport("Case List Import/Export",true, true);//("Posted Deposit Line", true, true);
            //Xmlport.Run(Xmlport::"Checks Import/Export", true, true);
            } // Xmlport.Run(Xmlport::"Checks Import/Export", true, true);
        }
    }
}
