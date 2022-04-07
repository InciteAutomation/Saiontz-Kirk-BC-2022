xmlport 50154 "Deposit Line Import/Export"
{
    caption = 'Posted Deposit Line Import/Export';
    Encoding = UTF8;
    FormatEvaluate = Xml;

    schema
    {
    textelement(DepositLines)
    {
    tableelement(DLSet;
    "Gen. Journal Line")
    {
    fieldattribute("TemplateName";
    DLSet."Journal Template Name")
    {
    }
    fieldattribute("JournalBatchName";
    DLSet."Journal Batch Name")
    {
    }
    fieldattribute("BalanceAccountType";
    DLSet."Bal. Account Type")
    {
    }
    fieldattribute("BalanceAccountNumber";
    DLSet."Bal. Account No.")
    {
    }
    fieldattribute("ExternalDocumentNumber";
    DLSet."External Document No.")
    {
    }
    fieldattribute("DueDate";
    DLSet."Due Date")
    {
    }
    fieldattribute("PostingDate";
    DLSet."Posting Date")
    {
    }
    fieldattribute("CaseNumber";
    DLSet."Case Number")
    {
    }
    fieldattribute("DepositDetail";
    DLSet."Deposit Detail")
    {
    }
    fieldattribute("CreditAmount";
    DLSet."Credit Amount")
    {
    }
    fieldattribute("TransactionTypeCode";
    DLSet."Transaction Type Code")
    {
    }
    }
    }
    }
}
