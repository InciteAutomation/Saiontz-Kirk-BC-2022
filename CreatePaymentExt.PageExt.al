pageextension 50113 CreatePaymentExt extends "Create Payment"
{
    layout
    {
        modify("Posting Date")
        {
        Visible = true;
        editable = SKGLManagerEditablility;
        // trigger OnLookup(var VoidDate: Date)
        // begin
        //     Message(Format(VoidDate));
        //     VoidDate := Today();
        // end;
        }
    }
    trigger OnOpenPage()var PermissionSetLookup: Page "Permission Set Lookup";
    PermPage: page "Permission Set by User";
    SuperAggPerSet: Record "Aggregate Permission Set";
    SK_GLPerSet: Record "Aggregate Permission Set";
    SuperAccountHas: Boolean;
    Allobj: Record AllObj;
    Company: Record Company;
    begin
        Company.Get(CompanyName);
        if(CompanyName = 'Accounts Payable')then begin
            NOT_Editablility:=false;
            user.SetFilter("User Security ID", UserSecurityId());
            user.FindLast();
            SuperAggPerSet.SetFilter("Role ID", 'D365 BUS FULL ACCESS');
            SuperAggPerSet.FindLast();
            SK_GLPerSet.SetFilter("Role ID", 'SK_GL');
            SK_GLPerSet.FindLast();
            SKGLManagerEditablility:=(UserHasPermission(SK_GLPerSet, user)) or (UserHasPermission(SuperAggPerSet, user));
        end
        Else
        begin
            SKGLManagerEditablility:=true;
        end;
    end;
    local procedure UserHasPermission(var AggregatePermissionSet: Record "Aggregate Permission Set";
    var User: Record User): Boolean var AccessControl: Record "Access Control";
    begin
        AccessControl.SetRange("User Security ID", User."User Security ID");
        AccessControl.SetRange("Role ID", AggregatePermissionSet."Role ID");
        AccessControl.SetFilter("Company Name", '%1|%2', '', CompanyName);
        AccessControl.SetRange(Scope, AggregatePermissionSet.Scope);
        AccessControl.SetRange("App ID", AggregatePermissionSet."App ID");
        exit(not AccessControl.IsEmpty);
    end;
    var user: record User;
    SKGLManagerEditablility: Boolean;
    NOT_Editablility: Boolean;
//VendorManager: Boolean;
}
