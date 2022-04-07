pageextension 50121 PurchaseInvoiceExtension extends "Purchase Invoice"
{
    layout
    {
        modify("Purchaser Code")
        {
        Visible = false;
        }
        modify("Campaign No.")
        {
        Visible = false;
        }
        modify("Order Address Code")
        {
        Visible = false;
        }
        modify("Responsibility Center")
        {
        Visible = false;
        }
        modify("Assigned User ID")
        {
        Visible = false;
        }
        addafter("Buy-from Vendor Name")
        {
            field("Case Number";"Case Number")
            {
                Visible = showCase;
                //FIXME maybe change back
                ApplicationArea = EscrowApplication;
                lookup = true;

                //Need this in there so wee can add a new escrow account from the deposit page.
                //LookupPageId = "Escrow Account Card";
                //Sets the client name based on the selected FV Number.
                trigger OnValidate()var EscrowAccount: Record EscrowAccounts;
                begin
                    if(CompanyName = 'Escrow')then begin
                        EscrowAccount.Get(rec."Case Number");
                        // "Client Name" := EscrowAccount."Client Name";
                        CurrPage.PurchLines.Page.UpdateCaseNumer(rec."Case Number");
                    end;
                end;
            }
            field("Project ID";"Project Id")
            {
                //Visible = not (showCase);
                //FIXME maybe change back
                ApplicationArea = EscrowApplication;
                lookup = true;
                Caption = 'Filevine Project ID';

                //Need this in there so wee can add a new escrow account from the deposit page.
                //LookupPageId = "Escrow Account Card";
                //Sets the client name based on the selected FV Number.
                trigger OnValidate()var CaseList: Record CaseList;
                begin
                    if(Not(CompanyName = 'Escrow'))then begin
                        CaseList.Get(rec."Project ID");
                        // "Client Name" := EscrowAccount."Client Name";
                        CurrPage.PurchLines.Page.UpdateProjectID(rec."Project ID");
                    end;
                end;
            }
        }
        addafter(IncomingDocAttachFactBox)
        {
            //Shows the list of Check Items.
            part("Case Balance";"Purch Invoice Balance Fact Box")
            {
                ApplicationArea = EscrowApplication;
                Caption = 'Case Balance';
                //Visible = CaseBalPartVisibility;
                //Limit the list to only show items with the "Case Number" that is selected.
                SubPageLink = "Case Number"=field("Case Number");
            //"Entry Status" = filter(Posted;);
            }
        }
    }
    var showCase: Boolean;
    trigger OnOpenPage()begin
        showCase:=false;
        if(CompanyName = 'Escrow')then begin
            showCase:=true;
        end;
    end;
}
