pageextension 50132 "Posted Purch Incoices Ext" extendS "Posted Purchase Invoices"
{
    layout
    {
        addafter("Vendor Invoice No.")
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
        }
    }
}
