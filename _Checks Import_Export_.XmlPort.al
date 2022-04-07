xmlport 50155 "Checks Import/Export"
{
    Caption = 'Checks Import/Export';
    //Encoding = UTF8;
    //FormatEvaluate = Xml;
    TextEncoding = UTF8;
    Format = VariableText;

    schema
    {
    textelement(Checks)
    {
    tableelement(CSet;
    "Check Ledger Entry")
    {
    AutoUpdate = true;

    //Line Number in SQL
    fieldattribute(EntryNo;
    CSet."Entry No.")
    {
    }
    fieldattribute(BankAccountNo;
    CSet."Bank Account No.")
    {
    }
    //fieldattribute(BankLedgerEntryNo; CSet."Bank Account Ledger Entry No.") { }
    fieldattribute(PostingDate;
    CSet."Posting Date")
    {
    }
    fieldattribute(DocType;
    CSet."Document Type")
    {
    }
    fieldattribute(DocNo;
    CSet."Document No.")
    {
    }
    fieldattribute(Amount;
    CSet.Amount)
    {
    }
    fieldattribute(CheckDate;
    CSet."Check Date")
    {
    }
    fieldattribute(CheckNo;
    CSet."Check No.")
    {
    }
    fieldattribute(CheckType;
    CSet."Check Type")
    {
    }
    fieldattribute(BankPaymentType;
    CSet."Bank Payment Type")
    {
    }
    fieldattribute(EntryStatus;
    CSet."Entry Status")
    {
    }
    fieldattribute(BalAccountType;
    CSet."Bal. Account Type")
    {
    }
    fieldattribute(BalAccountNo;
    CSet."Bal. Account No.")
    {
    }
    fieldattribute(CaseNumber;
    CSet."Case Number")
    {
    }
    fieldattribute(Description;
    CSet.Description)
    {
    }
    fieldattribute(Dimension;
    CSet."Global Dimension 2 Code")
    {
    }
    }
    }
    }
}
