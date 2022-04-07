tableextension 50164 "GL ACcount EXT" extends "G/L Account"
{
    fields
    {
        field(50101;"Balance at Date Previous Month";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No."=FIELD("No."), "G/L Account No."=FIELD(FILTER(Totaling)), "Business Unit Code"=FIELD("Business Unit Filter"), "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"), "Posting Date"=FIELD(UPPERLIMIT("Date Filter Previous Month")), "Dimension Set ID"=FIELD("Dimension Set ID Filter")));
            Caption = 'Balance at Date Previous Month';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50128;"Date Filter Previous Month";Date)
        {
            Caption = 'Date Filter Previous Month';
            FieldClass = FlowFilter;
        }
        field(50102;"Balance at Date Prev Month Aug";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No."=FIELD("No."), "G/L Account No."=FIELD(FILTER(Totaling)), "Business Unit Code"=FIELD("Business Unit Filter"), "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"), "Posting Date"=FIELD(UPPERLIMIT("Date Filter Previous Month Aug")), "Dimension Set ID"=FIELD("Dimension Set ID Filter")));
            Caption = 'Balance at Date Previous Month';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50129;"Date Filter Previous Month Aug";Date)
        {
            Caption = 'Date Filter Previous Month';
            FieldClass = FlowFilter;
        }
        field(50103;"Net Change Test";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("G/L Entry".Amount WHERE("G/L Account No."=FIELD("No."), "G/L Account No."=FIELD(FILTER(Totaling)), "Business Unit Code"=FIELD("Business Unit Filter"), "Global Dimension 1 Code"=FIELD("Global Dimension 1 Filter"), "Global Dimension 2 Code"=FIELD("Global Dimension 2 Filter"), "Posting Date"=FIELD("Date Filter Test"), "Dimension Set ID"=FIELD("Dimension Set ID Filter")));
            Caption = 'Net Change';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50130;"Date Filter Test";Date)
        {
            Caption = 'Date Filter Test';
            FieldClass = FlowFilter;
        }
    }
}
