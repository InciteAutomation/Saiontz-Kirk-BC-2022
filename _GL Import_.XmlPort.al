xmlport 50159 "GL Import"
{
    Caption = 'GL Import';
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
    fieldattribute("DocumentNumber";
    GLEntry."Document No.")
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
    fieldattribute("SourceCode";
    GLEntry."Source Code")
    {
    }
    fieldattribute("JournalBatchName";
    GLEntry."Journal Batch Name")
    {
    }
    fieldattribute("BalAccountType";
    GLEntry."Bal. Account Type")
    {
    }
    fieldattribute("TransactionNumber";
    GLEntry."Transaction No.")
    {
    }
    //fieldattribute("DebitAmount"; GLEntry."Debit Amount") { }
    //fieldattribute("CreditAmount"; GLEntry."Credit Amount") { }
    fieldattribute("DocumentDate";
    GLEntry."Document Date")
    {
    }
    fieldattribute("ExternalDocumentNo";
    GLEntry."External Document No.")
    {
    }
    //fieldattribute("TaxLiable"; GLEntry."Tax Liable") { }
    //fieldattribute("TaxGroupCode"; GLEntry."Tax Group Code") { }
    fieldattribute("CaseNumber";
    GLEntry."Case Number")
    {
    }
    fieldattribute("Dimension";
    GLEntry."Global Dimension 1 Code")
    {
    }
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
