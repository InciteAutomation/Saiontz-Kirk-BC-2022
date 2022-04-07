codeunit 50144 DepositSubscribers
{
    Permissions = TableData "Posted Deposit Line"=rimd;

    //Check for a deposit detail. If it exists, set posted depost line detail.
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Deposit-Post", 'OnBeforePostedDepositLineModify', '', true, true)]
    // procedure AddDepositDetail(var PostedDepositLine: Record "Posted Deposit Line"; GenJnlLine: Record "Gen. Journal Line")
    // var
    //     Company: Record Company;
    //     LastLineNo: Integer;
    //     Counter: Integer;
    //     flag: Boolean;
    // begin
    //     Company.Get(CompanyName);
    //     if (CompanyName = 'Accounts Payable') then begin
    //         LastLineNo += 10000;
    //         Counter := 0;
    //         flag := true;
    //         repeat
    //             Counter += 1;
    //             Message(Format(Counter));
    //             PostedDepositLine.Get(PostedDepositLine."Deposit No.", PostedDepositLine."Line No.");
    //             GenJnlLine.Get(GenJnlLine."Journal Template Name", GenJnlLine."Journal Batch Name", LastLineNo);
    //             if (GenJnlLine."Journal Template Name" = 'DEPOSITS') then begin
    //                 if (PostedDepositLine."Deposit Detail" = '') then begin
    //                     PostedDepositLine."Deposit Detail" := GenJnlLine."Deposit Detail";
    //                     PostedDepositLine.Modify();
    //                 end
    //                 else begin
    //                     PostedDepositLine."Deposit Detail" := GenJnlLine."Deposit Detail";
    //                     PostedDepositLine.Modify();
    //                 end;
    //             end
    //             else begin
    //                 flag := false;
    //             end;
    //         until flag = false;
    //     end;
    // end;
    //Check if the balance description field is empty and fill it.
    [EventSubscriber(ObjectType::Page, Page::"Deposit Subform", 'OnAfterActionEvent', 'DepositImport', true, true)]
    procedure checkDepositBalanceDescription(var Rec: Record "Gen. Journal Line")var GLAccount: Record "G/L Account";
    LastLineNo: Integer;
    NewEntry: Record "Gen. Journal Line";
    Company: Record Company;
    begin
        Company.Get(CompanyName);
        if(CompanyName = 'Accounts Payable')then begin
            repeat LastLineNo+=10000;
                Rec.Get(Rec."Journal Template Name", Rec."Journal Batch Name", LastLineNo);
                if(Rec."Balance Description" <> '')then begin
                    GLAccount.SetFilter("No.", Rec."Account No.");
                    GLAccount.FindLast();
                    Rec."Balance Description":=GLAccount.Name;
                    Rec.Modify;
                end;
            until Rec.next = 0;
        end;
    end;
    //Set description in Posted Deposit Lines
    [EventSubscriber(ObjectType::Table, 10144, 'OnAfterInsertEvent', '', true, true)]
    procedure correctDescription(var Rec: Record "Posted Deposit Line")var GLAccount: Record "G/L Account";
    Company: Record Company;
    begin
        Company.Get(CompanyName);
        if(CompanyName = 'Accounts Payable')then begin
            repeat Rec.Get(Rec."Deposit No.", Rec."Line No.");
                GLAccount.SetFilter("No.", Rec."Account No.");
                GLAccount.FindLast();
                if(Rec."Deposit Detail" <> '')then begin
                    Rec.Description:=GLAccount.Name;
                    Rec.Modify();
                end
                else
                begin
                    Rec.Description:=GLAccount.Name;
                    Rec.Modify();
                end;
            until Rec.next = 0;
        end;
    end;
    [EventSubscriber(ObjectType::Table, 10144, 'OnAfterInsertEvent', '', true, true)]
    procedure updatePDL(var Rec: Record "Posted Deposit Line")var escrow: Record EscrowAccounts;
    checkEmpty: Boolean;
    Company: Record Company;
    begin
        Company.Get(CompanyName);
        if(CompanyName = 'Escrow')then begin
            begin
                Rec.Get(Rec."Deposit No.", Rec."Line No.");
                if(Rec."Client Name" = '')then begin
                    escrow.SetFilter(escrow."Case Number", Rec."Case Number");
                    escrow.FindLast();
                    Rec."Client Name":=escrow."Client Name";
                    Rec.Modify();
                end;
            end;
        end;
    end;
}
