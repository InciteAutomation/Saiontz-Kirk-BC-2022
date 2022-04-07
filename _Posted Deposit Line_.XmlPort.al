xmlport 50161 "Posted Deposit Line"
{
    caption = 'Posted Deposit Line Import/Export';
    //Encoding = UTF8;
    //FormatEvaluate = Xml;
    TextEncoding = UTF8;
    Format = VariableText;

    schema
    {
    textelement(DepositLines)
    {
    tableelement(PDLine;
    "Posted Deposit Line")
    {
    AutoUpdate = true;

    fieldattribute("DepositNumber";
    PDLine."Deposit No.")
    {
    }
    fieldattribute("LineNumber";
    PDLine."Line No.")
    {
    }
    fieldattribute("AccountType";
    PDLine."Account Type")
    {
    }
    fieldattribute("AccountNumber";
    PDLine."Account No.")
    {
    }
    fieldattribute("DocumentDate";
    PDLine."Document Date")
    {
    }
    fieldattribute("DocumentType";
    PDLine."Document Type")
    {
    }
    fieldattribute("DocumentNumber";
    PDLine."Document No.")
    {
    }
    fieldattribute("Amount";
    PDLine.Amount)
    {
    }
    fieldattribute("PostingDate";
    PDLine."Posting Date")
    {
    }
    fieldattribute("BankAccountLedgerEntryNo";
    PDLine."Bank Account Ledger Entry No.")
    {
    }
    fieldattribute("EntryNumber";
    PDLine."Entry No.")
    {
    }
    fieldattribute("CaseNumber";
    PDLine."Case Number")
    {
    }
    fieldattribute("DepositDetail";
    PDLine."Deposit Detail")
    {
    }
    fieldattribute("Dimension";
    PDLine."Shortcut Dimension 1 Code")
    {
    }
    }
    }
    }
}
