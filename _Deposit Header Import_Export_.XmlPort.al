xmlport 50153 "Deposit Header Import/Export"
{
    caption = 'Posted Deposit Header Import/Export';
    Encoding = UTF8;
    FormatEvaluate = Xml;

    schema
    {
    textelement(DepositHeaders)
    {
    tableelement(DHSet;
    "Deposit Header")
    {
    AutoUpdate = true;
    //XmlName = 'PaymentLine';
    RequestFilterFields = "Journal Template Name", "Journal Batch Name";

    fieldattribute("JournalTemplateName";
    DHSet."Journal Template Name")
    {
    }
    fieldattribute("JournalBatchName";
    DHSet."Journal Batch Name")
    {
    }
    fieldattribute("No";
    DHSet."No.")
    {
    }
    fieldattribute("BankAccountNo";
    DHSet."Bank Account No.")
    {
    }
    fieldattribute("PostingDate";
    DHSet."Posting Date")
    {
    }
    fieldattribute("DocumentDate";
    DHSet."Document Date")
    {
    }
    fieldattribute("TotalDepositAmount";
    DHSet."Total Deposit Amount")
    {
    }
    trigger OnBeforeInsertRecord()var //PaymentLine: Record "Deposit Header";
    begin
        //LastLineNumber += 10000;
        // PaymentLine.SetRange("Journal Template Name", PaymentLine."Journal Template Name", 'DEPOSITS');
        //PaymentLine.SetRange("Journal Batch Name", PaymentLine."Journal Batch Name", 'CHECKINGS');
        //DHSet.SetRange("Journal Template Name", DHSet."Journal Template Name", 'DEPOSITS');
        //DHSet.SetRange("Journal Batch Name", DHSet."Journal Batch Name", 'CHECKINGS');
        DHSet.SetFilter("Journal Template Name", 'DEPOSITS');
        DHSet.SetFilter("Journal Batch Name", DHSet."Journal Batch Name");
    //DHSet."Journal Batch Name" := 'CHECKINGS';
    //DHSet."Journal Template Name" := 'DEPOSITS';
    end;
    }
    //           tableelement(DHSet; "Posted Deposit Header")
    //{
    // fieldattribute("No"; DHSet."No.") { }
    //fieldattribute("BankAccountNo"; DHSet."Bank Account No.") { }
    //fieldattribute("PostingDate"; DHSet."Posting Date") { }
    //fieldattribute("DocumentDate"; DHSet."Document Date") { }
    //fieldattribute("TotalDepositAmount"; DHSet."Total Deposit Amount") { }
    //}
    }
    }
//procedure SetJournalTemplateBatch(Template: Code[20]; Batch: Code[20])
//begin
//  JournalTemplate := Template;
// JournalBatch := Batch;
//end;
//trigger OnPreXMLPort()
//begin
//end;
//var
//  JournalTemplate: Code[20];
//var
//  JournalBatch: Code[20];
//var
//LastLineNumber: Integer;
}
