xmlport 50160 "Bank Account Ledger"
{
    Caption = 'Vendors Import/Export';
    //Encoding = UTF8;
    //FormatEvaluate = Xml;
    TextEncoding = UTF8;
    Format = VariableText;
    DefaultFieldsValidation = false;

    schema
    {
    textelement(BankAccountLedgerEntries)
    {
    tableelement(BAEntry;
    "Bank Account Ledger Entry")
    {
    //Line Number in SQL
    //Hits Posted Deposit Lines
    AutoUpdate = true;

    fieldattribute("EntryNumber";
    BAEntry."Entry No.")
    {
    }
    fieldattribute("BankAccountNumber";
    BAEntry."Bank Account No.")
    {
    }
    fieldattribute("PostingDate";
    BAEntry."Posting Date")
    {
    }
    fieldattribute("DocumentNumber";
    BAEntry."Document No.")
    {
    }
    fieldattribute("Amount";
    BAEntry.Amount)
    {
    }
    //fieldattribute("BankAccPostingGroup"; BAEntry."Bank Acc. Posting Group") { }
    //fieldattribute("SourceCode"; BAEntry."Source Code") { }
    fieldattribute("JournalBatchName";
    BAEntry."Journal Batch Name")
    {
    }
    fieldattribute("BalanceAccountType";
    BAEntry."Bal. Account Type")
    {
    }
    fieldattribute("BalanceAccountNumber";
    BAEntry."Bal. Account No.")
    {
    }
    fieldattribute("TransactionNumber";
    BAEntry."Transaction No.")
    {
    }
    //fieldattribute("DebitAmount"; BAEntry."Debit Amount") { }
    fieldattribute("DocumentDate";
    BAEntry."Document Date")
    {
    }
    //fieldattribute("ExternalDocumentNumber"; BAEntry."External Document No.") { }
    fieldattribute("CaseNumber";
    BAEntry."Case Number")
    {
    }
    fieldattribute("Dimension1";
    BAEntry."Global Dimension 1 Code")
    {
    }
    }
    }
    }
}
