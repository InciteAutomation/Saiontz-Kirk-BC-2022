pageextension 50174 "Deposit Page Header EXT" extends Deposit
{
    layout
    {
        modify("Shortcut Dimension 1 Code")
        {
        //TODO JHIII application areas
        Visible = false;
        ApplicationArea = All;
        }
        modify("Shortcut Dimension 2 Code")
        {
        Visible = false;
        ApplicationArea = All;
        }
        modify("No.")
        {
        trigger OnDrillDown()begin
            // Message('On drilldown');
            "No.":=No;
        end;
        }
    }
    actions
    {
        addlast(Creation)
        {
            group(DataImport)
            {
                action("Deposit Page Header Import")
                {
                    ToolTip = 'Import Deposit Header from an XML file.';
                    ApplicationArea = All;

                    trigger OnAction()begin
                        Xmlport.Run(Xmlport::"Deposit Header Import/Export", true, true);
                    end;
                }
            }
        }
        // addafter(PostAndPrint)
        // {
        //     //FIXME change this to a SK Post only. Then set up an event subscriber that updates the table.
        //     //After updating/modfying the table, it runs "Print".
        //     action("AP Post & Print")
        //     {
        //         ToolTip = 'Accounts Payable a new Post & Print';
        //         ApplicationArea = AccountsPayable;
        //         trigger OnAction()
        //         begin
        //             CODEUNIT.Run(CODEUNIT::"SK Deposit-Post + Print", Rec);
        //         end;
        //     }
        //     action("Escrow Post & Print")
        //     {
        //         ToolTip = 'Escrow Post & Print';
        //         ApplicationArea = EscrowApplication;
        //         trigger OnAction()
        //         begin
        //             CODEUNIT.Run(CODEUNIT::"Escrow Deposit-Post + Print", Rec);
        //         end;
        //     }
        // }
        // addafter(Post)
        // {
        //     action("AP Post")
        //     {
        //         ToolTip = 'Accounts Payable Post';
        //         ApplicationArea = AccountsPayable;
        //         trigger OnAction()
        //         begin
        //             Codeunit.Run(Codeunit::"SK_Deposit-Post", Rec);
        //         end;
        //     }
        //     action("Escrow Post")
        //     {
        //         ToolTip = 'Escrow Post';
        //         ApplicationArea = EscrowApplication;
        //         trigger OnAction()
        //         begin
        //             CODEUNIT.Run(CODEUNIT::"Escrow_Deposit-Post", Rec);
        //         end;
        //     }
        // }
        addfirst("P&osting")
        {
            action("Post & Print")
            {
                ToolTip = 'Accounts Payable a new Post & Print';
                ApplicationArea = All;

                trigger OnAction()begin
                    CODEUNIT.Run(CODEUNIT::"SK Deposit-Post + Print", Rec);
                end;
            }
        //TODO come here if the checks need to be repaired again
        // action("Fix Checks")
        // {
        //     ApplicationArea = All;
        //     trigger OnAction()
        //     begin
        //         Codeunit.Run(Codeunit::EditBankAccountLedgerEntries);
        //         Message('finished running bank');
        //         Codeunit.Run(Codeunit::EditCheckLedgerEntryTable);
        //         Message('finished running check');
        //         Codeunit.Run(Codeunit::EditPostedPaymentReconLine);
        //         Message('finished running posted')
        //     end;
        // }
        // action("Escrow Post & Print")
        // {
        //     ToolTip = 'Escrow Post & Print';
        //     ApplicationArea = EscrowApplication;
        //     trigger OnAction()
        //     begin
        //         CODEUNIT.Run(CODEUNIT::"Escrow Deposit-Post + Print", Rec);
        //     end;
        // }
        // action("AP Post")
        // {
        //     ToolTip = 'Accounts Payable Post';
        //     ApplicationArea = AccountsPayable;
        //     trigger OnAction()
        //     begin
        //         Codeunit.Run(Codeunit::"SK_Deposit-Post", Rec);
        //     end;
        // }
        // action("Escrow Post")
        // {
        //     ToolTip = 'Escrow Post';
        //     ApplicationArea = EscrowApplication;
        //     trigger OnAction()
        //     begin
        //         CODEUNIT.Run(CODEUNIT::"Escrow_Deposit-Post", Rec);
        //     end;
        // }
        }
        modify(PostAndPrint)
        {
            Visible = false;
        }
        modify(Post)
        {
            Visible = true;
        }
    }
    /*
        trigger OnOpenPage()

        begin
            // GetBatchDefault();
            rec.SetFilter("Bank Account No.", 'DEPOSITS');
            rec."No." := '20200402-1';

        end;
    */
    var genBatch: Record "Gen. Journal Batch";
    local procedure GetBatchDefault()var gb: Record "Gen. Journal Batch";
    //default: Code[10];// 'DEFAULT'
    begin
    //default := 'DEFAULT';
    //gb.SetFilter("Bal. Account No.", '1001');
    //rec.SetFilter("Bank Account No.", 'DEPOSITS');
    //Message('Hello');
    end;
    local procedure postAndPrintDeposit(var PDL: Record "Posted Deposit Line";
    GJL: Record "Gen. Journal Line";
    DH: Record "Deposit Header")begin
        CODEUNIT.Run(CODEUNIT::"SK Deposit-Post + Print", Rec);
    end;
    procedure updateTotalDepositLines()var thing: Record "Deposit Header";
    begin
        //Rec.CalcFields("Total Deposit Lines");
        CurrPage.Update(false);
        thing.FindLast();
        thing.CalcFields("Total Deposit Lines");
    end;
    trigger OnNewRecord(BelowxRec: Boolean)var HeadRec1: Record "Posted Deposit Line";
    HeadRec2: Record "Deposit Header";
    NoText: Text;
    NextNo: Text;
    NoInt: BigInteger;
    flag: Boolean;
    loopcount: Integer;
    Company: Record Company;
    begin
        Company.Get(CompanyName);
        if(CompanyName = 'Accounts Payable')then begin
            flag:=false;
            loopcount:=0;
            //Check if deposits have records and create no based from that
            if(HeadRec2.FindLast())then begin
                // Message('Deposit has record');
                HeadRec2.FindLast();
                NoText:=Format(HeadRec2."No.");
                // Message(NoText);
                //Evaluate(NoInt, NoText);
                NextNo:=Text.IncStr(NoText);
                // NoInt := NoInt + 1;
                repeat if(HeadRec2.Get(NextNo))then begin
                        NoInt:=NoInt + 1;
                        NextNo:=Text.IncStr(NextNo);
                    end
                    else
                    begin
                        flag:=true end;
                until flag = true;
                loopcount:=loopcount + 1;
                NoText:=NextNo; //Format(NoInt);
                Evaluate(No, NoText);
            end
            //Check if posted deposit has record and create no from that
            else if(HeadRec1.FindLast())then begin
                    // Message('Posted Deposit has record');
                    HeadRec1.FindLast();
                    NoText:=Format(HeadRec1."Deposit No.");
                    NoText:=Format(HeadRec2."No.");
                    NextNo:=Text.IncStr(NoText);
                    // Message(NoText);
                    //Evaluate(NoInt, NoText);
                    //NoInt := NoInt + 1;
                    repeat if(HeadRec1.Get(NoInt))then begin
                            //NoInt := NoInt + 1;
                            NextNo:=Text.IncStr(NextNo);
                        end
                        else
                        begin
                            flag:=true end;
                    until flag = true;
                    loopcount:=loopcount + 1;
                    NoText:=NextNo; // Format(NoInt);
                    Evaluate(No, NoText);
                end
                else
                begin
                    //Nothing has record, start with 1.
                    // Message('No existing deposit records');
                    NoInt:=1;
                    NoText:=Format(NoInt);
                    Evaluate(No, NoText);
                end;
        end;
    end;
    //FIXME Remove later. This fires upgrade codeunit
    // trigger OnOpenPage()
    // var
    //     dataUpgrade: Codeunit InitDataUpgrade;
    // begin
    //     Message('code unit fired');
    //     dataUpgrade.InitDataUpgrade();
    // end;
    var No: Code[2048];
}
