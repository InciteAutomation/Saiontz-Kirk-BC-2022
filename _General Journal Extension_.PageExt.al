pageextension 50192 "General Journal Extension" extends "General Journal"
{
    layout
    {
        addafter("Credit Amount")
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
                        "Client Name":=EscrowAccount."Client Name";
                    end;
                end;
            }
            field("Client Name";"Client Name")
            {
                Visible = true;
                ApplicationArea = EscrowApplication;
            //Editable = false;
            //Lookup = true;
            }
            field("FileVine Project ID";"FileVine Project ID")
            {
                Visible = true;
                ApplicationArea = All;
            }
        }
        modify("Tax Liable")
        {
        Visible = false;
        }
        modify("Tax Area Code")
        {
        Visible = false;
        }
        modify("Tax Group Code")
        {
        Visible = false;
        }
        modify(Description)
        {
        Visible = false;
        }
    }
    var docnum: Code[20];
}
