xmlport 50105 GenJournalImport
{
    Format = VariableText;

    schema
    {
    textelement(root)
    {
    tableelement(GenJnlLine;
    "Gen. Journal Line")
    {
    fieldattribute(PostingDate;
    GenJnlLine."Posting Date")
    {
    }
    fieldattribute(DocumentDate;
    GenJnlLine."Document Date")
    {
    }
    fieldelement(ProjectNo;
    GenJnlLine."Document No.")
    {
    }
    fieldelement(BalanceDesc;
    GenJnlLine."Balance Description")
    {
    }
    fieldelement(TotalDeposit;
    GenJnlLine."Credit Amount")
    {
    }
    fieldelement(Description;
    GenJnlLine."Deposit Detail")
    {
    }
    fieldelement(BalanceAccount;
    GenJnlLine."Account Type")
    {
    }
    // fieldelement(BalanceNo; GenJnlLine."Account No.")
    // {
    //     // FieldValidate = Yes;
    // }
    trigger OnBeforeInsertRecord()begin
        LastLineNo+=10000;
        GenJnlLine."Line No.":=LastLineNo;
        GenJnlLine."Journal Template Name":=JournalTemplate;
        GenJnlLine."Journal Batch Name":=JournalBatch;
    end;
    trigger OnAfterInsertRecord()begin
        GenJrnRec.Get(JournalTemplate, JournalBatch, LastLineNo);
        accountChart.SetFilter(Name, GenJrnRec."Balance Description");
        accountChart.FindLast();
        GenJrnRec."Account No.":=accountChart."No.";
        GenJrnRec.Modify();
    end;
    }
    }
    }
    // requestpage
    // {
    //     layout
    //     {
    //         area(content)
    //         {
    //             group(GroupName)
    //             {
    //             }
    //         }
    //     }
    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(ActionName)
    //             {
    //             }
    //         }
    //     }
    // }
    procedure SetJournalTemplateBatch(Template: Code[20];
    Batch: Code[20])begin
        JournalTemplate:=Template;
        JournalBatch:=Batch end;
    trigger OnPreXmlPort()begin
        GenJnlLine.Reset();
        GenJnlLine.SetRange("Journal Template Name", JournalTemplate);
        GenJnlLine.SetRange("Journal Batch Name", JournalBatch);
    end;
    var myInt: Integer;
    balanceAccount: Option;
    Rec: Record "Gen. Journal Line";
    JournalTemplate: Code[20];
    JournalBatch: Code[20];
    LastLineNo: Integer;
    accountChart: Record "G/L Account";
    tempName: text;
    GenJrnRec: Record "Gen. Journal Line";
}
