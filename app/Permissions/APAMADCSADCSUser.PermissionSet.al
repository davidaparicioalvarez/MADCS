/// <summary>
/// APA MADCS ADCS User
/// Permission set for ADCS users to access MADCS extension objects.
/// </summary>
permissionset 55000 "APA MADCS ADCS User"
{
    Caption = 'MADCS ADCS User', MaxLength = 30, Comment = 'ESP="Usuario ADCS MADCS"';
    Permissions =
        tabledata "APA MADCS User Log" = RIMD,
        tabledata "Production Order" = R,
        tabledata "Prod. Order Component" = RIMD,
        tabledata "Item Journal Line" = RIMD,
        tabledata "APA MADCS Pro. Order Line Time" = RIMD,
        table "APA MADCS User Log" = X,
        codeunit "APA MADCS Posting Management" = X,
        page "APA MADCS Rel Prod Order Lines" = X,
        page "APA MADCS Main Card" = X,
        page "APA MADCS Consumption Part" = X,
        page "APA MADCS Outputs Part" = X,
        page "APA MADCS Time Part" = X,
        page "APA MADCS Lot No. Information" = X,
        page "APA MADCS Verification Part" = X,
        page "APA MADCS Stops Part" = X,
        page "APA MADCS Quality MeasuresPart" = X;
}
