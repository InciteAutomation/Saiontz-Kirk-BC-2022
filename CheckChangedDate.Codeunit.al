codeunit 50106 CheckChangedDate
{
    [IntegrationEvent(false, false)]
    procedure OnDateChanged(DocumentDate: Date;
    DueDate: Date;
    LineNum: Integer;
    JrlTempName: Code[2048];
    BatchName: Code[2048])begin
    end;
}
