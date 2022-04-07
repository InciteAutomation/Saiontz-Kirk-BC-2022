table 50130 CaseList
{
    DataClassification = ToBeClassified;
    LookupPageId = "Case List List";

    fields
    {
        field(1;"Project ID";Code[30])
        {
            NotBlank = true;
        }
        field(2;"Project Name";Text[250])
        {
            NotBlank = true;
        }
        field(3;"Incident Date";Date)
        {
            NotBlank = true;
        }
        field(4;"Case Type";Text[250])
        {
        }
    }
    keys
    {
        key(PK;"Project ID")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
        //Field group for the dropdown
        fieldgroup(DropDown;"Project ID", "Project Name", "Incident Date", "Case Type")
        {
        }
    }
}
