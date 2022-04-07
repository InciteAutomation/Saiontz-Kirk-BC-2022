codeunit 50142 Subscribers
{
    EventSubscriberInstance = StaticAutomatic;

    //Subscribe to the posting process and insert the Case Number into the PostedDepositLine.
    //Actual insert gets done in the base event call.
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Deposit-Post", 'OnBeforePostedDepositLineInsert', '', true, true)]
    procedure AddCaseNumberToPostedDeposit(var PostedDepositLine: Record "Posted Deposit Line";
    GenJnlLine: Record "Gen. Journal Line");
    var Company: Record Company;
    begin
        Company.Get(CompanyName);
        if(CompanyName = 'Escrow')then begin
            //TODO:Test what happens if the Case Number is blank.
            PostedDepositLine."Case Number":=GenJnlLine."Case Number";
            PostedDepositLine."Deposit Detail":=GenJnlLine."Deposit Detail";
            PostedDepositLine."Client Name":=GenJnlLine."Client Name";
        end
        else
        begin
            PostedDepositLine."Deposit Detail":=GenJnlLine."Deposit Detail";
            PostedDepositLine."Client Name":=GenJnlLine."Client Name";
        end;
    end;
    //Add the case number to the bank ledger line.  
    //This is done durning the posting process and needs to be in there to make it to the Check. 
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitBankAccLedgEntry', '', true, true)]
    procedure AddCaseNumberToBankLedgerEntry(var BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
    GenJournalLine: Record "Gen. Journal Line");
    var Company: Record Company;
    begin
        Company.Get(CompanyName);
        if(CompanyName = 'Escrow')then begin
            //TODO:Test what happens if the Case Number is blank.
            BankAccountLedgerEntry."Case Number":=GenJournalLine."Case Number";
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterInsertPostedHeaders', '', true, true)]
    procedure AddCaseNoToPostedPurchInvoice(var PurchaseHeader: Record "Purchase Header";
    var PurchRcptHeader: Record "Purch. Rcpt. Header";
    var PurchInvHeader: Record "Purch. Inv. Header";
    var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
    var ReturnShptHeader: Record "Return Shipment Header");
    var Company: Record Company;
    begin
        Company.Get(CompanyName);
        if(CompanyName = 'Escrow')then begin
            PurchInvHeader."Case Number":=PurchaseHeader."Case Number";
        end
        else
        begin
            PurchInvHeader."Project ID":=PurchInvHeader."Project ID";
        end;
    end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterUpdatePurchaseHeader', '', true, true)]
    procedure AddCaseNoToVendo(var VendorLedgerEntry: Record "Vendor Ledger Entry";
    var PurchInvHeader: Record "Purch. Inv. Header";
    var PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr.";
    GenJnlLineDocType: Integer);
    var Company: Record Company;
    begin
        Company.Get(CompanyName);
        if(CompanyName = 'Escrow')then begin
            VendorLedgerEntry."Case Number":=PurchInvHeader."Case Number";
            VendorLedgerEntry.Modify();
        end
        else
        begin
            VendorLedgerEntry."Project ID":=PurchInvHeader."Project ID";
            VendorLedgerEntry.Modify();
        end;
        ;
    end;
    // [EventSubscriber(ObjectType::Page, Page::"Payment Reconciliation Journal", 'ImportBankTransactions', '', true, true)]
    // procedure UpdateTransactionDate(SubscriberInvoked: Boolean; BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line")
    // begin
    //     Message('Did this run?');
    //     BankAccReconciliationLine.ModifyAll("Transaction Date", WorkDate());
    // end;
    //procedure OnAfterImportBankTransactions(var SubscriberInvoked: Boolean; var BankAccReconciliationLine: Record "Bank Acc. Reconciliation Line")
    [EventSubscriber(ObjectType::table, Database::"Payment Buffer", 'OnCopyFieldsFromVendorLedgerEntry', '', true, true)]
    procedure AddCaseToPaymentBuffer(VendorLedgerEntrySource: Record "Vendor Ledger Entry";
    var PaymentBufferTarget: Record "Payment Buffer")var Company: Record Company;
    begin
        Company.Get(CompanyName);
        if(CompanyName = 'Escrow')then begin
            PaymentBufferTarget."Case Number":=VendorLedgerEntrySource."Case Number";
        // PaymentBufferTarget.Modify();
        //GenJournalLine.Modify();
        end
        else
        begin
            PaymentBufferTarget."FileVine Project ID":=VendorLedgerEntrySource."Project ID";
        end;
        ;
    end;
    [EventSubscriber(ObjectType::Table, Database::"Payment Buffer", 'OnCopyFieldsToGenJournalLine', '', true, true)]
    procedure AddCaseToGenJrl(PaymentBufferSource: Record "Payment Buffer";
    var GenJournalLineTarget: Record "Gen. Journal Line")var Company: Record Company;
    begin
        Company.Get(CompanyName);
        if(CompanyName = 'Escrow')then begin
            GenJournalLineTarget."Case Number":=PaymentBufferSource."Case Number";
        //GenJournalLineTarget.Modify();
        //GenJournalLine.Modify();
        end
        else
        begin
            GenJournalLineTarget."FileVine Project ID":=PaymentBufferSource."FileVine Project ID";
        end;
        ;
    end;
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostInvPostBuffer', '', true, true)]
    // procedure AddCaseToGLEntryAfterPostInv(var GenJnlLine: Record "Gen. Journal Line"; var InvoicePostBuffer: Record "Invoice Post. Buffer"; PurchHeader: Record "Purchase Header"; GLEntryNo: Integer; CommitIsSupressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line");
    // var
    //     Company: Record Company;
    //     GlEntry1: Record "G/L Entry";
    //     GlEntry2: Record "G/L Entry";
    // begin
    //     Company.Get(CompanyName);
    //     if (CompanyName = 'Escrow') then begin
    //         //Dialog.Message('OnAfterPostInvPostBuffer');
    //         //Dialog.Message('PurchHeader.casenumber' + PurchHeader."Case Number");
    //         //Dialog.Message('GLEntryNo' + Format(GLEntryNo));
    //         GlEntry1.Get(GLEntryNo);
    //         GlEntry1."Case Number" := PurchHeader."Case Number";
    //         GlEntry1.Modify();
    //         Dialog.Message('GlEntry1' + Format(GlEntry1."Entry No."));
    //         GlEntry2.Get(GLEntryNo + 1);
    //         Glentry2."Case Number" := PurchHeader."Case Number";
    //         GlEntry2.Modify();
    //     end;
    // end;
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostVendorEntry', '', true, true)]
    // procedure AddCaseNoToGenJourLine(var GenJnlLine: Record "Gen. Journal Line"; var PurchHeader: Record "Purchase Header"; var TotalPurchLine: Record "Purchase Line"; var TotalPurchLineLCY: Record "Purchase Line"; CommitIsSupressed: Boolean; var GenJnlPostLine: Codeunit "Gen. Jnl.-Post Line");
    // var
    //     Company: Record Company;
    // begin
    //     Company.Get(CompanyName);
    //     if (CompanyName = 'Escrow') then begin
    //         GenJnlLine."Case Number" := PurchHeader."Case Number";
    //         GenJnlLine.Modify();
    //     end;
    // end;
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInsertDtldVendLedgEntry', '', true, true)]
    // procedure AddCaseNoToDtldVendLedgEntry(var DtldVendLedgEntry: Record "Detailed Vendor Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer"; Offset: Integer);
    // var
    //     Company: Record Company;
    // begin
    //     Company.Get(CompanyName);
    //     if (CompanyName = 'Escrow') then begin
    //         Dialog.Message('OnAfterInsertDtl ' + GenJournalLine."Case Number");
    //         DtldVendLedgEntry."Case Number" := GenJournalLine."Case Number";
    //         DtldVendLedgEntry.Modify();
    //     end;
    // end;
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInitGLEntry', '', true, true)]
    procedure AddCaseNumberToGLEntry(var GLEntry: Record "G/L Entry";
    GenJournalLine: Record "Gen. Journal Line");
    var Company: Record Company;
    begin
        GLEntry."Client Name":=GenJournalLine."Client Name";
        GLEntry."Deposit Detail":=GenJournalLine."Deposit Detail";
        GLEntry."FileVine Project ID":=GenJournalLine."FileVine Project ID";
        Company.Get(CompanyName);
        if(CompanyName = 'Escrow')then begin
            GLEntry."Case Number":=GenJournalLine."Case Number";
        end;
    end;
    //Subscribe to the posting process and insert the Case Number into the PostedDepositLine.
    //Actual insert gets done in the base event call.
    //THIS IS ONLY FOR MANUAL CHECKS
    [EventSubscriber(ObjectType::Table, Database::"Check Ledger Entry", 'OnAfterCopyFromBankAccLedgEntry', '', true, true)]
    procedure AddCaseNumberToCheckLedgerEntry(var CheckLedgerEntry: Record "Check Ledger Entry";
    BankAccountLedgerEntry: Record "Bank Account Ledger Entry");
    var Company: Record Company;
    begin
        Company.Get(CompanyName);
        if(CompanyName = 'Escrow')then begin
            CheckLedgerEntry."Case Number":=BankAccountLedgerEntry."Case Number";
        end;
    end;
    //Subscribes to the OnBeforeInsert of the Check Ledger Entry.
    //Uses the "Record ID to Print" to go back to the Gen. Journal Line and get the case number 
    [EventSubscriber(ObjectType::Table, Database::"Check Ledger Entry", 'OnBeforeInsertEvent', '', true, true)]
    procedure AfterInsertCheckLedger(VAR Rec: Record "Check Ledger Entry";
    RunTrigger: Boolean)var GenJnlLine: Record "Gen. Journal Line";
    Company: Record Company;
    begin
        Company.Get(CompanyName);
        if(CompanyName = 'Escrow')then begin
            //Checks if we can find the GenJnlLine.  
            //There isn't a reason we shouldn't be able to find it but put it in an if statment just in case.
            //TODO: Should we error it out?
            if GenJnlLine.Get(Rec."Record ID to Print")then begin
                Rec."Case Number":=GenJnlLine."Case Number";
            end
            else
            begin
                Message('Could not find assocaited General Journal Line.');
            end;
        end;
    end;
    //Fire subscriber to company change
    // [EventSubscriber(ObjectType::Page, Page::"My Settings", 'OnCompanyChange', '', true, true)]
    // procedure fireSubscriberToCompanyChange(NewCompanyName: Text)
    // var
    //     integrationEvent: Codeunit AAAIntegrationEvent;
    //     session: SessionSettings;
    // begin
    //     Message(NewCompanyName);
    //     integrationEvent.fireSubscriber();
    //     session.RequestSessionUpdate(true);
    // end;
    //TODO DO NOT DELETE THIS. Will need later
    [EventSubscriber(ObjectType::Page, Page::"My Settings", 'OnCompanyChange', '', true, true)]
    procedure toggleEscrowManagerApplicationArea(NewCompanyName: Text)var Rec: Record Company;
    Name: text;
    enableEscrowManager: Codeunit "Enable Escrow Extension";
    AppAreaRec: Record "Application Area Setup";
    enableAccountsPayable: Codeunit AccountsPayableAppArea;
    //Company Name='',Profile ID='',User ID=''
    begin
    // enableEscrowManager.IsEscrowApplicationAreaEnabled();
    // enableEscrowManager.EnableEscrowExtension();
    //Enable EscrowApplication Area in escrow manager
    // AppAreaRec.SetFilter(EscrowApplication, 'false');
    // AppAreaRec.SetFilter("Company Name", 'Escrow');
    // AppAreaRec.FindLast();
    // AppAreaRec.EscrowApplication := true;
    // Message(Format(AppAreaRec.EscrowApplication));
    // AppAreaRec.Modify();
    //Enable AccountsPayable Application Area in AP
    // AppAreaRec.SetFilter(AccountsPayable, 'false');
    // AppAreaRec.SetFilter("Company Name", 'Accounts Payable');
    // AppAreaRec.FindLast();
    // AppAreaRec.AccountsPayable := true;
    // Message(Format(AppAreaRec.AccountsPayable));
    // AppAreaRec.Modify();
    //Disable AccountsPayable Application
    // AppAreaRec.SetFilter(AccountsPayable, 'true');
    // AppAreaRec.SetFilter("Company Name", 'Escrow');
    // AppAreaRec.FindLast();
    // AppAreaRec.AccountsPayable := false;
    // Message(Format(AppAreaRec.AccountsPayable));
    // AppAreaRec.Modify();
    // Rec.Get(NewCompanyName);
    // if (Rec.Name = 'Escrow') then begin
    //     Message(NewCompanyName);
    //     if (enableEscrowManager.IsEscrowApplicationAreaEnabled() = false) then begin
    //         Message('it was false');
    //         enableEscrowManager.EnableEscrowExtension();
    //     end;
    // end
    // else
    //     if (Rec.Name = 'Accounts Payable') then begin
    //         if (EnableAccountsPayable.IsAccountsPayableAreaEnabled()) then begin
    //             Message('accounts payable false');
    //             enableAccountsPayable.EnableAccountsPayable();
    //         end
    //     end;
    end;
/*
        [EventSubscriber(ObjectType::Codeunit, Codeunit::CheckManagement, 'OnAfterFinancialVoidCheck', '', true, true)]
        procedure updateVoidDate(var CheckLedgerEntry: Record "Check Ledger Entry")
        var
            GenJnlLine: Record "Gen. Journal Line";
            entrtynumber: Integer;
        begin
            GenJnlLine.SetFilter("Document No.", CheckLedgerEntry."Document No.");
            //GenJnlLine.SetFilter(Description, 'Voiding check*');
            entrtynumber := GenJnlLine.GetRangeMax("Line No.");
            message('This is the entyrnumber/line no = ' + format(entrtynumber));
            GenJnlLine.Reset();
            GenJnlLine.get(entrtynumber);
            message('This is the Posting Date = ' + format(GenJnlLine."Posting Date"));
            CheckLedgerEntry."Void Date" := GenJnlLine."Posting Date";
        end;
            */
/*
            [EventSubscriber(ObjectType::Codeunit, Codeunit::CheckManagement, 'OnAfterVoidCheck', '', true, true)]
            procedure addVoidDatetoCheckLEdger(var GenJnlLine: Record "Gen. Journal Line"; var CheckLedgerEntry: Record "Check Ledger Entry")
            begin
                CheckLedgerEntry."Void Date" := GenJnlLine."Posting Date";

            end;

            */
/*
            [EventSubscriber(ObjectType::Codeunit, Codeunit::CheckManagement, 'OnFinancialVoidCheckOnBeforePostBalAccLine', '', true, true)]
            procedure addFinanacialVoidDatetoCheckLEdgerPost(var GenJournalLine: Record "Gen. Journal Line"; CheckLedgerEntry: Record "Check Ledger Entry")
            begin
                message('Inside OnFinancialVoidCheckOnBeforePostBalAccLine subscriber');
                CheckLedgerEntry."Void Date" := GenJournalLine."Posting Date";
            end;

        [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnPostBankAccOnAfterCheckLedgEntryInsert', '', true, true)]
        procedure updateVoidDate(var CheckLedgerEntry: Record "Check Ledger Entry"; var BankAccountLedgerEntry: Record "Bank Account Ledger Entry"; var GenJournalLine: Record "Gen. Journal Line"; BankAccount: Record "Bank Account")
        begin
            Message('Inside OnPostBankAccOnAfterCheckLedgEntryInsert Subscriber ');
            if (CheckLedgerEntry."Entry Status" = CheckLedgerEntry."Entry Status"::"Financially Voided") then begin
                CheckLedgerEntry."Void Date" := BankAccountLedgerEntry."Posting Date";
            end
            else
                if (CheckLedgerEntry."Entry Status" = CheckLedgerEntry."Entry Status"::"Voided") then begin
                    CheckLedgerEntry."Void Date" := BankAccountLedgerEntry."Posting Date";
                end;

        end;
     */
/*
        [EventSubscriber(ObjectType::page, page::"General Journal", 'OnOpenPageEvent', '', true, true)]
        procedure AfterRecordTransferAction(var Rec: Record "Gen. Journal Line")
        //var
        Begin
            Rec."Document No." := 'Transfer';
        End;


        [EventSubscriber(ObjectType::page, page::"Deposit", 'OnOpenPageEvent', '', true, true)]
        procedure AfterDepositPageOpen(var Rec: Record "Deposit Header")
        //var
        Begin
            Rec."No." := '20200402-1';
        End;

            [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterSetupNewLine', '', true, true)]
            procedure AfterSetUpNewLineDOcNo(var GenJournalLine: Record "Gen. Journal Line"; GenJournalTemplate: Record "Gen. Journal Template"; GenJournalBatch: Record "Gen. Journal Batch"; LastGenJournalLine: Record "Gen. Journal Line"; Balance: Decimal; BottomLine: Boolean)
            Begin
                if (GenJournalTemplate.Type = GenJournalTemplate.Type::Deposits)
                then begin
                end
                else begin
                    GenJournalLine."Document No." := '';
                end;

            End;
        */
//[EventSubscriber(ObjectType::Page, page::Deposit,'OnBeforeActionEvent',)]
// [EventSubscriber(ObjectType::page, page::"Escrow Manager Role Center", 'OnAfterActionEvent', 'Transfer Funds', true, true)]
// procedure AfterTransferAction()
// var
//     //     GLItem: Record "Gen. Journal Line";
//     //     exsitingGLItem: Record "Gen. Journal Line";
//     //     newLineNumber: Integer;
//     // Begin
//     //     exsitingGLItem.SetFilter("Journal Template Name", 'GENERAL');
//     //     exsitingGLItem.SetFilter("Journal Batch Name", 'DEFAULT');
//     //     //Finds the last line item and gets the line number.
//     //     //If no record exsits set the line item to 0
//     //     if exsitingGLItem.FindLast then
//     //         newLineNumber := exsitingGLItem."Line No." + 1
//     //     else
//     //         newLineNumber := 0;
//     //     GLItem.Init();
//     //     GLItem."Posting Date" := System.Today;
//     //     GLItem."Document No." := 'Transfer';
//     //     GLItem."Journal Template Name" := 'GENERAL';
//     //     GLItem."Journal Batch Name" := 'DEFAULT';
//     //     GLItem."Line No." := newLineNumber;
//     //     GLItem.Insert(true);
//     GLItem: Record "Gen. Journal Line";
// begin
//     GLItem."Document No." := 'TRANSFER';
//     PAGE.Run(PAGE::"General Journal");
// End;
// [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line",
// 'OnAfterSetupNewLine', '', true, true)]
// procedure AfterNewLineSetupPaymentJournal(var GenJournalLine: Record "Gen. Journal Line"; GenJournalTemplate: Record "Gen. Journal Template"; GenJournalBatch: Record "Gen. Journal Batch";
// LastGenJournalLine: Record "Gen. Journal Line"; Balance: Decimal; BottomLine: Boolean)
// begin
//     GenJournalLine."Case Number" := LastGenJournalLine."Case Number";
//     GenJournalLine."Client Name" := LastGenJournalLine."Client Name";
// end;
}
