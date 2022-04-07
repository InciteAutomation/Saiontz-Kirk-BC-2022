page 50133 "Case Checks List Part"
{
    PageType = ListPart;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "Check Ledger Entry";
    Caption = 'Posted Checks';
    DeleteAllowed = false;
    Editable = false;
    InsertAllowed = false;
    ModifyAllowed = false;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Check Date";"Check Date")
                {
                    ApplicationArea = All;
                    Caption = 'Document Date';
                }
                field("Check No.";"Check No.")
                {
                    ApplicationArea = All;
                }
                //field("Entry No."; "Entry No.") { ApplicationArea = All; }
                field("Dimension2";"Global Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Check Type Code';
                }
                field("Memo";Description)
                {
                    ApplicationArea = All;
                    Caption = 'Memo';
                }
                field(Amount;Amount)
                {
                    ApplicationArea = All;
                }
                //field("Balance Account"; "Bank Account No.") { ApplicationArea = All; Caption = 'Balance #'; }
                field("Description";"Bank Payment Type")
                {
                    ApplicationArea = All;
                    Caption = 'Balance Description';
                }
                field("Entry Status";"Entry Status")
                {
                    ApplicationArea = All;
                /*
                    trigger OnValidate()
                    var
                        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
                        entrynumber: Integer;
                    Begin
                        //TableRelation = if ("Entry Status" = filter("Financially Voided")) "Bank Account Ledger Entry"."Posting Date" where("Document No." = field("Check No."), Description = filter('Voiding*'));
                        if ("Entry Status" = "Entry Status"::"Financially Voided")// OR "Entry Status" = "Entry Status"::Voided )
                        then Begin
                            BankAccountLedgerEntry.SetFilter("Document No.", Rec."Document No.");
                            BankAccountLedgerEntry.SetFilter("Document Type", ' ');
                            entrynumber := BankAccountLedgerEntry.GetRangeMax("Entry No.");
                            BankAccountLedgerEntry.Get("Entry No.", entrynumber);
                            "Void Date" := BankAccountLedgerEntry."Posting Date";
                        End
                        else begin
                            if ("Entry Status" = "Entry Status"::"Voided")// OR "Entry Status" = "Entry Status"::Voided )
                        then Begin
                                "Void Date" := Rec."Posting Date";
                            End;
                        end;
                        BankAccountLedgerEntry.get(Rec."Document No.")
                    End;
                    */
                }
                field("Posting Date";"Posting Date")
                {
                    ApplicationArea = All;
                }
                // field("Vooid Dates"; VoidDate) { } //"Entry Status":: ("Entry Status" = "Financially Voided") THEN  "Bar" else "foo" END ) { ApplicationArea = All; }
                field("Void Date";"Void Date")
                {
                    ApplicationArea = All;
                /*TableRelation = if ("Entry Status" = filter("Financially Voided"))
                  
                       "Bank Account Ledger Entry"."Posting Date" where("Document No." = field("Check No."), Description = filter('Voiding*'))
                    
                
                    else
                    if ("Entry Status" = filter("Voided")) "Bank Account Ledger Entry"."Posting Date" where("Document No." = field("Check No."), Description = filter('Voiding*'));
                */
                }
                field("Cleared Date";"Cleared Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            group("&Line")
            {
                Caption = '&Line';
                Image = Line;

                action(VoidCheck)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Void Check';
                    Image = Document;
                    Promoted = true;
                    Scope = Repeater;

                    trigger OnAction()var CheckManagement: Codeunit CheckManagement;
                    begin
                        CheckManagement.FinancialVoidCheck(Rec);
                    end;
                }
            }
        }
    }
    var datee: Date;
    local procedure foofoo()begin
    end;
/*
    trigger OnOpenPage()
    var
        BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
        entrynumber: Integer;
    Begin
        //TableRelation = if ("Entry Status" = filter("Financially Voided")) "Bank Account Ledger Entry"."Posting Date" where("Document No." = field("Check No."), Description = filter('Voiding*'));
        if (REC."Entry Status" = "Entry Status"::"Financially Voided")// OR "Entry Status" = "Entry Status"::Voided )
        then Begin
            BankAccountLedgerEntry.SetFilter("Document No.", Rec."Document No.");
            BankAccountLedgerEntry.SetFilter("Document Type", ' ');
            entrynumber := BankAccountLedgerEntry.GetRangeMax("Entry No.");
            BankAccountLedgerEntry.Get("Entry No.", entrynumber);
            "Void Date" := BankAccountLedgerEntry."Posting Date";
        End
        else begin
            if ("Entry Status" = "Entry Status"::"Voided")// OR "Entry Status" = "Entry Status"::Voided )
        then Begin
                BankAccountLedgerEntry.SetFilter("Document No.", Rec."Document No.");
                BankAccountLedgerEntry.SetFilter("Document Type", ' ');
                entrynumber := BankAccountLedgerEntry.GetRangeMax("Entry No.");
                BankAccountLedgerEntry.Get("Entry No.", entrynumber);
                "Void Date" := BankAccountLedgerEntry."Posting Date";
            End;
        end;
        // BankAccountLedgerEntry.get(Rec."Document No.")
    end;
*/
}
