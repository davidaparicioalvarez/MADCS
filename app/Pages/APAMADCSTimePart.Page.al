/// <summary>
/// APA MADCS Time Part
/// Part page for managing time tracking in production orders.
/// This page will be used within the main MADCS card to display and manage time data.
/// </summary>
page 55003 "APA MADCS Time Part"
{
    Caption = 'Time', Comment = 'ESP="Tiempo"';
    PageType = ListPart;
    SourceTable = "Prod. Order Routing Line";
    Editable = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    ApplicationArea = All;

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
                            Caption = 'Routing Link Code', Comment = 'ESP="Con. Ruta"';
                            ToolTip = 'Specifies the routing link code associated with the operation.', Comment = 'ESP="Indica el código de enlace de ruta asociado con la operación."';
                            Width = 1;
                        }
                        field("Operation No."; Rec."Operation No.")
                        {
                            Caption = 'Operation No.', Comment = 'ESP="Nº Oper."';
                            ToolTip = 'Specifies the operation number.', Comment = 'ESP="Indica el número de operación."';
                            Width = 1;
                        }
                        field(Description; Rec.Description)
                        {
                            Caption = 'Description', Comment = 'ESP="Descripción"';
                            ToolTip = 'Specifies the description of the operation.', Comment = 'ESP="Indica la descripción de la operación."';
                            Width = 1;
                        }
                        field("Setup Time"; Rec."Setup Time")
                        {
                            Caption = 'S.T.', Comment = 'ESP="T.C."';
                            ToolTip = 'Specifies the setup time for the operation.', Comment = 'ESP="Indica el tiempo de preparación para la operación."';
                            Width = 1;
                        }
                        field("Run Time"; Rec."Run Time")
                        {
                            Caption = 'R.T.', Comment = 'ESP="T.P."';
                            ToolTip = 'Specifies the run time for the operation.', Comment = 'ESP="Indica el tiempo de ejecución para la operación."';
                            Width = 1;
                        }
                        field("Run Time Unit of Meas. Code"; Rec."Run Time Unit of Meas. Code")
                        {
                            Caption = 'UM', Comment = 'ESP="UM"';
                            ToolTip = 'Specifies the unit of measure code for the run time.', Comment = 'ESP="Indica el código de unidad de medida para el tiempo de ejecución."';
                            Width = 1;
                        }
                    }
                }
                group(DataGrp)
                {
                    ShowCaption = false;

                    usercontrol(ALSupButtonGroup; "APA MADCS ButtonGroup")
                    {
                        Visible = true;

                        trigger OnLoad()
                        begin
                            CurrPage.ALSupButtonGroup.AddButton('Foto', 'Mostrar Fotos relacionadas con la fabricación', 'ALButtonPhoto', 'normal');
                            CurrPage.ALSupButtonGroup.AddButton('Video', 'Mostrar Videos relacionados con la fabricación', 'ALButtonVideo', 'normal');
                            CurrPage.ALSupButtonGroup.AddButton('Med. Calidad', 'Tomar Medidas de Calidad', 'ALButtonQualityMeasures', 'normal');
                            CurrPage.ALSupButtonGroup.AddButton('Terminar Op.', 'Terminar Órden Fabricación', 'ALButtonFinish', 'normal');
                        end;

                        trigger OnClick(id: Text)
                        begin
                            // TODO: Implement button actions
                            Message('%1 button was clicked.', id);
                        end;
                    }

                    field("Operation No.2"; Rec."Operation No.")
                    {
                        Caption = 'Operation No.', Comment = 'ESP="Nº Oper."';
                        ToolTip = 'Specifies the operation number.', Comment = 'ESP="Indica el número de operación."';
                        Editable = false;
                        Width = 1;
                    }

                    field(Description2; Rec.Description)
                    {
                        Caption = 'Description', Comment = 'ESP="Descripción"';
                        ToolTip = 'Specifies the description of the operation.', Comment = 'ESP="Indica la descripción de la operación."';
                        Editable = false;
                        Width = 1;
                    }

                    field(Operator; OperatorNo)
                    {
                        Caption = 'Operator', Comment = 'ESP="Operario"';
                        ToolTip = 'Specifies the operator number performing the operation.', Comment = 'ESP="Indica el número de operario que realiza la operación."';
                    }

                    field(TimeType; TimeType)
                    {
                        Caption = 'Type', Comment = 'ESP="Tipo"';
                        ToolTip = 'Specifies the type of time being recorded (e.g., setup, run, wait).', Comment = 'ESP="Indica el tipo de tiempo que se está registrando (p. ej., preparación, ejecución, espera)."';
                    }

                    usercontrol(ALInfButtonGroup; "APA MADCS ButtonGroup")
                    {
                        Visible = true;

                        trigger OnLoad()
                        begin
                            CurrPage.ALInfButtonGroup.AddButton('Cancelar', 'Salir de la ventana', 'ALButtonCancel', 'normal');
                            CurrPage.ALInfButtonGroup.AddButton('Iniciar', 'Iniciar tiempo', 'ALButtonInit', 'primary');
                            CurrPage.ALInfButtonGroup.AddButton('Trabajos en curso', 'Mostrar Trabajos en Curso', 'ALButtonQualityWIP', 'normal');
                            CurrPage.ALInfButtonGroup.AddButton('Lecciones aprendidas', 'Mostrar Lecciones Aprendidas', 'ALButtonShow', 'normal');
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


        // TODO: Asign operator to a table
    }

    var
        OperatorNo: Integer;
        TimeType: Enum "Routing Time Type";
}