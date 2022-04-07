codeunit 50100 "Enable Escrow Extension"
{
    // Extend and modify Essential experience tier with "EscrowApplication"
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Application Area Mgmt.", 'OnGetEssentialExperienceAppAreas', '', false, false)]
    local procedure RegisterExampleExtensionOnGetEssentialExperienceAppAreas(var TempApplicationAreaSetup: Record "Application Area Setup" temporary)begin
        TempApplicationAreaSetup."EscrowApplication":=true;
    // Modify other application areas here
    end;
    // Validate that application areas needed for the extension are enabled
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Application Area Mgmt.", 'OnValidateApplicationAreas', '', false, false)]
    local procedure VerifyApplicationAreasOnValidateApplicationAreas(ExperienceTierSetup: Record "Experience Tier Setup";
    TempApplicationAreaSetup: Record "Application Area Setup" temporary)begin
        if ExperienceTierSetup.Essential then if not TempApplicationAreaSetup."EscrowApplication" then Error('EscrowApplication should be part of Essential in order for the Example Extension to work.');
    end;
    // Helpers ................................................................
    procedure IsEscrowApplicationAreaEnabled(): Boolean var ApplicationAreaSetup: Record "Application Area Setup";
    ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        if ApplicationAreaMgmtFacade.GetApplicationAreaSetupRecFromCompany(ApplicationAreaSetup, CompanyName())then exit(ApplicationAreaSetup."EscrowApplication");
    end;
    procedure EnableEscrowExtension()var ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        ApplicationAreaMgmtFacade.RefreshExperienceTierCurrentCompany();
    end;
    procedure DisableEscrowExtension()var ApplicationAreaMgmtFacade: Codeunit "Application Area Mgmt. Facade";
    begin
        ApplicationAreaMgmtFacade.SetHideApplicationAreaError(true);
    end;
}
