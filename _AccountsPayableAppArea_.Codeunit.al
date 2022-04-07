codeunit 50109 "AccountsPayableAppArea"
{
    // Extend and modify Essential experience tier with "AccountsPayable"
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Application Area Mgmt.", 'OnGetEssentialExperienceAppAreas', '', false, false)]
    local procedure RegisterExampleExtensionOnGetEssentialExperienceAppAreas(var TempApplicationAreaSetup: Record "Application Area Setup" temporary)begin
        TempApplicationAreaSetup."AccountsPayable":=true;
    // Modify other application areas here
    end;
    // Validate that application areas needed for the extension are enabled
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Application Area Mgmt.", 'OnValidateApplicationAreas', '', false, false)]
    local procedure VerifyApplicationAreasOnValidateApplicationAreas(ExperienceTierSetup: Record "Experience Tier Setup";
    TempApplicationAreaSetup: Record "Application Area Setup" temporary)begin
        if ExperienceTierSetup.Essential then if not TempApplicationAreaSetup."AccountsPayable" then Error('AccountsPayable should be part of Essential in order for the Example Extension to work.');
    end;
    // Helpers ................................................................
    procedure IsAccountsPayableAreaEnabled(): Boolean var ApplicationAreaSetup: Record "Application Area Setup";
    ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName())then exit(ApplicationAreaSetup."AccountsPayable");
    end;
    procedure EnableAccountsPayable()var ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        ApplicationAreaMgmtFacade.RefreshExperienceTierCurrentCompany();
    end;
    procedure DisableAccountsPayable()var ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        ApplicationAreaMgmtFacade.SetHideApplicationAreaError(true);
    end;
}
