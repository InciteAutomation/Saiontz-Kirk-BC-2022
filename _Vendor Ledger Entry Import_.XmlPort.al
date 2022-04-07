xmlport 50163 "Vendor Ledger Entry Import"
{
    Caption = 'Vendor Ledger Entry';
    //Encoding = UTF8;
    //FormatEvaluate = Xml;
    TextEncoding = UTF8;
    Format = VariableText;

    schema
    {
    textelement(VLEntries)
    {
    tableelement("VLEntry";
    "Vendor Ledger Entry")
    {
    AutoUpdate = true;

    fieldattribute("EntryNo";
    VLEntry."Entry No.")
    {
    }
    fieldattribute("VendorNo";
    VLEntry."Vendor No.")
    {
    }
    fieldattribute("PostingDate";
    VLEntry."Posting Date")
    {
    }
    fieldattribute("DocumentType";
    VLEntry."Document Type")
    {
    }
    fieldattribute("DocumentNumber";
    VLEntry."Document No.")
    {
    }
    fieldattribute("Open";
    VLEntry.Open)
    {
    }
    fieldattribute("DueDate";
    VLEntry."Due Date")
    {
    }
    //fieldattribute("JournalBatchName"; VLEntry."Journal Batch Name") { }
    fieldattribute("BalanceAccountType";
    VLEntry."Bal. Account Type")
    {
    }
    fieldattribute("BalAccountNumber";
    VLEntry."Bal. Account No.")
    {
    }
    fieldattribute("TransactionNumber";
    VLEntry."Transaction No.")
    {
    }
    //fieldattribute("JournalBatchName"; VLEntry."Journal Batch Name") { }
    fieldattribute("DocumentDate";
    VLEntry."Document Date")
    {
    }
    fieldattribute("PaymentMethodCode";
    VLEntry."Payment Method Code")
    {
    }
    //fieldattribute("SourceCode"; GLEntry."Source Code") { }
    fieldattribute("CaseNumber";
    VLEntry."Case Number")
    {
    }
    fieldattribute(Dimension;
    VLEntry."Global Dimension 2 Code")
    {
    }
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
    //VLEntry.SetFilter(Open, '%1', TRUE);
    //VLEntry.SetRange(VLEntry.Open, true);
    //VLEntry.SetFilter(VLEntry.Open, '%1', true);
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
