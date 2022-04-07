xmlport 50164 "Bank Account Ledger Entry"
{
    Caption = 'Bank Account Ledger Entry';
    //Encoding = UTF8;
    //FormatEvaluate = Xml;
    TextEncoding = UTF8;
    Format = VariableText;

    schema
    {
    textelement(BLEntries)
    {
    tableelement("BLEntry";
    "Bank Account Ledger Entry")
    {
    AutoUpdate = true;

    fieldattribute("EntryNo";
    BLEntry."Entry No.")
    {
    }
    fieldattribute("BankAccountNumber";
    BLEntry."Bank Account No.")
    {
    }
    fieldattribute("PostingDate";
    BLEntry."Posting Date")
    {
    }
    //fieldattribute("DocumentType"; BLEntry."Document Type") { }
    fieldattribute("DocumentNumber";
    BLEntry."Document No.")
    {
    }
    fieldattribute("Amount";
    BLEntry.Amount)
    {
    }
    fieldattribute("JournalBatchName";
    BLEntry."Journal Batch Name")
    {
    }
    fieldattribute("BalanceAccountType";
    BLEntry."Bal. Account Type")
    {
    }
    fieldattribute("BalAccountNumber";
    BLEntry."Bal. Account No.")
    {
    }
    fieldattribute("TransactionNumber";
    BLEntry."Transaction No.")
    {
    }
    fieldattribute("DocumentDate";
    BLEntry."Document Date")
    {
    }
    fieldattribute("CaseNumber";
    BLEntry."Case Number")
    {
    }
    fieldattribute("Dimension";
    BLEntry."Global Dimension 2 Code")
    {
    }
    //fieldattribute("SourceCode"; GLEntry."Source Code") { }
    //fieldattribute("ExternalDocumentNo"; GLEntry."External Document No.") { }
    //fieldattribute("SourceType"; GLEntry."Source Type") { }
    //fieldattribute("TaxLiable"; GLEntry."Tax Liable") { }
    //fieldattribute("TaxGroupCode"; GLEntry."Tax Group Code") { }
    trigger OnBeforeInsertRecord()var //PaymentLine: Record "Deposit Header";
    begin
    //LastLineNumber += 10000;
    // PaymentLine.SetRange("Journal Template Name", PaymentLine."Journal Template Name", 'DEPOSITS');
    //PaymentLine.SetRange("Journal Batch Name", PaymentLine."Journal Batch Name", 'CHECKINGS');
    //GenBatch.SetRange("Journal Template Name", GenBatch."Journal Template Name", 'DEPOSITS');
    //DHSet.SetRange("Journal Batch Name", DHSet."Journal Batch Name", 'CHECKINGS');
    //GenBatch.SetFilter("Journal Template Name"), 'DEPOSITS');
    //DHSet.SetFilter("Journal Batch Name", DHSet."Journal Batch Name");
    //GenBatch."Journal Template Name" := 'DEPOSITS';
    //DHSet."Journal Batch Name" := 'CHECKINGS';
    //DHSet."Journal Template Name" := 'DEPOSITS';
    end;
    }
    }
    }
}
