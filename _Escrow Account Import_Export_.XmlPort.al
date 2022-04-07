xmlport 50152 "Escrow Account Import/Export"
{
    Caption = 'Escrow Account Import/Export';
    //Encoding = UTF8;
    //FormatEvaluate = Xml;
    TextEncoding = UTF8;
    Format = VariableText;

    schema
    {
    textelement(EscrowAccounts)
    {
    tableelement(EASet;
    EscrowAccounts)
    {
    fieldattribute(CaseNumber;
    EASet."Case Number")
    {
    }
    fieldattribute(FilevineID;
    EASet."Filevine ID")
    {
    }
    fieldattribute(ClientName;
    EASet."Client Name")
    {
    }
    fieldattribute(DateOfIncident;
    EASet."Date of Incident")
    {
    }
    fieldattribute(CaseType;
    EASet."Case Type")
    {
    }
    fieldattribute(CaseReference;
    EASet."Filevine Email")
    {
    }
    fieldattribute(ClientReference;
    EASet."Client Reference")
    {
    }
    //fieldattribute(FilevineURL; EASet."Filevine URL") { FieldValidate = Yes;}
    fieldattribute(FilevineURL;
    EASet."Filevine URL")
    {
    }
    fieldattribute(Archived;
    EASet."Escrow Account Archive")
    {
    }
    }
    }
    }
}
