pageextension 50114 PaymentReconJournalEXT extends "Payment Reconciliation Journal"
{
    layout
    {
        modify("Transaction Date")
        {
        Visible = true;
        //editable = SKGLManagerEditablility;
        //"Transaction Date" := Today;
        //trigger OnAfterValidate()
        //begin
        //Rec."Transaction Date" := Today;
        //"Transaction Date" := Today;
        //end;
        // trigger OnLookup(var VoidDate: Date)
        // begin
        //     Message(Format(VoidDate));
        //     VoidDate := Today();
        // end;
        }
    }
    actions
    {
        modify(ImportBankTransactions)
        {
            trigger OnAfterAction()var Alllines: Record "Bank Acc. Reconciliation Line";
            begin
                AllLines.SetRange("Transaction Date", 0D);
                AllLines.ModifyAll("Transaction Date", WorkDate());
            end;
        }
    }
    //trigger o
    trigger OnOpenPage()var PermissionSetLookup: Page "Permission Set Lookup";
    PermPage: page "Permission Set by User";
    SuperAggPerSet: Record "Aggregate Permission Set";
    SK_GLPerSet: Record "Aggregate Permission Set";
    SuperAccountHas: Boolean;
    Allobj: Record AllObj;
    AllLines: Record "Bank Acc. Reconciliation Line";
    begin
        // AllLines.SetRange("Statement Amount",GetRangeMin("Statement Amount"), GetRangeMax("Statement Amount"));
        //Message('Count = '  + foRMAT(AllLines."Statement Amount"));
        AllLines.SetRange("Transaction Date", 0D);
        AllLines.ModifyAll("Transaction Date", WorkDate());
        //Message('Updated using Modify All?');
        NOT_Editablility:=false;
        user.SetFilter("User Security ID", UserSecurityId());
        user.FindLast();
        SuperAggPerSet.SetFilter("Role ID", 'D365 BUS FULL ACCESS');
        SuperAggPerSet.FindLast();
        SK_GLPerSet.SetFilter("Role ID", 'SK_GL');
        SK_GLPerSet.FindLast();
        SKGLManagerEditablility:=(UserHasPermission(SK_GLPerSet, user)) or (UserHasPermission(SuperAggPerSet, user));
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
