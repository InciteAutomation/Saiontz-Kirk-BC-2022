codeunit 50143 GeneralCodeUnits
{
    procedure GeneralJournalPageSetDocumetnNo()var genjourpage: page "General Journal";
    begin
        genjourpage.NewDocumentNo();
        genjourpage.Run();
    end;
}
