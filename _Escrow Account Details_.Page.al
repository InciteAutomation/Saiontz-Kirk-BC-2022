page 50128 "Escrow Account Details"
{
    //Document pages are able to combine information from two tables.
    PageType = Document;
    UsageCategory = Tasks;
    SourceTable = EscrowAccounts;
    //Category4 is the lowest category that we can put custom things into.
    PromotedActionCategories = 'New,Process,Report,Processing,Reports,Deposit,Check';
    RefreshOnActivate = true;
    DeleteAllowed = false;
    //Allows you to change the title in the top left.
    DataCaptionExpression = "Case Number" + ' ' + "Client Name";

    layout
    {
        area(content)
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
                field("Incident Date";"Date of Incident")
                {
                    ApplicationArea = Basic;
                //Editable = false;
                }
                field("Case Number";"Case Number")
                {
                    ApplicationArea = Basic;
                // Editable = false;
                }
                field("Filevine ID";"Filevine ID")
                {
                    ApplicationArea = Basic;
                }
                field("Filevine URL";"Filevine URL")
                {
                    ApplicationArea = Basic;
                    //Editable = false;
                    ExtendedDatatype = URL;

                    trigger OnValidate()var Result: List of[Text];
                    projectNumber: Integer;
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
                            rec."Filevine ID":=Result.Get(projectNumber + 1);
                            rec."Filevine URL":="Filevine URL".ToLower()end;
                    end;
                }
                field("Filevine Email";"Filevine Email")
                {
                    ApplicationArea = Basic;
                //Editable = false;
                }
            }
            group("Deposit Information")
            {
                //Shows a list of Deposit Items.
                part("Deposits";"Case Deposit List Part")
                {
                    ApplicationArea = All;
                    //Limit the list to only show items with the "Case Number" that is selected.
                    SubPageLink = "Case Number"=field("Case Number");
                }
            }
            group("Check Information")
            {
                //Shows the list of Check Items.
                part("Checks";"Case Checks List Part")
                {
                    ApplicationArea = All;
                    //Limit the list to only show items with the "Case Number" that is selected.
                    SubPageLink = "Case Number"=field("Case Number");
                //"Entry Status" = filter(Posted;);
                }
            }
            group("Transfer Information")
            {
                //Shows a list of Deposit Items.
                part("Transfers";"Transfer List Part")
                {
                    ApplicationArea = All;
                    //Limit the list to only show items with the "Case Number" that is selected.
                    subPageLink = "Case Number"=field("Case Number");
                //TODO uncomment line below
                // "G/L Account No." = filter('Transfer');
                }
            }
        //group("Pending Deposits and Checks")
        //{
        //   part("Pending Deposits"; "Pending List Part")
        //   {
        //       Caption = 'Pending Deposits';
        //       ApplicationArea = All;
        //       SubPageLink = "Case Number" = field("Case Number"),
        //       "Journal Template Name" = const('DEPOSITS'),
        //       "Journal Batch Name" = const('ESCROW');
        //   }
        //  part("Pending Checks"; "Pending List Part")
        //  {
        //      Caption = 'Pending Checks';
        //      ApplicationArea = All;
        //      SubPageLink = "Case Number" = field("Case Number"),
        //      "Journal Template Name" = const('PAYMENT'),
        //      "Journal Batch Name" = const('ESCROW');
        //  }
        //}
        }
        area(FactBoxes)
        {
            part("Case Statistics Factbox";"Case Statistics Factbox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Case Number"=field("Case Number");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Write Checks")
            {
                ApplicationArea = All;
                ShortcutKey = 'Alt+C';
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()begin
                    CreateNewCheckWithCheckInfo();
                    CurrPage.SaveRecord();
                end;
            }
            action("Record Transfer")
            {
                ApplicationArea = All;
                ShortcutKey = 'Alt+T';
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;

                trigger OnAction()begin
                    OpenGenJournalPage();
                    CurrPage.SaveRecord();
                end;
            }
            action("Add Vendor")
            {
                ApplicationArea = All;
            //TODO Create function that takes in details and passes them to
            //new page.
            }
        }
        area(Reporting)
        {
            action("Escrow Account Activity Report")
            {
                ApplicationArea = All;
                Caption = 'Print Escrow Account Activity';
                //RunObject = report  "REP_EscrowActivity";
                ToolTip = 'View all Deposits and Checks for this Escrow Account';
                Promoted = true;
                PromotedCategory = Category5;
                PromotedOnly = true;

                trigger OnAction()var report: Report "REP_EscrowActivity";
                begin
                    //SetFilter("Case Number", rec."Case Number");
                    report.SetParameters(rec."Case Number");
                    report.Run();
                end;
            }
        }
    }
    procedure OpenGenJournalPage()var GLItem: Record "Gen. Journal Line";
    exsitingGLItem: Record "Gen. Journal Line";
    newLineNumber: Integer;
    begin
        exsitingGLItem.SetFilter("Journal Template Name", 'GENERAL');
        exsitingGLItem.SetFilter("Journal Batch Name", 'DEFAULT');
        //Finds the last line item and gets the line number.
        //If no record exsits set the line item to 0
        if exsitingGLItem.FindLast then newLineNumber:=exsitingGLItem."Line No." + 1
        else
            newLineNumber:=0;
        //Prepopulating the check item.
        GLItem.Init();
        GLItem."Posting Date":=System.Today;
        //checkItem."Document Date" := System.Today;
        //checkItem."Document Type" := checkItem."Document Type"::Payment;
        GLItem."Case Number":=Rec."Case Number";
        //TODO: Need to add client to the option list and fill out this information. 
        //checkItem."Account Type" := checkItem."Account Type"::Vendor;
        //checkItem."Account No." := what ever the clients account is?
        //checkItem."Payment Method Code" := 'CHECK';
        //Has to be bank account for checks.
        //checkItem."Bal. Account Type" := checkItem."Bal. Account Type"::"Bank Account";
        //checkItem."Bal. Account No." := '1001';
        //checkItem."Bank Payment Type" := checkItem."Bank Payment Type"::"Computer Check";
        //Makes sure we get to the correct journal.
        GLItem."Journal Template Name":='GENERAL';
        GLItem."Journal Batch Name":='DEFAULT';
        GLItem."Line No.":=newLineNumber;
        //GLItem."Client Name" := rec."Client Name";
        GLItem.Insert(true);
        //JHIII //TODO explore
        //Sets the fiter to only show the case they came from.
        //checkItem.SetFilter("Case Number", Rec."Case Number");
        PAGE.Run(PAGE::"General Journal", GLItem);
    // PAGE.Run(PAGE::"Escrow Payment Journal", GLItem);
    end;
    local procedure CreateNewCheckWithCheckInfo()var checkItem: Record "Gen. Journal Line";
    exsitingCheckItem: Record "Gen. Journal Line";
    newLineNumber: Integer;
    genPage: Page "Payment Journal";
    visability: Boolean;
    begin
        exsitingCheckItem.SetFilter("Journal Template Name", 'PAYMENT');
        exsitingCheckItem.SetFilter("Journal Batch Name", 'ESCROW');
        //Finds the last line item and gets the line number.
        //If no record exsits set the line item to 0
        if exsitingCheckItem.FindLast then newLineNumber:=exsitingCheckItem."Line No." + 1
        else
            newLineNumber:=0;
        //Prepopulating the check item.
        checkItem.Init();
        checkItem."Posting Date":=System.Today;
        checkItem."Document Date":=System.Today;
        checkItem."Document Type":=checkItem."Document Type"::Payment;
        checkItem."Case Number":=Rec."Case Number";
        //TODO: Need to add client to the option list and fill out this information. 
        checkItem."Account Type":=checkItem."Account Type"::Vendor;
        //checkItem."Account No." := what ever the clients account is?
        checkItem."Payment Method Code":='CHECK';
        //Has to be bank account for checks.
        checkItem."Bal. Account Type":=checkItem."Bal. Account Type"::"Bank Account";
        //checkItem."Bal. Account No." := '1001';
        checkItem."Bank Payment Type":=checkItem."Bank Payment Type"::"Computer Check";
        //Makes sure we get to the correct journal.
        checkItem."Journal Template Name":='PAYMENT';
        checkItem."Journal Batch Name":='ESCROW';
        checkItem."Line No.":=newLineNumber;
        checkItem."Client Name":=rec."Client Name";
        checkItem.Insert(true);
        //JHIII //TODO explore
        //Sets the fiter to only show the case they came from.
        checkItem.SetFilter("Case Number", Rec."Case Number");
        visability:=true;
        genPage.setVisibility(visability);
        genPage.SetRecord(checkItem);
        genpage.Run();
    //PAGE.Run(PAGE::"Payment Journal", checkItem);
    // PAGE.Run(PAGE::"Escrow Payment Journal", checkItem);
    end;
    local procedure ViewChecksEscrowBatch()var checks: Record "Gen. Journal Line";
    begin
        checks.SetFilter("Journal Template Name", 'PAYMENT');
        checks.SetFilter("Journal Batch Name", 'ESCROW');
        //JHIII //TODO explore
        // Page.Run(Page::"Escrow Payment Journal", checks);
        Page.Run(Page::"Payment Journal", checks);
    end;
    //Create New Vendor
    local procedure CreateNewVendor(clientName: Text)var VendorRec: Record Vendor;
    LastVendorEntryText: Text;
    LastVendorEntryInt: Integer;
    LastVendorEntryCode: Code[2048];
    TaxAreaCode: Code[30];
    GenBusPostingGroup: Code[30];
    VendorPostingGroup: Code[30];
    NewVendor: Record Vendor;
    flag: Boolean;
    cancel: Integer;
    begin
        VendorRec.FindLast();
        flag:=false;
        LastVendorEntryText:=Format(VendorRec."No.");
        evaluate(LastVendorEntryInt, LastVendorEntryText);
        LastVendorEntryInt:=LastVendorEntryInt + 1;
        LastVendorEntryText:=Format(LastVendorEntryInt);
        evaluate(LastVendorEntryCode, LastVendorEntryText);
        repeat if(VendorRec.Get(LastVendorEntryCode))then begin
                LastVendorEntryInt:=LastVendorEntryInt + 1;
                LastVendorEntryText:=Format(LastVendorEntryInt);
                evaluate(LastVendorEntryCode, LastVendorEntryText);
            end
            else
                flag:=true;
        until flag = true;
        NewVendor."No.":=LastVendorEntryCode;
        NewVendor.Name:=clientName;
        NewVendor."Tax Area Code":='MD';
        NewVendor."Gen. Bus. Posting Group":='ESCROW';
        NewVendor."Vendor Posting Group":='ESCROW';
        Page.RunModal(Page::"Vendor Card", NewVendor);
    //FIXME--sort descending and pull record. Increase by one. Start a "repeat until"
    //that checks IF there is a record returned with that same id. If yes, add 1, if no, continue.
    //PAGE.RunModal(Page::"Vendor Card") -->
    //Pass data into the page card. (may need to extend this page.)
    end;
