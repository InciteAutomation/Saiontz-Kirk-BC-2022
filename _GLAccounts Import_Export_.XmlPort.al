xmlport 50178 "GLAccounts Import/Export"
{
    Caption = 'GLAccounts Import/Export';
    //Encoding = UTF8;
    //FormatEvaluate = Xml;
    TextEncoding = UTF8;
    Format = VariableText;
    DefaultFieldsValidation = false;

    schema
    {
    textelement(GLAccounts)
    {
    tableelement(GLASet;
    "G/L Account")
    {
    AutoUpdate = true;

    //Line Number in SQL
    fieldattribute(No;
    GLASet."No.")
    {
    }
    fieldattribute(Name;
    GLASet.Name)
    {
    }
    fieldattribute(IncomeBalance;
    GLASet."Income/Balance")
    {
    }
    fieldattribute(AccountCategory;
    GLASet."Account Category")
    {
    }
    fieldattribute(Subcategory;
    GLASet."Account Subcategory Descript.")
    {
    }
    fieldattribute(AccountType;
    GLASet."Account Type")
    {
    }
    }
    }
    }
}
