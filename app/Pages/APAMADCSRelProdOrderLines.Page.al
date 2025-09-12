/// <summary>
/// APA MADCS Released Production Order Lines
/// List page for ADCS users to select a released production order.
/// </summary>
page 55000 "APA MADCS Rel Prod Order Lines"
{
    Caption = 'MADCS Released Production Orders Lines', Comment = 'ESP="Líneas de órdenes de producción lanzadas MADCS"';
    PageType = List;
    SourceTable = "Prod. Order Line";
    ApplicationArea = All;
    UsageCategory = Lists;
    Editable = false;
    SourceTableView = where(Status = const(Released));

    // TODO: Add filtering to show only orders assigned to a user or to a work center

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field(Priority; Rec.Priority)
                {
                    ToolTip = 'Specifies the priority of the production order.', Comment = 'ESP="Especifica la prioridad de la orden de producción."';
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ToolTip = 'Specifies the production order number.', Comment = 'ESP="Especifica el número de orden de producción."';
                }
                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the item number of the item to manufacture.', Comment = 'ESP="Especifica el número de artículo del producto a fabricar."';
                }
                field("Description"; Rec.Description)
                {
                    ToolTip = 'Specifies the description of the item to manufacture.', Comment = 'ESP="Especifica la descripción del producto a fabricar."';
                }
                field(Quantity; Rec.Quantity)
                {
                    ToolTip = 'Specifies the quantity to produce.', Comment = 'ESP="Especifica la cantidad a producir."';
                }
                field("Finished Quantity"; Rec."Finished Quantity")
                {
                    ToolTip = 'Specifies the finished quantity of the item.', Comment = 'ESP="Especifica la cantidad terminada del producto."';
                }
                field("Starting Date-Time"; Rec."Starting Date-Time")
                {
                    ToolTip = 'Specifies the starting date and time for the production order.', Comment = 'ESP="Especifica la fecha y hora de inicio de la orden de producción."';
                }
                field("Ending Date-Time"; Rec."Ending Date-Time")
                {
                    ToolTip = 'Specifies the ending date and time for the production order.', Comment = 'ESP="Especifica la fecha y hora de finalización de la orden de producción."';
                }
                field("APA MADCS User Working"; Rec."APA MADCS User Working")
                {
                    Editable = false;
                    Visible = false;
                    ToolTip = 'Specifies the user currently working with this production order.', Comment = 'ESP="Especifica el usuario que está trabajando con esta orden de producción."';
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(OpenOrder)
            {
                Caption = 'Open', Comment = 'ESP="Abrir"';
                ToolTip = 'Open the selected production order and start working on it.', Comment = 'ESP="Abrir la orden de producción seleccionada y empezar a trabajar en ella."';
                ApplicationArea = All;
                Image = EditLines;

                trigger OnAction()
                var
                    ProductionOrderLine: Record "Prod. Order Line";
                    LabelOrderNotFoundLbl: Label 'The selected production order could not be found.', Comment = 'ESP="No se pudo encontrar la orden de producción seleccionada."';
                begin
                    // Get requires both No. and Status as primary key for Production Order
                    Clear(ProductionOrderLine);
                    ProductionOrderLine.SetCurrentKey(Status, "Prod. Order No.", "Line No.");
                    ProductionOrderLine.SetRange(Status, Rec.Status);
                    ProductionOrderLine.SetRange("Prod. Order No.", Rec."Prod. Order No.");
                    if not ProductionOrderLine.FindFirst() then
                        Error(LabelOrderNotFoundLbl); // ESP="No se pudo encontrar la orden de producción seleccionada."
                    PAGE.RunModal(PAGE::"APA MADCS Main Card", ProductionOrderLine);
                end;
            }
        }
    }
}
