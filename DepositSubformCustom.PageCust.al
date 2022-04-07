pagecustomization DepositSubformCustom customizes "Deposit Subform"
{
    layout
    {
        //Control is the section of the page that we are moving the fields to
        //Control number was found by looking at the BC source code.
        movefirst(Control1020000;"Document Date", "Case Number", "Client Name", "Document No.", "Account Type", "Account No.", Description, "Deposit Detail", "Credit Amount")
        //modify("Shortcut Dimension 1 Code") { Visible = false; }
        //modify("Shortcut Dimension 2 Code") { Visible = false; }
        modify("Document Type")
        {
        Visible = false;
        }
        modify("Case Number")
        {
        Visible = true;
        }
        modify("Client Name")
        {
        Visible = true;
        }
    }
}
