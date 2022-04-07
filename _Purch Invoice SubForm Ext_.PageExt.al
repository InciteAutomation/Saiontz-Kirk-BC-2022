pageextension 50124 "Purch Invoice SubForm Ext" extends "Purch. Invoice Subform"
{
    layout
    {
        addbefore(Type)
        {
            field("Case Number";"Case Number")
            {
                ApplicationArea = all;
                visible = showCase;
            }
            field("Project ID";"Project ID")
            {
                Caption = 'Filevine Project ID';
                ApplicationArea = all;
                visible = true;
            }
        }
        modify("Line Amount")
        {
        trigger OnAfterValidate()begin
        end;
        }
    }
    var showCase: Boolean;
    trigger OnOpenPage()begin
        showCase:=false;
        if(CompanyName = 'Escrow')then begin
            showCase:=true;
        end;
    end;
    procedure UpdateCaseNumer(Var CaseNumber: Code[30])begin
        "Case Number":=CaseNumber;
        Type:=Type::"G/L Account";
        CurrPage.Update();
    end;
    procedure UpdateProjectID(Var ProjectID: Code[30])begin
        "Project ID":=ProjectID;
        Type:=Type::"G/L Account";
        CurrPage.Update();
    end;
}
