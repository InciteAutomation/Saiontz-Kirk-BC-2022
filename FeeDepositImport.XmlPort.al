xmlport 50106 FeeDepositImport
{
    TextEncoding = UTF8;
    Format = VariableText;

    schema
    {
    textelement(root)
    {
    tableelement(GenJnlLine;
    "Gen. Journal Line")
    {
    fieldattribute(PostingDate;
    GenJnlLine.Comment)
    {
    // trigger OnBeforePassField()
    // var
    //     dateCheck: Boolean;
    //     pDate: Date;
    // begin
    ;
    //     Message(GenJnlLine.Comment);
    //     if Evaluate(pDate, GenJnlLine.Comment) then GenJnlLine."Posting Date" := pDate else Message(GenJnlLine.Comment);
    //end;
    trigger OnAfterAssignField()var dateCheck: Boolean;
    yearString: text;
    monthString: text;
    dayString: text;
    day: Integer;
    year: Integer;
    month: Integer;
    length: Integer;
    dateString: Text;
    dateListPart: List of[Text];
    parts: array[3]of Text;
    dlp: Text;
    i: Integer;
    begin
        if GenJnlLine.Comment.Contains('Date')then skipRow:=true
        else
        begin
            skipRow:=false;
            //Message(GenJnlLine.Comment);
            dateString:=GenJnlLine.Comment.Replace('Ù‹', '');
            Evaluate(pDate, dateString);
        end;
    //if Evaluate(pDate, GenJnlLine.Comment) then GenJnlLine."Posting Date" := pDate else Message(GenJnlLine.Comment);
    end;
    }
    fieldattribute(Description;
    GenJnlLine."Deposit Detail")
    {
    }
    fieldattribute(CaseNumber;
    GenJnlLine.Comment)
    {
    }
    fieldattribute(ClientName;
    GenJnlLine.Comment)
    {
    }
    fieldattribute(FeeDep;
    GenJnlLine.Comment)
    {
    trigger OnAfterAssignField()begin
        if not GenJnlLine.Comment.Contains('Fee')then Evaluate(FeeDeposit, GenJnlLine.Comment);
    //Message('FeeDopsit ' + Format(FeeDeposit));
    end;
    }
    fieldattribute(ExReimb;
    GenJnlLine.Comment)
    {
    trigger OnAfterAssignField()begin
        if not GenJnlLine.Comment.Contains('Exp')then Evaluate(ExpReimb, GenJnlLine.Comment);
    end;
    }
    fieldattribute(TotalAmount;
    GenJnlLine.Comment)
    {
    }
    fieldattribute(AccountName;
    GenJnlLine."Transaction Information")
    {
    }
    trigger OnBeforeInsertRecord()var GL: Record "G/L Account";
    AccountNo: Text;
    begin
        if(GenJnlLine."Transaction Information" = '') or skipRow then begin
            currXMLport.Skip();
            skipRow:=false;
        end
        else
        begin
            LastLineNo+=10000;
            GenJnlLine."Line No.":=LastLineNo;
            GenJnlLine."Journal Template Name":=JournalTemplate;
            GenJnlLine."Journal Batch Name":=JournalBatch;
            //GenJnlLine."Balance Description" := '';
            //Message('pDate ' + format(pDate));
            GenJnlLine."Posting Date":=pDate;
            GenJnlLine."Document Date":=pDate;
            GenJnlLine."Document No.":='Deposit Import';
            if FeeDeposit = 0 then begin
                GenJnlLine."Account No.":='57000';
                GenJnlLine."G/L Account Name":='Expense Recovery';
                GenJnlLine."Credit Amount":=ExpReimb;
                GenJnlLine.Amount:=-ExpReimb;
                ExpReimb:=0;
            end
            else
            begin
                GenJnlLine."Credit Amount":=FeeDeposit;
                GenJnlLine.Amount:=-FeeDeposit;
                GenJnlLine."G/L Account Name":=GenJnlLine."Transaction Information";
                GL.SetFilter(Name, GenJnlLine."Transaction Information");
                Gl.FindFirst();
                AccountNo:=gl."No.";
                GenJnlLine."Account No.":=AccountNo;
                System.Clear(GL);
            end;
            FeeDeposit:=0;
            GenJnlLine."Transaction Information":='';
            GenJnlLine.Comment:='';
        end;
    end;
    //trigger OnAfterInsertRecord()
    //begin
    //    GenJrnRec.Get(JournalTemplate, JournalBatch, LastLineNo);
    //   accountChart.SetFilter(Name, GenJrnRec."Balance Description");
    //    accountChart.FindLast();
    //    GenJrnRec."Account No." := accountChart."No.";
    //   GenJrnRec.Modify();
    //end;
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
    var pDate: Date;
    myInt: Integer;
    balanceAccount: Option;
    Rec: Record "Gen. Journal Line";
    JournalTemplate: Code[20];
    JournalBatch: Code[20];
    LastLineNo: Integer;
    accountChart: Record "G/L Account";
    CaptionRow: Boolean;
    skipRow: Boolean;
    FeeDeposit: Decimal;
    ExpReimb: Decimal;
    CountVar: Integer;
    tempName: text;
    GLAccountName: text;
    GenJrnRec: Record "Gen. Journal Line";
}
