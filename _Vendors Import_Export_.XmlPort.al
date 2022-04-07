xmlport 50156 "Vendors Import/Export"
{
    Caption = 'Vendors Import/Export';
    //Encoding = UTF8;
    //FormatEvaluate = Xml;
    TextEncoding = UTF8;
    Format = VariableText;
    DefaultFieldsValidation = false;

    schema
    {
    textelement(Vendors)
    {
    tableelement(VSet;
    Vendor)
    {
    AutoUpdate = true;

    //Line Number in SQL
    fieldattribute(No;
    VSet."No.")
    {
    }
    fieldattribute(Name;
    VSet.Name)
    {
    }
    fieldattribute(Address;
    VSet.Address)
    {
    }
    fieldattribute(Address2;
    VSet."Address 2")
    {
    }
    fieldattribute(City;
    VSet.City)
    {
    }
    fieldattribute(OurAccountNo;
    VSet."Our Account No.")
    {
    }
    fieldattribute(VendorPostingGroup;
    VSet."Vendor Posting Group")
    {
    }
    fieldattribute(PaymentMethodCode;
    VSet."Payment Method Code")
    {
    }
    fieldattribute(GenBusPostingGroup;
    VSet."Gen. Bus. Posting Group")
    {
    }
    fieldattribute(ZipCode;
    VSet."Post Code")
    {
    }
    fieldattribute(TaxAreaCode;
    VSet."Tax Area Code")
    {
    }
    fieldattribute(FederalIDNo;
    VSet."Federal ID No.")
    {
    }
    fieldattribute(CheckDateFormat;
    VSet."Check Date Format")
    {
    }
    fieldattribute(CheckDateSeparator;
    VSet."Check Date Separator")
    {
    }
    fieldattribute(TaxIdentifier;
    VSet."Tax Identification Type")
    {
    }
    }
    }
    }
}
