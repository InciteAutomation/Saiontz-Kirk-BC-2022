codeunit 50147 "Escrow Deposit-Post + Print"
{
    TableNo = "Deposit Header";

    trigger OnRun()begin
        DepositHeader.Copy(Rec);
        if not Confirm(Text000, false)then exit;
        Codeunit.Run(Codeunit::"Escrow_Deposit-Post", DepositHeader);
        Rec:=DepositHeader;
        Commit;
        if PostedDepositHeader.Get("No.")then begin
            Message('printing');
            PostedDepositHeader.SetRecFilter;
            REPORT.Run(REPORT::Escrow_Deposit, false, false, PostedDepositHeader);
        end;
    end;
    var DepositHeader: Record "Deposit Header";
    PostedDepositHeader: Record "Posted Deposit Header";
    DepositPost: Codeunit "Deposit-Post";
    Text000: Label 'Do you want to post and print the Deposit?';
}
