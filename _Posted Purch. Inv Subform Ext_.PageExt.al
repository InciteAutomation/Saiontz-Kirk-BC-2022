pageextension 50129 "Posted Purch. Inv Subform Ext" extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addbefore("No.")
        {
            field("Case Number";"Case Number")
            {
                Visible = true;
                ApplicationArea = EscrowApplication;
                lookup = true;
                //Need this in there so wee can add a new escrow account from the deposit page.
                LookupPageId = "Escrow Account Details";

                //Sets the client name based on the selected Escrow Number.
                trigger OnValidate()var EscrowAccount: Record EscrowAccounts;
                Company: Record Company;
                begin
                    Company.Get(CompanyName);
                    if(CompanyName = 'Escrow')then begin
                        EscrowAccount.Get(rec."Case Number");
                    // "Client Name" := EscrowAccount."Client Name";
                    end;
                end;
            }
            field("Project ID";"Project ID")
            {
                Visible = true;
                ApplicationArea = all;
                lookup = true;
                Caption = 'Filevine Project ID';

                //Need this in there so wee can add a new escrow account from the deposit page.
                //LookupPageId = "Escrow Account Details";
                //Sets the client name based on the selected Escrow Number.
                trigger OnValidate()var CaseList: Record CaseList;
                Company: Record Company;
                begin
                    Company.Get(CompanyName);
                    if(not(CompanyName = 'Escrow'))then begin
                        CaseList.Get(rec."Project ID");
                    // "Client Name" := EscrowAccount."Client Name";
                    end;
                end;
            }
        }
    }
}
