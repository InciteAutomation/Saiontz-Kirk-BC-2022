codeunit 50102 OnPostCheck
{
    EventSubscriberInstance = StaticAutomatic;

    //Check if There is a check date in all entries before posting.
    [EventSubscriber(ObjectType::Page, Page::"Payment Journal", 'OnBeforeActionEvent', 'Post', true, true)]
    local procedure checkDocumentDate(var Rec: Record "Gen. Journal Line")// var
    //     item: Record EscrowAccounts;
    var lineNo: Integer;
    begin
        lineNo:=Rec."Line No.";
        repeat if(Rec."Document Date" = 0D)THEN ERROR('Please enter a Check Date for all of the entries before posting.');
        until rec.next = 0 end;
    //Navigate to home page after posting.
    [EventSubscriber(ObjectType::Page, Page::"Payment Journal", 'OnAfterActionEvent', 'Post', true, true)]
    local procedure navigateToAccountDetails(var Rec: Record "Gen. Journal Line")var Company: Record Company;
    begin
        Company.Get(CompanyName);
        if(CompanyName = 'Escrow')then begin
            PAGE.Run(PAGE::"Escrow Manager Role Center");
        end;
    end;
    //Ensure that the document date is set in Bank Account Ledger Entries correctly after printing.
    //FIXME
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::CheckChangedDate, 'OnDateChanged', '', true, true)]
    // local procedure postChecks(DocumentDate: Date; DueDate: Date; LineNum: Integer; JrlTempName: Code[2048]; BatchName: Code[2048])
    // var
    //     txtDate: text;
    //     txtDate2: text;
    //     Rec: Record "Gen. Journal Line";
    // begin
    //     txtDate := Format(DocumentDate);
    //     txtDate2 := Format(DueDate);
    //     // MESSAGE('You must post this batch before leaving the page.', txtDate, txtDate2);
    //     if (DueDate <> 0D) then begin
    //         Rec.Get(JrlTempName, BatchName, LineNum);
    //         Rec."Document Date" := Rec."Due Date";
    //         Rec.Modify();
    //     end;
    // end;
    //Ensure all entries have a check date before printing.
    [EventSubscriber(ObjectType::Page, Page::"Payment Journal", 'OnBeforeActionEvent', 'PrintCheck', true, true)]
    local procedure prePrintCheckWarning(var Rec: Record "Gen. Journal Line")begin
        repeat if(Rec."Document Date" = 0D)THEN ERROR('Please enter a Check Date for all entries before printing.');
        until rec.next = 0 end;
    //Remind user to post checks before laving the page (after printing).
    //Update check date in check register
    [EventSubscriber(ObjectType::Page, Page::"Payment Journal", 'OnAfterActionEvent', 'PrintCheck', true, true)]
    local procedure afterPrintCheckWarning(var Rec: Record "Gen. Journal Line")var CheckRec: Record "Check Ledger Entry";
    begin
    //FIXME
    // Rec.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.");
    // CheckRec.SetFilter("Document No.", Rec."Document No.");
    // CheckRec.FindLast();
    // CheckRec."Check Date" := Rec."Document Date";
    // CheckRec.Modify();
    //Message('Do not forget to post this batch before leaving the page.');
    end;
    [EventSubscriber(ObjectType::Table, 272, 'OnAfterModifyEvent', '', true, true)]
    local procedure fixDocumentDate(Rec: Record "Check Ledger Entry")// var
    //     item: Record EscrowAccounts;
    var DocDate: Date;
    TempDate: Text;
    DocumentNo: Code[2048];
    Amount: Decimal;
    BankEntry: Integer;
    CheckEntry: Integer;
    BankRec: Record "Bank Account Ledger Entry";
    CheckRec: Record "Check Ledger Entry";
    TestRecord: Record "Bank Account Ledger Entry";
    //Ensure Check Ledger Entries has correct check date
    begin
        //FIXME
        if(BankRec.Get(Rec."Bank Account Ledger Entry No."))then begin
            if(Rec."Check Date" <> BankRec."Document Date")then begin
                Rec."Check Date":=BankRec."Document Date";
                Rec.Modify();
            end;
        end;
        //Pass voided date to check ledger entries if voided
        if(Rec."Entry Status" = Rec."Entry Status"::Voided)then begin
            if(Rec."Void Date" = 0D)then begin
                DocDate:=Today;
                Rec."Void Date":=DocDate;
                Rec.Modify();
            end;
        end;
        //Pass voided date (if financially voided) to check ledger entries
        if(Rec."Entry Status" = Rec."Entry Status"::"Financially Voided")then begin
            DocumentNo:=Rec."Document No.";
            BankRec.SetFilter("Document No.", DocumentNo);
            BankRec.FindLast;
            if(Rec."Void Date" <> BankRec."Document Date")then begin
                Rec."Void Date":=BankRec."Document Date";
                Rec.Modify()end;
        end;
        if(Rec."Statement Status" = Rec."Statement Status"::Closed)then begin
            if(Rec."Cleared Date" = 0D)then begin
                Rec."Cleared Date":=Today();
                Rec.Modify();
            end;
        end;
    end;
}
