report 50191 REP_APCheckRegister
{
    //CaptionML = ENU = 'Escrow Check Register';
    CaptionML = ENU='Check Disbursements';
    RDLCLayout = 'ReportLayouts/APCheckRegister.rdl';
    WordLayout = 'ReportLayouts/APCheckRegister.docx';
    PreviewMode = PrintLayout;
    //WordMergeDataItem = ;
    UseRequestPage = true;

    //SetPar(ParDocNo: Code[20])
    dataset
    {
        dataitem("Check Ledger Entry";"Check Ledger Entry")
        {
            RequestFilterFields = "Check Date", "Entry Status";

            column(CLE_Document_Date;"Check Date")
            {
            }
            column(CLE_Check_No;"Check No.")
            {
            }
            column(CLE_Check_GL_Account_Name;GLname)
            {
            }
            column(CLE_Memo;Memo)
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
            column(Amount;Amount)
            {
            }
            column(CLE_Description;Description)
            {
            }
            // dataitem("GL Entry";"G/L Entry")
            // {
            //     DataItemLink = "Document No." = field("Document No.");
            //     DataItemLinkReference = "Check Ledger Entry";
            //     DataItemTableView = sorting("Bal. Account No.") where("Bal. Account No." = filter("Check Ledger Entry"."Bal. Account No."));
            // }
            // dataitem("General Ledger"; "G/L Entry")
            // {
            //     RequestFilterFields = "G/L Account No.";
            //     column("GL_Account_Name"; "G/L Account Name") { }
            // }
            trigger OnAfterGetRecord()var gl: Record "G/L Entry";
            GLAccount: Record "G/L Account";
            begin
                //Filters: Document No.: 300043, Bal. Account No.: V00010
                if("Check Ledger Entry"."Entry Status" = "Check Ledger Entry"."Entry Status"::Posted)then begin
                    //Message('Check Ledger Info ' + "Check Ledger Entry"."Document No.");
                    //Message('Bal. Account No. ' + "Check Ledger Entry"."Bal. Account No.");
                    gl.SetFilter("Document No.", "Check Ledger Entry"."Document No.");
                    gl.SetFilter("Bal. Account No.", "Check Ledger Entry"."Bal. Account No.");
                    gl.FindSet();
                    //gl.FindLast;
                    GLAccount.Get(gl."G/L Account No.");
                    GLname:=GLAccount.Name;
                // CLE_Check_GL_Account_Name := GLname;
                //Message('Is the the right count of gl? ' + gl."G/L Account No.");
                //Message('Is the the right name of gl? ' + GLname);
                //Message('GL is ' + Format(gl));
                end
                else
                    GLname:='';
            end;
        }
    }
    var GLname: Text;
    BalNo: text;
    DocNo: text;
//trigger OnPreReport()
}
