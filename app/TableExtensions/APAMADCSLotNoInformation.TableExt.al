/// <summary>
/// APA MADCS Lot No. Information Extension
/// </summary>
tableextension 55001 "APA MADCS Lot No. Information" extends "Lot No. Information"
{
    fields
    {
        field(55000; "Warehouse Inventory"; Decimal)
        {
            Caption = 'Warehouse Inventory', Comment = 'ESP="Inventario de almacén"';
            ToolTip = 'Specifies the inventory quantity for the item/lot.', Comment = 'ESP="Especifica la cantidad de inventario del lote del producto."';
            CalcFormula = sum("Warehouse Entry".Quantity where("Item No." = field("Item No."),
                                                               "Variant Code" = field("Variant Code"),
                                                               "Lot No." = field("Lot No."),
                                                               "Location Code" = field("Location Filter"),
                                                               "Bin Code" = field("Bin Filter")));
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
    }
}
