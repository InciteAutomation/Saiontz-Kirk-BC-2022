xmlport 50157 "Payment Journal Import/Export"
{
    Caption = 'Payment Journal Import/Export';
    Encoding = UTF8;
    FormatEvaluate = Xml;

    schema
    {
    textelement(PaymentJournals)
    {
    tableelement(PJSet;
    "Gen. Journal Line")
    {
    fieldattribute(LineNumber;
    PJSet."Line No.")
    {
    }
    fieldattribute(PostingDate;
    PJSet."Posting Date")
    {
    }
    fieldattribute(DocumentDate;
    PJSet."Document Date")
    {
    }
    fieldattribute(DocumentType;
    PJSet."Document Type")
    {
    }
    fieldattribute(DocumentNumber;
    PJSet."Document No.")
    {
    }
    fieldattribute(CaseNumber;
    PJSet."Case Number")
    {
    }
    //fieldattribute(ClientName; PJSet."Client Name") { }
    fieldattribute(AccountType;
    PJSet."Account Type")
    {
    }
    fieldattribute(AccountNumber;
    PJSet."Account No.")
    {
    }
    //fieldattribute(AccountDescription; PJSet.) { }
    fieldattribute(PaymentMethodCode;
    PJSet."Payment Method Code")
    {
    }
    fieldattribute(Amount;
    PJSet.Amount)
    {
    }
    fieldattribute(BalAccountType;
    PJSet."Bal. Account Type")
    {
    }
    fieldattribute(BalAccountNumber;
    PJSet."Bal. Account No.")
    {
    }
    fieldattribute(BankPaymentType;
    PJSet."Bank Payment Type")
    {
    }
    fieldattribute(TransactionTypeCode;
    PJSet."Transaction Type Code")
    {
    }
    fieldattribute(TemplateName;
    PJSet."Journal Template Name")
    {
    }
    fieldattribute(BatchName;
    PJSet."Journal Batch Name")
    {
    }
    //fieldattribute(CheckPrinted; PJSet."Check Printed") { }
    }
    }
    }
}
