/// <summary>
/// APA MADCS Prod. Order Component Extension
/// Extends the Prod. Order Component table to add ADCS-related functionality for automated data capture system.
/// This extension adds fields to track quantities captured through the ADCS system.
/// </summary>
tableextension 55002 "APA MADCS Prod. Order Componen" extends "Prod. Order Component"
{
    fields
    {
        field(55000; "MADCS Quantity"; Decimal)
        {
            Caption = 'MADCS Quantity', Comment = 'ESP="Cantidad MADCS"';
            DataClassification = SystemMetadata;
            ToolTip = 'Specifies the quantity captured through the Automated Data Capture System (MADCS).', Comment = 'ESP="Especifica la cantidad capturada a través del Sistema Automatizado de Captura de Datos (MADCS)."';

            trigger OnValidate()
            begin
                // TODO: Add validation logic for ADCS quantity if needed
                if "MADCS Quantity" < 0 then
                    FieldError("MADCS Quantity", NegativeQuantityNotAllowedLbl);
            end;
        }
    }

    var
        NegativeQuantityNotAllowedLbl: Label 'Negative quantity is not allowed.', Comment = 'ESP="No se permite cantidad negativa."';
}
