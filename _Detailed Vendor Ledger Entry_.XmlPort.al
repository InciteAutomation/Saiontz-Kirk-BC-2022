xmlport 50165 "Detailed Vendor Ledger Entry"
{
    Caption = 'Detailed Vendor Ledger Entry';
    //Encoding = UTF8;
    //FormatEvaluate = Xml;
    TextEncoding = UTF8;
    Format = VariableText;

    schema
    {
    textelement(DVLEntries)
    {
    tableelement("DVLEntry";
    "Detailed Vendor Ledg. Entry")
    {
    AutoUpdate = true;

    fieldattribute("EntryNo";
    DVLEntry."Entry No.")
    {
    }
    fieldattribute("VendorLedgerEntryNo";
    DVLEntry."Vendor Ledger Entry No.")
    {
    }
    fieldattribute("EntryType";
    DVLEntry."Entry Type")
    {
    }
    fieldattribute("PostingDate";
    DVLEntry."Posting Date")
    {
    }
    fieldattribute("DocumentType";
    DVLEntry."Document Type")
    {
    }
    fieldattribute("DocumentNo";
    DVLEntry."Document No.")
    {
    }
    fieldattribute("Amount";
    DVLEntry.Amount)
    {
    }
    fieldattribute("VendorNo";
    DVLEntry."Vendor No.")
    {
    }
    fieldattribute("TransactionNumber";
    DVLEntry."Transaction No.")
    {
    }
    fieldattribute("JournalBatchName";
    DVLEntry."Journal Batch Name")
    {
    }
    fieldattribute("IniitalDocumentType";
    DVLEntry."Initial Document Type")
    {
    }
    fieldattribute("CaseNumber";
    DVLEntry."Case Number")
    {
    }
    fieldattribute(Dimension;
    DVLEntry."Global Dimension 2 Code")
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
