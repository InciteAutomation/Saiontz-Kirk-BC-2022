query 50125 "GL Amount List"
{
    Caption = 'GL Amount List';

    elements
    {
    dataitem(G_L_Account;
    "G/L Account")
    {
    column(GL_Account_No;
    "No.")
    {
    }
    column(Name;
    Name)
    {
    }
    column(Account_Type;
    "Account Type")
    {
    ColumnFilter = Account_Type=CONST(Posting);
    }
    column(Debit_Credit;
    "Debit/Credit")
    {
    }
    column(Account_Category;
    "Account Category")
    {
    }
    dataitem(G_L_Entry;
    "G/L Entry")
    {
    DataItemLink = "G/L Account No."=G_L_Account."No.";

    //DataItemTableFilter = "Document No." = filter('NC');
    column(Posting_Date;
    "Posting Date")
    {
    }
    column(Amount;
    Amount)
    {
    }
    column(Entry_No;
    "Entry No.")
    {
    }
    column(Document_No;
    "Document No.")
    {
    //ColumnFilter = Document_No = filter(StartsWith(Document_No, 'NC'));
    }
    }
    }
    }
}
