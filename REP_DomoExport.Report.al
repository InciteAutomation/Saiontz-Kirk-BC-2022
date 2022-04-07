report 50199 REP_DomoExport
{
    //CaptionML = ENU = 'Escrow Check Register';
    CaptionML = ENU='Domo Export';
    RDLCLayout = 'ReportLayouts/DomoExport.rdl';
    WordLayout = 'ReportLayouts/DomoExport.docx';
    PreviewMode = PrintLayout;
    //WordMergeDataItem = ;
    UseRequestPage = true;

    //SetPar(ParDocNo: Code[20])
    dataset
    {
        dataitem("G/L Account";"G/L Account")
        {
            //RequestFilterFields = "Date Filter";
            column(No_;"No.")
            {
            }
            column(Name;Name)
            {
            }
            column(Balance_at_Date;"Balance at Date")
            {
            }
            column(Balance;Balance)
            {
            }
            column(Income_Balance;"Income/Balance")
            {
            }
            column(Account_Category;"Account Category")
            {
            }
            column(Date_Filter;AsOfDate)
            {
            }
            column(Balance_at_Date_Previous_Month;"Balance at Date Previous Month")
            {
            }
            column(Net_Change;"Net Change")
            {
            }
            column(Balance_at_Date_Prev_Month_Aug;"Balance at Date Prev Month Aug")
            {
            }
            column(Net_Change_Test;"Net Change Test")
            {
            }
            column(DateFilter;"Date Filter")
            {
            }
            trigger OnPreDataItem()var GLAccountMonth: Record "G/L Account";
            begin
                SetFilter("Date Filter", Format(FilterDate));
                SetFilter("Date Filter Previous Month", Format(PreviousMonthEnd));
                SetFilter("Date Filter Previous Month Aug", Format(AugustDate));
                SetRange("Date Filter Test", AsOfDate, FilterDate);
            //SetRange("Date Filter", AsOfDate, FilterDate);
            // GLAccountMonth.Get("No.");
            // GLAccountMonth.SetFilter("Date Filter", Format(AsOfDate - 1));
            // BalancePreviousMonth := GLAccountMonth."Balance at Date";
            end;
        // trigger OnAfterGetRecord()
        // var
        //     GLAccountMonth: Record "G/L Account";
        // begin
        //     GLAccountMonth.Get("No.");
        //     GLAccountMonth.SetFilter("Date Filter", Format(AsOfDate - 1));
        //     BalancePreviousMonth := GLAccountMonth."Balance at Date";
        // end;
        }
    }
    requestpage
    {
        //SaveValues = true;
        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options';

                    field("As Of Date";AsOfDate)
                    {
                        ApplicationArea = All;
                        Caption = 'As of Date.';
                        ToolTip = 'Used to filter balance for the end of the month in whcih this date is on.';
                    // trigger OnValidate()
                    // begin
                    //     Month := Date2DMY(AsOfDate, 2);
                    //     NextMonth := Month + 1;
                    //     Year := Date2DMY(AsOfDate, 3);
                    //     AsOfDate := DMY2Date(1, Month, Year);
                    //     if Month = 12 then begin
                    //         NextMonth := 1;
                    //         Year := Year + 1;
                    //     end;
                    //     Date1 := DMY2Date(1, NextMonth, Year);
                    //     //message('Date1 - ' + Format(Date1 - 1));
                    //     "G/L Account".SetFilter("Date Filter", Format(Date1 - 1));
                    // end;
                    }
                }
            }
        }
    //trigger OnOpenPage()
    }
    trigger OnPreReport()begin
        //Expr1 := '<EM>';
        //Evaluate(RefDate, "G/L Account".GetFilter("Date Filter"));
        // message('RefDate = ' + Format(RefDate));
        //RefDate := 20191120D;
        //message('AsofDate = ' + Format(AsOfDate));
        if Format(AsOfDate) = '' then AsOfDate:=Today;
        Month:=Date2DMY(AsOfDate, 2);
        NextMonth:=Month + 1;
        Year:=Date2DMY(AsOfDate, 3);
        //Set AsOFDate to the first of the selected month
        AsOfDate:=DMY2Date(1, Month, Year);
        //Need to deal with the end of year fiscal turnover
        AugustDate:=DMY2Date(31, 8, Year);
        if Month = 12 then begin
            NextMonth:=1;
            Year:=Year + 1;
        end;
        //Message("This is the date filter " + Format());
        //Date1 := DMY2Date(1, Month, Year);
        //AsOfDate := DMY2Date(1, Month, Year);
        AugustDate:=DMY2Date(31, 8, Year);
        Date1:=DMY2Date(1, NextMonth, Year);
        FilterDate:=Date1 - 1;
        PreviousMonthEnd:=AsOfDate - 1;
    //Sanity Check
    // message('FilterDate =  ' + Format(FilterDate));
    // message('PreviousMonthEnd = ' + Format(PreviousMonthEnd));
    // message('AsOfDate = ' + Format(AsOfDate));
    end;
    var BalancePreviousMonth: Decimal;
    AsOfDate: Date;
    RefDate: Date;
    FilterDate: Date;
    Date1: Date;
    Day: Integer;
    Month: Integer;
    Year: Integer;
    NextMonth: Integer;
    Expr1: Text[30];
    PreviousMonthEnd: Date;
    AugustDate: Date;
}
