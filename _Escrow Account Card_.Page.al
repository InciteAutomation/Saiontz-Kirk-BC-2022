page 50151 "Escrow Account Card"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = EscrowAccounts;
    DeleteAllowed = false;

    layout
    {
        area(Content)
        {
            group("General")
            {
                field("Client Name";"Client Name")
                {
                    ApplicationArea = Basic;
                // Editable = false;
                }
                field("Case Type";"Case Type")
                {
                    ApplicationArea = Basic;
                //Editable = false;
                }
                field("Date of Incident";"Date of Incident")
                {
                    ApplicationArea = Basic;
                //Editable = false;
                }
                field("Case Number";"Case Number")
                {
                    ApplicationArea = Basic;
                //Editable = false;
                //trigger OnValidate()
                //begin
                //  if (rec."Case Number" = '')
                //then begin
                //     Error('Case Number cannot be empty', "Case Number");
                // end;
                //end;
                }
                field("Filevine ID";"Filevine ID")
                {
                    ApplicationArea = Basic;
                    Editable = false;
                }
                field("Filevine URL";"Filevine URL")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                    ExtendedDatatype = URL;
                    ShowMandatory = true;

                    trigger OnValidate()var Result: List of[Text];
                    projectNumber: Integer;
                    EscrowAccount: Record EscrowAccounts;
                    begin
                        //Example Filevine URL: https://app.filevine.com/#/project/1343561/activity
                        //Could just use the 6th element of the result after splitting it but I figured searching for project is safer.
                        //That way if someone doesn't type in the https:// then we will still be able to find the FV number.
                        Result:=rec."Filevine URL".ToLower().Split('/');
                        projectNumber:=Result.IndexOf('project');
                        //If we can't find 'project' the index will be -1.
                        //Throw an error because something is not right with that URL. 
                        if(projectNumber = 0)then begin
                            Error('Invalid FileVine URL. Please correct before continuing.', "Filevine URL");
                        end
                        else
                        begin
                            EscrowAccount.SetFilter("Filevine ID", Result.Get(projectNumber + 1));
                            if(EscrowAccount.FindLast())then begin
                                Error('Invalid Filevine URL. A unique Filevine Project ID must be entered with the URL', "Filevine URL");
                            end;
                            rec."Filevine ID":=Result.Get(projectNumber + 1);
                            rec."Filevine URL":="Filevine URL".ToLower()end;
                    end;
                }
                field("Filevine Email";"Filevine Email")
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }
    trigger OnQueryClosePage(CloseAction: Action): Boolean begin
        if(not("Case Number" = ''))then Rec.TestField("Filevine URL");
    //Message('Filevine url = ' + "Filevine URL");
    end;
}
