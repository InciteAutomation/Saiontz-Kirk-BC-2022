codeunit 50135 CasesInstallCode
{
    Subtype = Install;

    trigger OnInstallAppPerCompany();
    var EA: Record EscrowAccounts;
    PDH: Record "Posted Deposit Header";
    PDL: Record "Posted Deposit Line";
    GLL: Record "Gen. Journal Line";
    CLE: Record "Check Ledger Entry";
    GLE: Record "G/L Entry";
    BLA: Record "Bank Account Ledger Entry";
    VLE: Record "Vendor Ledger Entry";
    BLE: Record "Bank Account Ledger Entry";
    DVL: Record "Detailed Vendor Ledg. Entry";
    VE: Record Vendor;
    CT: Record Contact;
    EnableApplicationArea: Codeunit "Enable Escrow Extension";
    begin
        if(CompanyName = 'Escrow Manager Full Import') OR (CompanyName = 'SK - Escrow')//if (CompanyName = 'SK - Escrow')
        //if (CompanyName = 'Escrow Manager Full Import')
        //OR (CompanyName = 'SK - Escrow')
        //if CompanyName = 'SK - Escrow'
        then begin
            if(EnableApplicationArea.IsEscrowApplicationAreaEnabled())then exit;
            EnableApplicationArea.EnableEscrowExtension();
        end;
        //EA.DeleteAll();
        //PDH.DeleteAll();
        //PDL.DeleteAll();
        //GLL.DeleteAll();
        //CLE.DeleteAll();
        //GLE.DeleteAll();
        //VLE.DeleteAll();
        //BLE.DeleteAll();
        //DVL.DeleteAll();
        //BLA.DeleteAll();
        //VE.DeleteAll();
        //CT.DeleteAll();
        EA.SetAutoCalcFields("Total Deposits ($)", "Total Checks ($)", "Total Transfers In ($)", "Total Transfers Out ($)", "Total Purchase Invoices ($)");
    //cle.SetAutoCalcFields(VoidDate);
    //VE.SetAutoCalcFields("Balance (LCY)", "Balance Due (LCY)", Payments, Refunds);
    //InsertTestCase();
    end;
    procedure InsertTestCase();
    begin
        InsertCase('001', 'John Doe', 20191114D, 'Auto Accident', '12345', '12345', 'www.filevine.com', false);
        InsertCase('002', 'Jane Smith', 20191114D, 'Medical Malpractice', '54321', '54321', 'www.filevine.com', false);
    end;
    procedure InsertCase(ID: Code[30];
    clientName: Text[250];
    incidentDate: Date;
    caseType: Text[250];
    caseReference: Text[250];
    clientReference: Text[250];
    filevineURL: Text[500];
    archived: Boolean)var newCase: Record EscrowAccounts;
    begin
        newCase.Init();
        newCase."Case Number":=ID;
        newCase."Client Name":=clientName;
        newCase."Date of Incident":=incidentDate;
        newCase."Case Type":=caseType;
        newCase."Filevine Email":=caseReference;
        newCase."Client Reference":=clientReference;
        newCase."Filevine URL":=filevineURL;
        newCase."Escrow Account Archive":=archived;
        newCase.Insert();
    end;
    //TODO: DELETE THIS
    procedure InstallBankAccounts();
    begin
        InsertBank()end;
    procedure InsertBank()begin
    end;
}
