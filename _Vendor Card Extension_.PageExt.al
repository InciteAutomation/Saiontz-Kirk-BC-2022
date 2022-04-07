pageextension 50181 "Vendor Card Extension" extends "Vendor Card"
{
    layout
    {
        modify("No.")
        {
        Editable = false;
        }
        //SK Editable Only
        modify(Address)
        {
        Editable = true; //SKAccountantEditablility;
        }
        modify("Address 2")
        {
        Editable = SKAccountantEditablility;
        }
        modify(City)
        {
        Editable = SKAccountantEditablility;
        }
        modify(County)
        {
        Editable = SKAccountantEditablility;
        }
        modify("Post Code")
        {
        Editable = SKAccountantEditablility;
        }
        modify("Tax Liable")
        {
        Editable = SKAccountantEditablility;
        }
        modify("IRS 1099 Code")
        {
        Editable = SKAccountantEditablility;
        Visible = true;
        }
        modify("Federal ID No.")
        {
        Editable = SKAccountantEditablility;
        }
        modify("Tax Identification Type")
        {
        Editable = SKAccountantEditablility;
        }
        //NOT EDITABLE FOR SK_ACCOUNTNAT
        modify("Country/Region Code")
        {
        Editable = not(NOT_Editablility);
        }
        modify("Primary Contact No.")
        {
        Editable = not(NOT_Editablility);
        }
        modify(Contact)
        {
        Editable = not(NOT_Editablility);
        }
        modify("Phone No.")
        {
        Editable = not(NOT_Editablility);
        }
        modify(MobilePhoneNo)
        {
        Editable = not(NOT_Editablility);
        }
        modify("E-Mail")
        {
        Editable = not(NOT_Editablility);
        }
        modify("Home Page")
        {
        Editable = not(NOT_Editablility);
        }
        modify("Our Account No.")
        {
        Editable = not(NOT_Editablility);
        }
        modify("Tax Area Code")
        {
        Editable = not(NOT_Editablility);
        }
        modify(Name)
        {
        Editable = not(NOT_Editablility);
        }
        modify("Gen. Bus. Posting Group")
        {
        Editable = not(NOT_Editablility);
        }
        modify("Vendor Posting Group")
        {
        Editable = not(NOT_Editablility);
        }
        modify("Application Method")
        {
        Editable = not(NOT_Editablility);
        }
        modify("Payment Terms Code")
        {
        Editable = not(NOT_Editablility);
        }
        modify("Payment Method Code")
        {
        Editable = not(NOT_Editablility);
        }
        modify("FATCA filing requirement")
        {
        Editable = not(NOT_Editablility);
        }
        modify("Check Date Format")
        {
        Editable = not(NOT_Editablility);
        }
        modify("Check Date Separator")
        {
        Editable = not(NOT_Editablility);
        }
        modify("Location Code")
        {
        Editable = not(NOT_Editablility);
        }
        modify("Shipment Method Code")
        {
        Editable = not(NOT_Editablility);
        }
        modify("Lead Time Calculation")
        {
        Editable = not(NOT_Editablility);
        }
        modify("Base Calendar Code")
        {
        Editable = not(NOT_Editablility);
        }
        modify("Customized Calendar")
        {
        Editable = not(NOT_Editablility);
        }
        modify("Over-Receipt Code")
        {
        Editable = not(NOT_Editablility);
        }
        modify("Bank Communication")
        {
        Editable = not(NOT_Editablility);
        }
        modify("VAT Registration No.")
        {
        Editable = not(NOT_Editablility);
        }
    }
    trigger OnOpenPage()var PermissionSetLookup: Page "Permission Set Lookup";
    PermPage: page "Permission Set by User";
    skAccountHas: Boolean;
    agSet: Record "Aggregate Permission Set";
    SuperAggPerSet: Record "Aggregate Permission Set";
    VendorManagerPerSet: Record "Aggregate Permission Set";
    SuperAccountHas: Boolean;
    Allobj: Record AllObj;
    Company: Record Company;
    begin
        skAccountHas:=true;
        NOT_Editablility:=false;
        SKAccountantEditablility:=true;
        Company.Get(CompanyName);
        if(CompanyName = 'Accounts Payable')then begin
            user.SetFilter("User Security ID", UserSecurityId());
            user.FindLast();
            agSet.SetFilter("Role ID", 'SK_ACCOUNTING');
            agSet.FindLast();
            SuperAggPerSet.SetFilter("Role ID", 'D365 BUS FULL ACCESS');
            SuperAggPerSet.FindLast();
            VendorManagerPerSet.SetFilter("Role ID", 'SK_VENDOR_MGR');
            VendorManagerPerSet.FindLast();
            skAccountHas:=UserHasPermission(agSet, user);
            if skAccountHas then begin
                // Allobj.Get(Allobj."Object Type"::Table, 23);
                //CheckuserPermission(Allobj);
                NOT_Editablility:=true;
            end;
            //Message('Not has Perm = ' + format(skAccountHas));
            SuperAccountHas:=(UserHasPermission(SuperAggPerSet, user)) or (UserHasPermission(VendorManagerPerSet, user));
            //Message('has Vendor Man ' + Format(UserHasPermission(VendorManagerPerSet, user)));
            SKAccountantEditablility:=(skAccountHas) or (SuperAccountHas);
            //Message('skAccountHas = ' + Format(skAccountHas));
            //Message('SKAccountantEditablility = ' + format(SKAccountantEditablility));
            if SuperAccountHas then begin
                NOT_Editablility:=false;
            end;
        end;
    end;
    var user: record User;
    SKAccountantEditablility: Boolean;
    NOT_Editablility: Boolean;
    VendorManager: Boolean;
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
    local procedure CheckuserPermission(Allobj: Record AllObj)var permission: Record Permission temporary;
    EffectivePermissionMngt: Codeunit "Effective Permissions Mgt.";
    begin
        EffectivePermissionMngt.PopulatePermissionRecordWithEffectivePermissionsForObject(permission, user."User Security ID", CompanyName(), Allobj."Object Type", Allobj."Object ID");
        permission.Insert();
        permission.Modify();
    //if(permission.FindFirst()) then begin
    //   if( permission."Modify Permission")
    //end;
    end;
}
