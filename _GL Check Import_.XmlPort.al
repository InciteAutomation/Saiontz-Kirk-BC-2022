xmlport 50162 "GL Check Import"
{
    Caption = 'GL Check Import';
    //Encoding = UTF8;
    //FormatEvaluate = Xml;
    TextEncoding = UTF8;
    Format = VariableText;

    schema
    {
    textelement(GLEntries)
    {
    tableelement("GLEntry";
    "G/L Entry")
    {
    AutoUpdate = true;

    fieldattribute("EntryNo";
    GLEntry."Entry No.")
    {
    }
    fieldattribute("AccountNumber";
    GLEntry."G/L Account No.")
    {
    }
    fieldattribute("PostingDate";
    GLEntry."Posting Date")
    {
    }
    fieldattribute("DocumentType";
    GLEntry."Document Type")
    {
    }
    fieldattribute("TransactionNumber";
    GLEntry."Transaction No.")
    {
    }
    fieldattribute("BalAccountType";
    GLEntry."Bal. Account Type")
    {
    }
    fieldattribute("BalAccountNumber";
    GLEntry."Bal. Account No.")
    {
    }
    fieldattribute("Amount";
    GLEntry.Amount)
    {
    }
    fieldattribute("JournalBatchName";
    GLEntry."Journal Batch Name")
    {
    }
    fieldattribute("DocumentNumber";
    GLEntry."Document No.")
    {
    }
    fieldattribute("DocumentDate";
    GLEntry."Document Date")
    {
    }
    fieldattribute("CaseNumber";
    GLEntry."Case Number")
    {
    }
    fieldattribute("Dimension";
    GLEntry."Global Dimension 2 Code")
    {
    }
    //fieldattribute("SourceCode"; GLEntry."Source Code") { }
    //fieldattribute("DebitAmount"; GLEntry."Debit Amount") { }
    //fieldattribute("CreditAmount"; GLEntry."Credit Amount") { }
    //fieldattribute("ExternalDocumentNo"; GLEntry."External Document No.") { }
    //fieldattribute("SourceType"; GLEntry."Source Type") { }
    //fieldattribute("TaxLiable"; GLEntry."Tax Liable") { }
    //fieldattribute("TaxGroupCode"; GLEntry."Tax Group Code") { }
    //trigger OnBeforeInsertRecord()
    //var
    //PaymentLine: Record "Deposit Header";
    //begin
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
    //end;
    }
    }
    }
}
