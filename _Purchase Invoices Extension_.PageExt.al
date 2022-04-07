pageextension 50137 "Purchase Invoices Extension" extends "Purchase Invoices"
{
    layout
    {
        addbefore("Buy-from Vendor No.")
        {
            field("Case Number";"Case Number")
            {
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
                    //CurrPage.PurchLines.Page.UpdateCaseNumer(rec."Case Number");
                    end;
                end;
            }
        }
    }
}
