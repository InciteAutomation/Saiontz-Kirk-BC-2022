xmlport 50158 "Batches Import/Export"
{
    Caption = 'Batches Account Import/Export';
    Encoding = UTF8;
    FormatEvaluate = Xml;

    schema
    {
    textelement(Batches)
    {
    tableelement("GenBatch";
    "Gen. Journal Batch")
    {
    fieldattribute("Name";
    GenBatch.Name)
    {
    }
    fieldattribute("BalAccountType";
    GenBatch."Bal. Account Type")
    {
    }
    fieldattribute("BalAccountNumber";
    GenBatch."Bal. Account No.")
    {
    }
    fieldattribute("TemplateName";
    GenBatch."Journal Template Name")
    {
    }
    trigger OnBeforeInsertRecord()var //PaymentLine: Record "Deposit Header";
    begin
        //LastLineNumber += 10000;
        // PaymentLine.SetRange("Journal Template Name", PaymentLine."Journal Template Name", 'DEPOSITS');
        //PaymentLine.SetRange("Journal Batch Name", PaymentLine."Journal Batch Name", 'CHECKINGS');
        GenBatch.SetRange("Journal Template Name", GenBatch."Journal Template Name", 'DEPOSITS');
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