//Global Variables:
//var
//    DEPOSIT_HEADER_ID: Code[20];
//        GenJnlManagement: Codeunit GenJnlManagement;
//   CurrentJnlBatchName: Code[10];
//
//ALL DEPOSIT RELATED PROCEDURES ARE NO LONGER NEEDED!
//They will be doing a deposit the traditional way, not coming from a sepcific escrow account.
//Leaving this in as reference but can be safely removed.
// local procedure CreateNewDepositWithCaseInformation()
// var
//     deposit: Record "Deposit Header";
//     depositHeadeID: Code[20];
// begin
//     depositHeadeID := CheckEscrowBatchCreated();
//     if (depositHeadeID <> '0')
//     then begin
//         Message('An Escrow Batch has already been created.  Adding a new line item to that batch.');
//         //Gets the already opened deposit so we can open that one.
//         deposit.Get(depositHeadeID);
//         DEPOSIT_HEADER_ID := depositHeadeID;
//         //Create a new line with case information.
//         CreateNewDepositLine(depositHeadeID);
//     end
//     else begin
//         //Create a new deposit header
//         depositHeadeID := CreateNewDepositHeader();
//         DEPOSIT_HEADER_ID := depositHeadeID;
//         //Create a new line with case information.
//         CreateNewDepositLine(depositHeadeID);
//     end;
//     PAGE.Run(PAGE::Deposit, deposit);
// end;
// //Checks if an exsisting deposit header for the Escrow batch is already created.
// local procedure CheckEscrowBatchCreated(): Code[20];
// var
//     batchCreated: Code[20];
//     depositHeader: Record "Deposit Header";
//     x: Record "Deposit Header";
// begin
//     //TODO:Throw these into a global settings file.
//     depositHeader.SetFilter("Journal Template Name", 'DEPOSITS');
//     depositHeader.SetFilter("Journal Batch Name", 'ESCROW');
//     if (depositHeader.FindFirst())
//     then begin
//         batchCreated := depositHeader."No.";
//         exit(batchCreated);
//     end;
//     //Set to 0 still the deposit number can never be 0.
//     //This will tell me if we got a deposit or not.
//     batchCreated := Format('0');
//     exit(batchCreated);
// end;
// local procedure CreateNewDepositHeader(): Code[20]
// var
//     depositHeader: Record "Deposit Header";
// begin
//     depositHeader.Init();
//     //TODO: Need to figure out what they want this to be.  
//     depositHeader."No." := Format(Random(500));
//     //TODO:Throw these into a global settings file.
//     depositHeader.SetFilter("Journal Template Name", 'DEPOSITS');
//     depositHeader.SetFilter("Journal Batch Name", 'ESCROW');
//     depositHeader."Posting Date" := System.Today;
//     depositHeader."Document Date" := System.Today;
//     depositHeader.Insert(true);
//     //Returns the newly created depositHeader No.
//     exit(depositHeader."No.");
// end;
// //Creates a new Gen. Journal Line for the escrow deposit batch
// //TODO: Figure out how to link the Line item and the deposit batch.
// //I don't think I need to return anything since I already have the deposit line.
// local procedure CreateNewDepositLine(depositHeaderID: Code[20])
// var
//     lineItem: Record "Gen. Journal Line";
//     existinglineItem: Record "Gen. Journal Line";
//     foundItem: Boolean;
//     newLineNumber: Integer;
// begin
//     //Sets the filters on the line item.
//     existinglineItem.SetFilter("Journal Template Name", 'DEPOSITS');
//     existinglineItem.SetFilter("Journal Batch Name", 'ESCROW');
//     //Finds the last line item and gets the line number.
//     //If no record exsits set the line item to 0
//     if existinglineItem.FindLast then
//         newLineNumber := (existinglineItem."Line No." + 1)
//     else
//         newLineNumber := 0;
//     //Prepopulating new line item.
//     lineItem.Init();
//     lineItem."External Document No." := depositHeaderID;
//     lineItem."Case Number" := Rec."Case Number";
//     lineItem."Journal Template Name" := 'DEPOSITS';
//     lineItem."Journal Batch Name" := 'ESCROW';
//     lineItem."Document Date" := System.Today();
//     lineItem."Line No." := newLineNumber;
//     lineItem."Document Type" := lineItem."Document Type"::Payment;
//     lineItem.Insert(true);
// end;
// //Opens the current escrow deposit header.
// //Throw a message up if one hasn't been created yet?
// local procedure ViewOpenDeposits()
// var
//     depositHeader: Record "Deposit Header";
// begin
//     if (DEPOSIT_HEADER_ID <> '') then begin
//         depositHeader.Get(DEPOSIT_HEADER_ID);
//         Page.Run(Page::Deposit, depositHeader);
//     end
//     else
//         Message('There are no escrow deposits opened at this time.');
// end;
}
