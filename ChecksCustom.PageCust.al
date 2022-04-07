pagecustomization ChecksCustom customizes "Payment Journal"
{
    layout
    {
        movefirst(Control1;"Posting Date", "Document Date", "Case Number", "Client Name", "Account Type", "Account No.", Description, Memo, Amount, "Bal. Account Type", "Bal. Account No.", "Payment Method Code", "Bank Payment Type", "Check Printed")
        modify("Document Type")
        {
        Visible = false;
        }
        modify("Currency Code")
        {
        Visible = false;
        }
        modify("Payment Reference")
        {
        Visible = false;
        }
        modify("Applied (Yes/No)")
        {
        Visible = false;
        }
        modify("Applies-to Doc. Type")
        {
        Visible = false;
        }
        modify(AppliesToDocNo)
        {
        Visible = false;
        }
        modify(GetAppliesToDocDueDate)
        {
        Visible = false;
        }
        modify("Shortcut Dimension 1 Code")
        {
        Visible = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
        Visible = false;
        }
        modify("Recipient Bank Account")
        {
        Visible = false;
        }
        modify("Document No.")
        {
        Visible = false;
        }
        modify("External Document No.")
        {
        Visible = false;
        }
        modify("Transaction Type Code")
        {
        Visible = false;
        }
        //Modifying the payment journal bottom text to show balance remaining of escrow account
        modify(AccName)
        {
        Visible = false;
        }
    }
}
