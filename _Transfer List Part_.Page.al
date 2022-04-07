page 50148 "Transfer List Part"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "G/L Entry";
    SourceTableView = sorting("Posting Date")order(ascending)where("G/L Account No."=filter(40600..40700));
    Caption = 'Transfers';

    // DeleteAllowed = false;
    // Editable = false;
    // InsertAllowed = false;
    // ModifyAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Posting Date";"Posting Date")
                {
                    ApplicationArea = All;
                }
                field("G/L Account No.";"G/L Account No.")
                {
                    ApplicationArea = All;
                }
                field("G/L Account Name";"G/L Account Name")
                {
                    ApplicationArea = All;
                }
                field("Debit Amount";"Debit Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Transferred Out';
                }
                field("Credit Amount";"Credit Amount")
                {
                    ApplicationArea = All;
                    Caption = 'Transferred In';
                }
                //TODO Remove these items. This is a test to see what information will print.
                field("Description";Description)
                {
                    ApplicationArea = All;
                }
                field("Case Number";"Case Number")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()var Company: Record Company;
    begin
        Company.Get(CompanyName);
        if(CompanyName = 'Escrow')then begin
            rec.SetFilter("G/L Account No.", '40600|40700');
        end;
    end;
}
