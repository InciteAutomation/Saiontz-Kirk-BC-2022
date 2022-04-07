codeunit 50145 "SK Deposit-Post + Print"
{
    TableNo = "Deposit Header";

    trigger OnRun()begin
        DepositHeader.Copy(Rec);
        if not Confirm(Text000, false)then exit;
        Codeunit.Run(Codeunit::"Deposit-Post", DepositHeader);
        Rec:=DepositHeader;
        Commit;
        if PostedDepositHeader.Get("No.")then begin
            Message('printing');
            PostedDepositHeader.SetRecFilter;
            Company.Get(CompanyName);
            if(CompanyName = 'Escrow')then begin
                REPORT.Run(REPORT::REP_EscrowDepositSummary, false, false, PostedDepositHeader);
            end
            else
            begin
                REPORT.Run(REPORT::Custom_Deposit, false, false, PostedDepositHeader);
            end;
        end;
    end;
    var DepositHeader: Record "Deposit Header";
    PostedDepositHeader: Record "Posted Deposit Header";
    DepositPost: Codeunit "Deposit-Post";
    Text000: Label 'Do you want to post and print the Deposit?';
    Company: Record Company;
}
