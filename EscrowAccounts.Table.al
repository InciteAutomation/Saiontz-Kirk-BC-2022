table 50125 EscrowAccounts
{
    DataClassification = ToBeClassified;
    //TODO: Should open full list of accounts when using the dropdown.
    LookupPageId = "Escrow Account List";

    fields
    {
        //ID field and primary key
        field(1;EscrowAccountID;BigInteger)
        {
            NotBlank = true;
            AutoIncrement = true;
        }
        //Case Number is still the key that we are going to 
        field(2;"Case Number";Code[30])
        {
            NotBlank = true;
        }
        field(3;"Filevine ID";Code[30])
        {
            NotBlank = true;
        }
        field(4;"Client Name";Text[250])
        {
            NotBlank = true;
        }
        field(5;"Date of Incident";Date)
        {
            NotBlank = true;
        }
        field(6;"Case Type";Text[250])
        {
        }
        field(7;"Filevine Email";Text[250])
        {
        }
        field(8;"Client Reference";Text[250])
        {
        }
        field(9;"Filevine URL";Text[500])
        {
            NotBlank = true;

            trigger OnValidate()var Result: List of[Text];
            projectNumber: Integer;
            begin
                if(rec."Filevine URL" = ' ')then begin
                    rec."Filevine ID":='';
                end
                else
                begin
                    //Example Filevine URL: https://app.filevine.com/#/project/1343561/activity
                    //Could just use the 6th element of the result after splitting it but I figured searching for project is safer.
                    //That way if someone doesn't type in the https:// then we will still be able to find the FV number.
                    Result:=rec."Filevine URL".Split('/');
                    projectNumber:=Result.IndexOf('project');
                    //If we can't find 'project' the index will be 0.
                    //Throw an error because something is not right with that URL. 
                    if(projectNumber = 0)then begin
                    // Error('Invalid FileVine URL. Please correct before continuing.', "Filevine URL");
                    end
                    else
                    begin
                        rec."Filevine ID":=Result.Get(projectNumber + 1);
                    end;
                end;
            end;
        }
        field(10;"Escrow Account Archive";Boolean)
        {
            NotBlank = true;
        }
        //Calculated fields
        field(11;"Total Deposits ($)";Decimal)
        {
            AutoFormatType = 1;
            //Document Type is an option data type.  
            //Using the filter keyword lets you select the option.
            CalcFormula = sum("Posted Deposit Line"."Amount" where("Case Number"=field("Case Number")));
            Caption = 'Total Deposits';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12;"Total Checks ($)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Check Ledger Entry".Amount where("Case Number"=field("Case Number"), //                                                     "Entry Status" = filter(Posted | "Financially Voided")
            "Entry Status"=filter(Posted)));
            Caption = 'Total Checks';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13;"Total Transfers In ($)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("G/L Entry"."Credit Amount" where("Case Number"=field("Case Number"), "G/L Account No."=filter('40600|40700')));
            //- sum ("G/L Entry".Amount where("Case Number" = field("Case Number"), "G/L Account No." = const('40700')));
            Caption = 'Total Transfers In';
            Editable = false;
            FieldClass = FlowField;
        }
        field(14;"Total Transfers Out ($)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("G/L Entry"."Debit Amount" where("Case Number"=field("Case Number"), "G/L Account No."=filter('40600|40700')));
            //- sum ("G/L Entry".Amount where("Case Number" = field("Case Number"), "G/L Account No." = const('40700')));
            Caption = 'Total Transfers Out';
            Editable = false;
            FieldClass = FlowField;
        }
        field(15;"Total Purchase Invoices ($)";Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Purchase Line".Amount where("Case Number"=field("Case Number")));
            Caption = 'Total Purchase Invoices';
            Editable = false;
            FieldClass = FlowField;
        }
    }
    keys
    {
        //key(PK; EscrowAccountID) { Clustered = true; }
        key(PK;"Case Number")
        {
            Clustered = true;
        }
        //key(CaseKey; "Case Number") { Unique = true; }
        //key(FilevineKey; "Filevine ID") { Unique = true; }
        key(FilevineKey;"Filevine ID")
        {
        }
    }
    fieldgroups
    {
        //Field group for the dropdown
        fieldgroup(DropDown;"Case Number", "Filevine ID", "Client Name", "Date of Incident", "Case Type")
        {
        }
    }
}
