pageextension 50131 "Deposit Subform Extension" extends "Deposit Subform"
{
    layout
    {
        addafter("Document Date")
        {
            field("Case Number";Rec."Case Number")
            {
                Visible = escrow;
                ApplicationArea = EscrowApplication;
                lookup = true;
                //Need this in there so wee can add a new escrow account from the deposit page.
                LookupPageId = "Escrow Account Card";

                //Sets the client name based on the selected FV Number.
                trigger OnValidate()var EscrowAccount: Record EscrowAccounts;
                Company: Record Company;
                begin
                    Company.Get(CompanyName);
                    if(CompanyName = 'Escrow')then begin
                        EscrowAccount.Get(rec."Case Number");
                        Rec."Client Name":=EscrowAccount."Client Name";
                    end;
                end;
            }
            field("Client Name";Rec."Client Name")
            {
                Visible = escrow;
                Caption = 'Case Name';
                ApplicationArea = EscrowApplication;
                Editable = false;
            }
            field("Deposit Detail";Rec."Deposit Detail")
            {
                Caption = 'Memo';
                ApplicationArea = All;
            }
        }
        addafter("Amount")
        {
        }
        addafter("Credit Amount")
        {
            field("Global Dimension1";Rec."Shortcut Dimension 1 Code")
            {
                Caption = 'Deposit Type Code';
                ApplicationArea = EscrowApplication;
            }
        }
        //moveafter("Deposit Detail"; "Amount")
        moveafter("Deposit Detail";"Account No.")
        moveafter("Deposit Detail";"Account Type")
        addafter("Account No.")
        {
            field("G/L Account Name";Rec."G/L Account Name")
            {
                Caption = 'Account Name';
                Visible = true;
                ApplicationArea = All;
            }
        }
        //moveafter("Account No."; Description)
        //modify("Credit Amount") { Visible = true; }
        modify("Amount")
        {
        Caption = 'Amount';
        Visible = false;
        ApplicationArea = AccountsPayable;
        }
        modify("Account Type")
        {
        Caption = 'Balance Account';
        }
        modify("Account No.")
        {
        Caption = 'Balance #';
        }
        modify("Description")
        {
        // Caption = 'Balance Description';
        //FIXME check to see if this was the thing to uncomment
        ApplicationArea = AccountsPayable;
        //Hiddon on  10/9 per Russell Request
        Visible = false;
        }
        // modify("Document No.") { Visible = false; ApplicationArea = AccountsPayable; }
        modify("Document Type")
        {
        Visible = false;
        ApplicationArea = AccountsPayable;
        }
    }
    actions
    {
        addafter(ApplyEntries)
        {
            action(DepositImport)
            {
                Visible = false;
                ApplicationArea = All;
                Caption = 'Import Deposits';

                trigger OnAction()begin
                    RunXMLPortImport();
                end;
            }
            action(FeeDeposit)
            {
                ApplicationArea = All;
                Caption = 'Deposit Import';

                trigger OnAction()begin
                    RunFeeXMLPortImport();
                end;
            }
        }
    }
    procedure RunXMLPortImport()var FileInstream: InStream;
    FileName: Text;
    GenJnlImport: XmlPort GenJournalImport;
    begin
        UploadIntoStream('', '', '', FileName, FileInstream);
        GenJnlImport.SetJournalTemplateBatch(rec."Journal Template Name", rec."Journal Batch Name");
        GenJnlImport.SetSource(FileInstream);
        GenJnlImport.Import();
        Message('File Imported successfully.');
    end;
    procedure RunFeeXMLPortImport()var FileInstream: InStream;
    FileName: Text;
    FeeImport: XmlPort FeeDepositImport;
    depHeader: record "Deposit Header";
    GenJourLine: Record "Gen. Journal Line";
    DepositPage: Page Deposit;
    begin
        UploadIntoStream('', '', '', FileName, FileInstream);
        FeeImport.SetJournalTemplateBatch(rec."Journal Template Name", rec."Journal Batch Name");
        FeeImport.SetSource(FileInstream);
        FeeImport.Import();
        Message('File Imported successfully.');
        CurrPage.Update();
    end;
    trigger OnOpenPage()var EscrowAccount: Record EscrowAccounts;
    Company: Record Company;
    begin
        Company.Get(CompanyName);
        if(CompanyName = 'Escrow')then escrow:=true
        else
            escrow:=false;
    // Message('Case is a no show!' + format(escrow));
    end;
    var escrow: Boolean;
}
