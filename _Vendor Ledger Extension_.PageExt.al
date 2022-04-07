pageextension 50171 "Vendor Ledger Extension" extends "Vendor Ledger Entries"
{
    layout
    {
        modify("Currency Code")
        {
        ApplicationArea = All;
        Visible = false;
        }
        modify("Pmt. Discount Date")
        {
        ApplicationArea = All;
        Visible = false;
        }
        modify("Creditor No.")
        {
        ApplicationArea = All;
        Visible = false;
        }
        modify("Payment Reference")
        {
        ApplicationArea = All;
        Visible = false;
        }
        modify("Original Amount")
        {
        ApplicationArea = All;
        Visible = false;
        }
        modify("Amount")
        {
        ApplicationArea = All;
        Visible = false;
        }
        modify("Remaining Amount")
        {
        ApplicationArea = All;
        Visible = false;
        }
        modify("Dimension Set ID")
        {
        ApplicationArea = All;
        Visible = false;
        }
        modify("Pmt. Disc. Tolerance Date")
        {
        ApplicationArea = All;
        Visible = false;
        }
        modify("Original Pmt. Disc. Possible")
        {
        ApplicationArea = All;
        Visible = false;
        }
        modify("Remaining Pmt. Disc. Possible")
        {
        ApplicationArea = All;
        Visible = false;
        }
        modify("Max. Payment Tolerance")
        {
        ApplicationArea = All;
        Visible = false;
        }
        modify("Exported to Payment File")
        {
        ApplicationArea = All;
        Visible = false;
        }
        modify(RecipientBankAcc)
        {
        ApplicationArea = All;
        Visible = false;
        }
        addafter("Document Type")
        {
            field("Case Number";"Case Number")
            {
                Visible = showCase;
                ApplicationArea = EscrowApplication;
                lookup = true;
            }
            field("Project ID";"Project ID")
            {
                Caption = 'Filevine Project ID';
                Visible = not(showCase);
                ApplicationArea = EscrowApplication;
                lookup = true;
            }
        }
        modify("Vendor Name")
        {
        Visible = true;
        }
        moveafter("Vendor No.";"Vendor Name")
    }
    var showCase: Boolean;
    trigger OnOpenPage()begin
        showCase:=false;
        if(CompanyName = 'Escrow')then begin
            showCase:=true;
        end;
    end;
}
