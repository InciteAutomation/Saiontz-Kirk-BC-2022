report 50100 REP_EscrowActivity
{
    CaptionML = ENU='Escrow Activity Report';
    RDLCLayout = 'ReportLayouts/EscrowActivityReport.rdl';
    WordLayout = 'ReportLayouts/EscrowActivityReport.docx';
    PreviewMode = PrintLayout;
    //WordMergeDataItem = ;
    UseRequestPage = true;

    //SetPar(ParDocNo: Code[20])
    dataset
    {
        dataitem(EscrowAccounts;EscrowAccounts)
        {
            DataItemTableView = SORTING("Case Number");
            // PrintOnlyIfDetail = true;
            RequestFilterFields = "Case Number";

            column(EA_Client_Name;"Client Name")
            {
            }
            column(EA_Case_Type;"Case Type")
            {
            }
            column(EA_Date_of_Incident;"Date of Incident")
            {
            }
            column(EA_Case_Number;"Case Number")
            {
            }
            column(EA_Total_Deposits____;"Total Deposits ($)")
            {
            }
            column(EA_Total_Checks____;"Total Checks ($)")
            {
            }
            dataitem("Posted Deposit Line";"Posted Deposit Line")
            {
                RequestFilterFields = "Case Number";

                column(PDL_Posting_Date;"Posting Date")
                {
                }
                column(PDL_Document_Number;"Document No.")
                {
                }
                column(PDL_Deposit_Type_Code;"Shortcut Dimension 1 Code")
                {
                }
                column(PDL_Memo;"Deposit Detail")
                {
                }
                column(PDL_Case_Number;"Case Number")
                {
                }
                column(PDL_Balance_No;"Account No.")
                {
                }
                column(PDL_Balance_Desc;"Account Type")
                {
                }
                column(PDL_Account_Type;"Account Type")
                {
                }
                column(PDL_Account_No_;"Account No.")
                {
                }
                column(PDL_Description;Description)
                {
                }
                column(PDL_Deposit_Detail;"Deposit Detail")
                {
                }
                column(PDL_Amount;Amount)
                {
                }
            //FIXME
            // if not TestPrint then begin
            //     Message('not test print');
            //     if FoundLast or not AddedRemainingAmount then begin
            //         Message('not found last');
            //         if RemainingAmount <> 0 then begin
            //             AddedRemainingAmount := true;
            //             FoundLast := true;
            //             LineAmount := RemainingAmount;
            //             LineAmount2 := RemainingAmount;
            //             CurrentLineAmount := LineAmount2;
            //             RemainingAmount := 0;
            //         end else
            //             CurrReport.Break;
            //     end else begin
            //         CurrentLineAmount := "Posted Deposit Line".Amount;
            //         LineAmount2 := CurrentLineAmount;
            //         FoundLast := "Posted Deposit Line".Next = 0;
            //     end;
            //     if ("Check Ledger Entry"."Entry Status" <> "Check Ledger Entry"."Entry Status"::Voided) then begin
            //         if ("Check Ledger Entry"."Entry Status" <> "Check Ledger Entry"."Entry Status"::"Financially Voided") then begin
            //             CheckAmount := CheckAmount + CurrentLineAmount;
            //             Message('posted amount', Format(CheckAmount));
            //         end;
            //     end;
            //     CheckAmount := CheckAmount + CurrentLineAmount;
            //     Message('posted amount 2', Format(CheckAmount));
            // end else begin
            //     Message('else fired');
            //     if FoundLast then
            //         Message('end');
            //     CurrReport.Break;
            //     FoundLast := true;
            //     LineAmount := 0;
            // end;
            // CheckAmount := CheckAmount + Amount;
            // Message('posted amount 3', Format(CheckAmount));
            }
            dataitem("Check Ledger Entry";"Check Ledger Entry")
            {
                RequestFilterFields = "Case Number", "Entry Status";

                column(CLE_Document_Date;"Check Date")
                {
                }
                column(CLE_Check_No;"Check No.")
                {
                }
                column(CLE_Check_Type_Code;"Global Dimension 2 Code")
                {
                }
                column(CLE_Memo;Memo)
                {
                }
                column(CLE_Balance_Description;"Bank Payment Type")
                {
                }
                column(CLE_Entry_Status;"Entry Status")
                {
                }
                column(CLE_Void_Date;"Void Date")
                {
                }
                column(Posting_Date;"Posting Date")
                {
                }
                column(Bal__Account_Type;"Bal. Account Type")
                {
                }
                column(Bal__Account_No_;"Bal. Account No.")
                {
                }
                column(Amount;Amount)
                {
                }
                column(CLE_CaseNumber;"Case Number")
                {
                }
                column("CLE_Description";Description)
                {
                }
                column(CheckAmount;CheckAmount)
                {
                }
                //TODO Make sure this works.
                trigger OnAfterGetRecord()begin
                    if("Check Ledger Entry"."Entry Status" <> "Check Ledger Entry"."Entry Status"::"Financially Voided")then begin
                        // Message('not financially voided');
                        if("Check Ledger Entry"."Entry Status" <> "Check Ledger Entry"."Entry Status"::Voided)then begin
                            // Message('not voided');
                            CheckAmount:=CheckAmount + Amount;
                        end;
                    end;
                end;
            }
        }
        dataitem("General Ledger";"G/L Entry")
        {
            RequestFilterFields = "Case Number", "G/L Account No.";

            column("GL_Posting_Date";"Posting Date")
            {
            }
            column("GL_Account_Number";"G/L Account No.")
            {
            }
            column("GL_Case_No";"Case Number")
            {
            }
            column("GL_Amount";Amount)
            {
            }
            // trigger OnAfterGetRecord()
            // begin
            //     if ("G/L Account Name" = 'Transfer')
            //     then
            //         CurrReport.Break();
            // end;
            //just show things where the g/l account name contains transfer
            column("GL_Debit_Amount";"Debit Amount")
            {
            }
            column("GL_Credit_Amount";"Credit Amount")
            {
            }
            column("GL_Description";Description)
            {
            }
            column("GL_Account_Name";"G/L Account Name")
            {
            }
        }
    }
    requestpage
    {
        trigger OnOpenPage()begin
            EscrowAccounts.SetFilter("Case Number", '=%1', CaseNumber);
            "Posted Deposit Line".SetFilter("Case Number", '=%1', CaseNumber);
            "Check Ledger Entry".SetFilter("Entry Status", 'Voided|Posted|Financially Voided|Test Print|Exported|Transmitted');
            "Check Ledger Entry".SetFilter("Case Number", '=%1', CaseNumber);
            "General Ledger".SetFilter("Case Number", '=%1', CaseNumber);
            //PrintVisCase.SetFilter(ID, '=%1', id);
            "General Ledger".SetFilter("G/L Account No.", '40600|40700', '40600|40700');
        // Transfer.SetFilter("G/L Account No.", )
        end;
    }
    procedure SetParameters(CaseNum: Code[30])begin
        CaseNumber:=CaseNum;
    end;
    var CaseNumber: Code[30];
    CheckAmount: Decimal;
    TestPrint: Boolean;
    FoundLast: Boolean;
    AddedRemainingAmount: Boolean;
    RemainingAmount: Decimal;
    LineAmount: Decimal;
    LineAmount2: Decimal;
    CurrentLineAmount: Decimal;
    ApplyMethod: Option Payment, OneLineOneEntry, OneLineID, MoreLinesOneEntry;
}
