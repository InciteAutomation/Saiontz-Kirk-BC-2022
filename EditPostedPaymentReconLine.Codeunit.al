codeunit 50112 EditPostedPaymentReconLine
{
    Permissions = TableData "Posted Payment Recon. Line"=rimd;
    TableNo = "Posted Payment Recon. Line";

    trigger OnRun();
    begin
        EditEntry()end;
    procedure EditEntry();
    begin
        Rec.Get('2000020665465', '1', 8980000);
        Rec."Applied Document No.":='300434';
        Rec.Modify();
        Rec.Get('2000020665465', '1', 8320000);
        Rec."Applied Document No.":='300697';
        Rec.Modify();
        Rec.Get('2000020665465', '1', 8490000);
        Rec."Applied Document No.":='300711';
        Rec.Modify();
        Rec.Get('2000020665465', '1', 8710000);
        Rec."Applied Document No.":='300597';
        Rec.Modify();
        Rec.Get('2000020665465', '1', 7040000);
        Rec."Applied Document No.":='300553';
        Rec.Modify();
        Rec.Get('2000020665465', '1', 8820000);
        Rec."Applied Document No.":='300517';
        Rec.Modify();
        Rec.Get('2000020665465', '1', 7520000);
        Rec."Applied Document No.":='300563';
        Rec.Modify();
        Rec.Get('2000020665465', '1', 7530000);
        Rec."Applied Document No.":='300229';
        Rec.Modify();
        Rec.Get('2000020665465', '1', 7770000);
        Rec."Applied Document No.":='300237';
        Rec.Modify();
        Rec.Get('2000020665465', '1', 7600000);
        Rec."Applied Document No.":='300306';
        Rec.Modify();
        Rec.Get('2000020665465', '1', 6930000);
        Rec."Applied Document No.":='300008';
        Rec.Modify();
        Rec.Get('2000020665465', '1', 7590000);
        Rec."Applied Document No.":='300394';
        Rec.Modify();
        Rec.Get('2000020665465', '1', 7220000);
        Rec."Applied Document No.":='300479';
        Rec.Modify();
        Rec.Get('2000020665465', '1', 3540000);
        Rec."Applied Document No.":='300226';
        Rec.Modify();
        Rec.Get('2000020665465', '1', 6590000);
        Rec."Applied Document No.":='300343';
        Rec.Modify();
        Rec.Get('2000020665465', '1', 3760000);
        Rec."Applied Document No.":='300055';
        Rec.Modify();
    end;
    var Rec: Record "Posted Payment Recon. Line";
}
