xmlport 50182 "Case List Import/Export"
{
    Caption = 'Case List Import/Export';
    //Encoding = UTF8;
    //FormatEvaluate = Xml;
    TextEncoding = UTF8;
    Format = VariableText;

    schema
    {
    textelement(Cases)
    {
    tableelement(Clist;
    CaseList)
    {
    fieldattribute(ProjectID;
    Clist."Project ID")
    {
    }
    fieldattribute(Casetype;
    Clist."Case Type")
    {
    }
    fieldattribute(ProjectName;
    Clist."Project Name")
    {
    }
    fieldattribute(DateOfIncident;
    Clist."Incident Date")
    {
    }
    }
    }
    }
}
