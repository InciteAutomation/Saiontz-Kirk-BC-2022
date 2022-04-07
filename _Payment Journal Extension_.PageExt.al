pageextension 50135 "Payment Journal Extension" extends "Payment Journal"
{
    layout
    {
        addafter("External Document No.")
        {
            field("Filevine Project Id";"FileVine Project ID")
            {
                Caption = 'Filevine Project ID';
                ApplicationArea = All;
                //Lookup = true;
                LookupPageId = "Case List Card";
            }
            field("Case Number";"Case Number")
            {
                //FIXME maybe change back
                ApplicationArea = EscrowApplication;
                lookup = true;
                //Need this in there so wee can add a new escrow account from the deposit page.
                LookupPageId = "Escrow Account Card";

                //Sets the client name based on the selected FV Number.
                trigger OnValidate()var EscrowAccount: Record EscrowAccounts;
                begin
                    if(CompanyName = 'Escrow')then begin
                        EscrowAccount.Get(rec."Case Number");
                        "Client Name":=EscrowAccount."Client Name";
                    end;
                end;
            }
            field("Client Name";"Client Name")
            {
                Caption = 'Case Name';
                ApplicationArea = EscrowApplication;
                Editable = false;
            }
            field("Check Type Code";"Shortcut Dimension 2 Code")
            {
                ApplicationArea = All;
            }
            field(Memo;"Deposit Detail")
            {
                Caption = 'Memo';
                ApplicationArea = All;
            }
        //field("Balance Description"; "Balance Description")
        //{
        //    ApplicationArea = All;
        //}
        }
        //modify("Account Name") { Visible = true; }
        //modify(Description) { Visible = false; }
        // modify("Account No.")
        // {
        //     trigger OnAfterValidate()
        //     var
        //         Vendor: Record Vendor;
        //     begin
        //         Vendor.Get(rec."Account No.");
        //         Description := Vendor.Name;
        //     end;
        // }
        modify("Payment Related Information 1")
        {
        ApplicationArea = Basic, Suite;
        }
        modify("Payment Related Information 2")
        {
        ApplicationArea = Basic, Suite;
        }
        modify("Bal. Account No.")
        {
        trigger OnAfterValidate()var BankAccount: Record "Bank Account";
        Company: Record Company;
        begin
            //TODO maybe fix
            // Company.Get(CompanyName);
            // if (CompanyName = 'Escrow') then begin
            BankAccount.Get(rec."Bal. Account No.");
            "Balance Description":=BankAccount.Name;
        // end;
        end;
        }
        modify("Document Date")
        {
        Caption = 'Check Date';
        Editable = SKGLManagerEditablility;

        trigger OnAfterValidate();
        var Publisher: Codeunit 50106;
        Company: Record Company;
        begin
            if(CompanyName = 'Escrow')then begin
                Publisher.OnDateChanged("Document Date", "Due Date", "Line No.", "Journal Template Name", "Journal Batch Name");
            end;
        end;
        }
        modify("Posting Date")
        {
        Editable = SKGLManagerEditablility;
        }
        modify(Amount)
        {
        trigger OnAfterValidate()var Escrow: Record EscrowAccounts;
        TotalDeposits: Decimal;
        TotalChecks: Decimal;
        ThisAmount: Decimal;
        payjourn: Record "Gen. Journal Line";
        balpage: Page "Case Balance List Part";
        Company: Record Company;
        begin
            Company.Get(CompanyName);
            if(CompanyName = 'Escrow')then begin
                Escrow.Get(rec."Case Number");
                Escrow.CalcFields("Total Checks ($)", "Total Deposits ($)", "Total Transfers In ($)", "Total Transfers Out ($)");
                TotalDeposits:=(Escrow."Total Checks ($)" * -1);
                TotalChecks:=(Escrow."Total Checks ($)" * -1);
                ThisAmount:=Amount;
                //balpage:= CurrPage."Case Balance";
                //if (((Abs(Escrow."Total Deposits ($)") - Escrow."Total Checks ($)") - Amount) < 0) then
                if(((Abs(Escrow."Total Deposits ($)") - Escrow."Total Checks ($)" + Escrow."Total Transfers In ($)" - Escrow."Total Transfers Out ($)") - Amount) < 0)then Error('Insufficent Funds TDeposits:' + Format(Abs(Escrow."Total Deposits ($)")) + ' TChecks:' + Format(Escrow."Total Checks ($)") + ' Amount:' + Format((ThisAmount)))
                else
                begin
                    CurrPage."Case Balance".Page.UpdateAmount(ThisAmount);
                    //Message('This is the new check amount ' + Format(ThisAmount));
                    CurrPage."Case Balance".Page.Update();
                end;
            end;
        end;
        }
        modify("Total Balance")
        {
        Visible = false;
        }
        modify(Control1900545401)
        {
        Visible = false;
        }
        modify("Number of Lines")
        {
        Visible = false;
        }
        modify("Account Name")
        {
        Visible = false;
        }
        modify("Bal. Account Name")
        {
        Visible = false;
        }
        modify(Control24)
        {
        Visible = false;
        }
        addbefore(Control24)
        {
            group("Balance Information")
            {
                Caption = '';

                //Shows the list of Check Items.
                part("Case Balance";"Case Balance List Part")
                {
                    ApplicationArea = EscrowApplication;
                    Caption = 'Case Balance';
                    Visible = CaseBalPartVisibility;
                    //Limit the list to only show items with the "Case Number" that is selected.
                    SubPageLink = "Case Number"=field("Case Number");
                //"Entry Status" = filter(Posted;);
                }
            }
        }
    }
    var CaseBalPartVisibility: Boolean;
    user: record User;
    SKGLManagerEditablility: Boolean;
    DateEditable: Boolean;
    trigger OnDeleteRecord(): Boolean //FIXME review this page. Add accounts payable logic as needed.
    var Escrow: Record EscrowAccounts;
    TotalDeposits: Decimal;
    TotalChecks: Decimal;
    ThisAmount: Decimal;
    payjourn: Record "Gen. Journal Line";
    balpage: Page "Case Balance List Part";
    begin
        if(CompanyName = 'Escrow')then begin
            Escrow.Get(rec."Case Number");
            ThisAmount:=Amount * -1;
            CurrPage."Case Balance".Page.UpdateAmount(ThisAmount);
            // Message('This is the delete check amount ' + Format(ThisAmount));
            CurrPage."Case Balance".Page.Update();
        end;
    end;
    trigger OnOpenPage()var caseBalPart: Page "Case Balance List Part";
    Company: Record Company;
    PermissionSetLookup: Page "Permission Set Lookup";
    PermPage: page "Permission Set by User";
    SuperAggPerSet: Record "Aggregate Permission Set";
    SK_GLPerSet: Record "Aggregate Permission Set";
    SuperAccountHas: Boolean;
    begin
        DateEditable:=false;
        Company.Get(CompanyName);
        if(CompanyName = 'Escrow')then begin
            SKGLManagerEditablility:=true;
        end
        else
        begin
            user.SetFilter("User Security ID", UserSecurityId());
            user.FindLast();
            SuperAggPerSet.SetFilter("Role ID", 'D365 BUS FULL ACCESS');
            SuperAggPerSet.FindLast();
            SK_GLPerSet.SetFilter("Role ID", 'SK_GL');
            SK_GLPerSet.FindLast();
            SKGLManagerEditablility:=(UserHasPermission(SK_GLPerSet, user)) or (UserHasPermission(SuperAggPerSet, user));
        end;
    //caseBalPart := CurrPage."Case Balance".Page;
    //xRec.is
    //message('Record is open from, Batch? ' + Format(rec.IsOpenedFromBatch()));
    //if rec.IsOpenedFromBatch() then CaseBalPartVisibility := false else CaseBalPartVisibility := true;
    //message('Is Vivible ' + format(CaseBalPartVisibility));
    end;
    local procedure UserHasPermission(var AggregatePermissionSet: Record "Aggregate Permission Set";
    var User: Record User): Boolean var AccessControl: Record "Access Control";
    begin
        AccessControl.SetRange("User Security ID", User."User Security ID");
        AccessControl.SetRange("Role ID", AggregatePermissionSet."Role ID");
        AccessControl.SetFilter("Company Name", '%1|%2', '', CompanyName);
        AccessControl.SetRange(Scope, AggregatePermissionSet.Scope);
        AccessControl.SetRange("App ID", AggregatePermissionSet."App ID");
        exit(not AccessControl.IsEmpty);
    end;
    /* trigger OnModifyRecord(): Boolean
     var
         chk: Record "Check Ledger Entry";
         ThisAmount: Decimal;
     begin
         message('This is the current record that was modified ' + Rec."Document No.");
         chk.Get(Rec."Document No.");
         if (chk."Entry Status" = chk."Entry Status"::Voided) then begin
             message('DId this work?');
             ThisAmount := chk.Amount * -1;
             CurrPage."Case Balance".Page.UpdateAmount(ThisAmount);
             CurrPage."Case Balance".Page.Update();

         end;
     end;
 */
    procedure setVisibility(var visability: Boolean)begin
        CaseBalPartVisibility:=visability;
    // message('set visability to ' + Format(visability));
    end;
}
