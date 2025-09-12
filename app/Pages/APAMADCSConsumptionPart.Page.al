/// <summary>
/// APA MADCS Consumption Part
/// Part page for managing consumption of components in production orders.
/// This page will be used within the main MADCS card to display and manage consumption data.
/// </summary>
page 55002 "APA MADCS Consumption Part"
{
    Caption = 'Consumption', Comment = 'ESP="Consumo"';
    PageType = ListPart;
    SourceTable = "Prod. Order Component";
    Editable = true;
    ModifyAllowed = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    ApplicationArea = All;
    Permissions =
        tabledata "Warehouse Entry" = r;

    layout
    {
        area(Content)
        {
            grid(Columns)
            {
                group(RepeaterGrp)
                {
                    ShowCaption = false;
                    Editable = false;

                    repeater(Control1)
                    {
                        ShowCaption = false;

                        field("Routing Link Code"; Rec."Routing Link Code")
                        {
                            Width = 1;
                            ToolTip = 'Specifies the routing link code associated with the component.', Comment = 'ESP="Indica el código de enlace de ruta asociado con el componente."';
                        }
                        field("Item No."; Rec."Item No.")
                        {
                            Width = 3;
                            ToolTip = 'Specifies the item number associated with the component.', Comment = 'ESP="Indica el número de artículo asociado con el componente."';
                        }
                        field(Description; Rec.Description)
                        {
                            Width = 4;
                            ToolTip = 'Specifies the description of the component.', Comment = 'ESP="Indica la descripción del componente."';
                        }
                        field("Consumo por resto"; Rec."Consumo por resto")
                        {
                            Width = 1;
                            Caption = 'CR', Comment = 'ESP="CR"';
                            ToolTip = 'Specifies the consumption by remainder of this component.', Comment = 'ESP="Indica el consumo por resto de este componente."';
                        }
                        field(Quantity; Rec."Expected Quantity")
                        {
                            Width = 2;
                            Caption = 'Pred. Q.', Comment = 'ESP="Q. Prev."';
                            ToolTip = 'Specifies the quantity of the component.', Comment = 'ESP="Indica la cantidad del componente."';
                        }
                        field("Consumed Quantity"; Rec."Expected Quantity" - Rec."Remaining Quantity")
                        {
                            Width = 2;
                            Caption = 'Cons. Q.', Comment = 'ESP="Q. Cons."';
                            ToolTip = 'Specifies the consumed quantity of the component.', Comment = 'ESP="Indica la cantidad consumida del componente."';
                        }
                        field("Qty. Picked"; Rec."Qty. Picked")
                        {
                            Width = 2;
                            Caption = 'Pick Q.', Comment = 'ESP="Q. Prep."';
                            ToolTip = 'Specifies the quantity of the component to pick for consumption.', Comment = 'ESP="Indica la cantidad del componente a recoger para el consumo."';
                        }
                    }
                }
                group(DataGrp)
                {
                    ShowCaption = false;

                    field("Item No. Search"; Rec."Item No.")
                    {
                        Caption = 'Item No.', Comment = 'ESP="Nº Prod."';
                        ToolTip = 'Specifies the item number to filter the components.', Comment = 'ESP="Indica el número de artículo para filtrar los componentes."';
                        Lookup = true;

                        trigger OnLookup(var Text: Text): Boolean
                        var
                            Item: Record Item;
                            ItemListPage: Page "Item List";
                        begin
                            ItemListPage.SetTableView(Item);
                            ItemListPage.LookupMode(true);
                            if ItemListPage.RunModal() = Action::LookupOK then begin
                                ItemListPage.GetRecord(Item);
                                Text := Item."No.";
                                exit(true);
                            end;
                        end;
                    }

                    /// <summary>
                    /// Field to select the lot number to consume, with lookup to available lots in the user's bin.
                    /// </summary>
                    field("Lot No. To Consume"; Rec."Lot No.")
                    {
                        Caption = 'Lot No.', Comment = 'ESP="Lote"';
                        ToolTip = 'Specifies the lot number to consume from available lots in your bin.', Comment = 'ESP="Indica el lote a consumir de los disponibles en su ubicación."';
                        Lookup = true;

                        trigger OnLookup(var Text: Text): Boolean
                        // Locate available lots in the component's bin
                        var
                            warehouseEntry: Record "Warehouse Entry";
                            tempLotNoInformation: Record "Lot No. Information" temporary;
                            APAMADCSLotNoInformation: Page "APA MADCS Lot No. Information";
                        begin
                            // Filter Item Ledger Entries for the current item, bin, and positive remaining quantity
                            Clear(APAMADCSLotNoInformation);
                            warehouseEntry.Reset();
                            warehouseEntry.SetCurrentKey("Item No.", "Variant Code", "Lot No.", "Location Code", "Bin Code");
                            warehouseEntry.SetRange("Item No.", Rec."Item No.");
                            warehouseEntry.SetRange("Variant Code", Rec."Variant Code");
                            warehouseEntry.SetFilter("Lot No.", '<>%1', ''); // Only entries with a lot number
                            warehouseEntry.SetRange("Location Code", Rec."Location Code");
                            warehouseEntry.SetRange("Bin Code", Rec."Bin Code");
                            if warehouseEntry.FindSet() then
                                // Show a lookup dialog for available lots
                                repeat
                                    // You could use a page for lookup, but for simplicity, just pick the first available lot
                                    APAMADCSLotNoInformation.AddRecord(warehouseEntry."Item No.", warehouseEntry."Variant Code", warehouseEntry."Lot No.", warehouseEntry."Expiration Date", warehouseEntry."Location Code", warehouseEntry."Bin Code");
                                until (warehouseEntry.Next() = 0);

                            APAMADCSLotNoInformation.LookupMode(true);
                            if APAMADCSLotNoInformation.RunModal() = Action::LookupOK then begin
                                APAMADCSLotNoInformation.GetRecord(tempLotNoInformation);
                                Text := tempLotNoInformation."Lot No.";
                                exit(true);
                            end else
                                exit(false);
                        end;
                    }
                    field("MADCS Quantity"; Rec."MADCS Quantity")
                    {
                        Caption = 'Qty. to Consume', Comment = 'ESP="Cant. a consumir"';
                        ToolTip = 'Specifies the quantity of the component to consume.', Comment = 'ESP="Indica la cantidad del componente a consumir."';
                        Editable = true;
                    }
                    field("Unit of Measure Code"; Rec."Unit of Measure Code")
                    {
                        ToolTip = 'Specifies the unit of measure for the component.', Comment = 'ESP="Indica la unidad de medida del componente."';
                        Editable = false;
                    }
                    usercontrol(ALButtonGroup; "APA MADCS ButtonGroup")
                    {
                        Visible = true;

                        trigger OnLoad()
                        begin
                            CurrPage.ALButtonGroup.AddButton('+Inc. Cant.', 'Incrementar Cantidad', 'ALButtonMoreQuantity', 'danger');
                            CurrPage.ALButtonGroup.AddButton('Cancelar', 'Cancelar', 'ALButtonCancel', 'normal');
                            CurrPage.ALButtonGroup.AddButton('Registrar', 'Registrar', 'ALButtonPost', 'primary');
                        end;

                        trigger OnClick(id: Text)
                        begin
                            // TODO: Implement button actions
                            Message('%1 button was clicked.', id);
                        end;
                    }
                }
            }
        }
    }
}