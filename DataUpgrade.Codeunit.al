codeunit 50111 DataUpgrade
{
    Permissions = TableData "Posted Deposit Line"=rimd;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"InitDataUpgrade", 'InitDataUpgrade', '', true, true)]
    procedure DataUpgrade()var Company: Record Company;
    PDL: Record "Posted Deposit Line";
    Escrow: Record EscrowAccounts;
    counter: Integer;
    entryNo: Integer;
    textEntryNo: Text;
    BankAccountNo: Integer;
    textBankAccountNo: Text;
    begin
        Company.Get(CompanyName);
        Message('started to run');
        if(CompanyName = 'Escrow')then begin
            BankAccountNo:=2;
            entryNo:=1;
            counter:=1;
            Message('running');
            repeat textBankAccountNo:=Format(BankAccountNo);
                textEntryNo:=Format(entryNo);
                PDL.SetFilter("Entry No.", textEntryNo);
                PDL.SetFilter("Bank Account Ledger Entry No.", textBankAccountNo);
                IF PDL.FindLast()then begin
                    PDL.FindLast();
                    IF Text.StrLen(PDL."Client Name") <= 0 then begin
                        escrow.SetFilter("Case Number", PDL."Case Number");
                        escrow.FindLast();
                        PDL."Client Name":=escrow."Client Name";
                        PDL.Modify();
                    end;
                    counter:=counter + 1;
                    BankAccountNo:=BankAccountNo + 2;
                    entryNo:=entryNo + 2;
                end;
            until counter = 5000;
            Message('counted to 5000');
        end;
    end;
//  trigger OnValidateUpgradePerCompany();
//  var
//      Company: Record Company;
//      PDL: Record "Posted Deposit Line";
//  begin
//      Company.Get(CompanyName);
//      if (CompanyName = 'Escrow') then begin
//          PDL.SetRange("Client Name", '')
//          if not pdl.IsEmpty then
//              error('There are still pdl records in escrow without client names associated.')
//      end;
//  end;
}
