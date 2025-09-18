/// <summary>
/// APA MADCS Time Part
/// Part page for managing time tracking in production orders.
/// This page will be used within the main MADCS card to display and manage time data.
/// </summary>
page 55003 "APA MADCS Time Part"
{
    Caption = 'Time', Comment = 'ESP="Tiempo"';
    PageType = ListPart;
    SourceTable = "APA MADCS Pro. Order Line Time";
    SourceTableView = where("End" = const(false));
    Editable = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = true;
    ApplicationArea = All;

    layout
    {
        area(Content)
        {
            group(RepeaterGrp)
            {
                ShowCaption = false;
                Editable = false;

                repeater(Control1)
                {
                    ShowCaption = false;

                    field(Status; Rec.Status)
                    {
                        Visible = false;
                        Width = 1;
                    }
                    field("Prod. Order No."; Rec."Prod. Order No.")
                    {
                        Visible = false;
                        Width = 1;
                    }
                    field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                    {
                        Visible = false;
                        Width = 1;
                    }
                    field("Line No."; Rec."Line No.")
                    {
                        Visible = false;
                        Width = 1;
                    }
                    field("Operator Code"; Rec."Operator Code")
                    {
                        Visible = true;
                        Width = 1;
                    }
                    field("Date Time"; Rec."Date Time")
                    {
                        Visible = true;
                        Width = 1;
                    }
                    field("Action"; Rec."Action")
                    {
                        Visible = true;
                        Width = 1;
                    }
                    field("BreakDown Code"; Rec."BreakDown Code")
                    {
                        Visible = true;
                        Width = 1;
                    }
                    field("End"; Rec."End")
                    {
                        Visible = false;
                        Width = 1;
                    }
                }
            }
            group(InfButtonGrp)
            {
                ShowCaption = false;

                usercontrol(ALInfButtonGroup; "APA MADCS ButtonGroup")
                {
                    Visible = true;

                    trigger OnLoad()
                    var
                        PreparationLbl: Label 'Preparation', Comment = 'ESP="Preparación"';
                        ExecutionLbl: Label 'Execution', Comment = 'ESP="Ejecución"';
                        CleanLbl: Label 'Cleaning', Comment = 'ESP="Limpieza"';
                        PreparationTextLbl: Label 'Init preparation phase', Comment = 'ESP="Iniciar fase de preparación"';
                        ExecutionTextLbl: Label 'Init execution phase', Comment = 'ESP="Iniciar fase de ejecución"';
                        CleanTextLbl: Label 'Init cleaning phase', Comment = 'ESP="Iniciar fase de limpieza"';
                    begin
                        CurrPage.ALInfButtonGroup.AddButton(PreparationLbl, PreparationTextLbl, ALButtonPreparationTok, NormalButtonTok);
                        CurrPage.ALInfButtonGroup.AddButton(ExecutionLbl, ExecutionTextLbl, ALButtonExecutionTok, NormalButtonTok);
                        CurrPage.ALInfButtonGroup.AddButton(CleanLbl, CleanTextLbl, ALButtonCleaningTok, NormalButtonTok);
                    end;

                    trigger OnClick(id: Text)
                    begin
                        // TODO: Implement button actions
                        Message('%1 button was clicked.', id);
                    end;
                }
            }
            group(DataGro)
            {
                ShowCaption = false;

                field(StopCode;StopCode)
                {
                    Caption = 'Stop Code', Comment = 'ESP="Código de Paro"';
                    ToolTip = 'Specifies the stop code for the breakdown.', Comment = 'ESP="Especifica el código de paro para la avería."';
                    Editable = true;
                    TableRelation = "DC Detalles de paro";

                    trigger OnValidate()
                    begin
                        // TODO: If Stop Code is disabling, finalize the current operation
                    end;
                }
                usercontrol(ALRightButtonGroup; "APA MADCS ButtonGroup")
                {
                    Visible = true;

                    trigger OnLoad()
                    var
                        BreakDownLbl: Label 'Breakdown', Comment = 'ESP="Avería"';
                        BreakDownTextLbl: Label 'Register breakdown', Comment = 'ESP="Registrar avería"';
                    begin
                        CurrPage.ALRightButtonGroup.AddButton(BreakDownLbl, BreakDownTextLbl, ALButtonBreakdownTok, NormalButtonTok);
                    end;

                    trigger OnClick(id: Text)
                    begin
                        // TODO: Implement button actions
                        Message('%1 button was clicked.', id);
                    end;
                }
            }
            usercontrol(ALEndButtonGroup; "APA MADCS ButtonGroup")
            {
                Visible = true;

                trigger OnLoad()
                begin
                    CurrPage.ALEndButtonGroup.AddButton('Fin Estado', 'Finalizar la fase activa', 'ALButtonEnd', PrimaryButtonTok);
                end;

                trigger OnClick(id: Text)
                begin
                    // TODO: Implement button actions
                    Message('%1 button was clicked.', id);
                end;
            }
        }
    }

    var
        StopCode: Code[20];
        NormalButtonTok: Label 'normal', Locked = true;
        PrimaryButtonTok: Label 'primary', Locked = true;
        ALButtonPreparationTok: Label 'ALButtonPreparation', Locked = true;
        ALButtonExecutionTok: Label 'ALButtonExecution', Locked = true;
        ALButtonCleaningTok: Label 'ALButtonCleaning', Locked = true;
        ALButtonBreakdownTok: Label 'ALButtonBreakdown', Locked = true;
}