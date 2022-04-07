tableextension 50135 "Check Ledger Entry EXT" extends "Check Ledger Entry"
{
    fields
    {
        field(50100;"Case Number";Code[30])
        {
            TableRelation = EscrowAccounts."Case Number";
        //ValidateTableRelation = false;
        // trigger OnValidate();
        // begin
        //     if (Rec."Case Number" <> xRec."Case Number") then begin
        //         Error('Cannot update the rewards status of a blocked customer.');
        //     end;
        // end;
        // trigger 
        }
        field(50107;"FileVine Project ID";Code[30])
        {
            TableRelation = CaseList."Project ID";
        }
        field(50102;"Global Dimension 1 Code";Code[20])
        {
            CaptionClass = '1,1,1';
            Caption = 'Global Dimension 1 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));
        }
        field(50103;"Global Dimension 2 Code";Code[20])
        {
            CaptionClass = '1,1,2';
            Caption = 'Global Dimension 2 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2));
        }
        field(50101;"Memo";Text[500])
        {
        }
        field(50105;"VoidDate";Date)
        {
            FieldClass = FlowField;
            CalcFormula = max("Bank Account Ledger Entry"."Posting Date" where("Document No."=field("Document No.")));
        }
        field(50104;"Void Date";Date)
        {
        //FieldClass = FlowField;
        //CalcFormula = max ("Bank Account Ledger Entry"."Posting Date" where("Document No." = field("Check No.")));
        //TableRelation = if ("Entry Status" = filter("Financially Voided"))
        //    "Bank Account Ledger Entry"."Document Date" where("Document No." = field("Check No."), Description = filter('Voiding*'))
        //else
        //if ("Entry Status" = filter("Voided")) "Bank Account Ledger Entry"."Posting Date" where("Document No." = field("Check No."), Description = filter('Voiding*'));
        // FieldClass = FlowField;
        //CalcFormula =  lookup ("Bank Account Ledger Entry"."Posting Date" where("Document No." = field("Check No."), Description = const('Voiding check*')));
        //Caption ='Void Date';
        //Editable = false;
        /*
              TableRelation = if ("Entry Status" = filter("Financially Voided")) "Bank Account Ledger Entry"."Posting Date" where("Entry No." = field()) ) 
              else
              if ("Entry Status" = filter("Voided")) "Bank Account Ledger Entry"."Posting Date" where("Document No." = field("Check No."),
                                                                                                      "Document Type" = filter(" "));

             
              trigger OnValidate()

              var
                  BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
                  entrynumber: Integer;
              Begin
                  Message('Start on Validater');
                  //TableRelation = if ("Entry Status" = filter("Financially Voided")) "Bank Account Ledger Entry"."Posting Date" where("Document No." = field("Check No."), Description = filter('Voiding*'));
                  if (REC."Entry Status" = "Entry Status"::"Financially Voided")// OR "Entry Status" = "Entry Status"::Voided )
                  then Begin
                      BankAccountLedgerEntry.SetFilter("Document No.", Rec."Document No.");
                      BankAccountLedgerEntry.SetFilter("Document Type", ' ');
                      entrynumber := BankAccountLedgerEntry.GetRangeMax("Entry No.");
                      BankAccountLedgerEntry.Get("Entry No.", entrynumber);
                      Rec."Void Date" := BankAccountLedgerEntry."Posting Date";
                  End
                  else begin
                      if ("Entry Status" = "Entry Status"::"Voided")// OR "Entry Status" = "Entry Status"::Voided )
                  then Begin
                        //  BankAccountLedgerEntry.SetFilter("Document No.", Rec."Document No.");
                        //  BankAccountLedgerEntry.SetFilter("Document Type", ' ');
                        //  entrynumber := BankAccountLedgerEntry.GetRangeMax("Entry No.");
                        //  BankAccountLedgerEntry.Get("Entry No.", entrynumber);
                         Rec."Void Date" := Rec."Posting Date";
                      End;
                  end;
              end;
 */
        }
        field(50106;"Cleared Date";Date)
        {
        }
    }
    procedure GetMaxEntryNum(var checkNum: Text)entrynum: BigInteger var BankEntryNum: BigInteger;
    BankAccountLedgerRecord: Record "Bank Account Ledger Entry";
    begin
        BankAccountLedgerRecord.SetFilter("Document No.", checkNum);
        entrynum:=BankAccountLedgerRecord.GetRangeMax("Entry No.");
    end;
/*
        trigger OnAfterModify()
        var
            BankAccountLedgerEntry: Record "Bank Account Ledger Entry";
            entrynumber: Integer;
        Begin
            Message('Start on onAfterModify');
            //TableRelation = if ("Entry Status" = filter("Financially Voided")) "Bank Account Ledger Entry"."Posting Date" where("Document No." = field("Check No."), Description = filter('Voiding*'));
            if (REC."Entry Status" = "Entry Status"::"Financially Voided")
            then Begin
                BankAccountLedgerEntry.SetFilter("Document No.", Rec."Document No.");
                BankAccountLedgerEntry.SetFilter("Document Type", ' ');
                entrynumber := BankAccountLedgerEntry.GetRangeMax("Entry No.");
                BankAccountLedgerEntry.Get("Entry No.", entrynumber);

                Rec."Void Date" := BankAccountLedgerEntry."Posting Date";
            End
            else begin
                if ("Entry Status" = "Entry Status"::"Voided")
            then Begin
                    Rec."Void Date" := Rec."Posting Date";
                End;
            end;
        end;
        */
}
