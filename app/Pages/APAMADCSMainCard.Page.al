/// <summary>
/// APA MADCS Main Card
/// Card page for ADCS users to view and input components, outputs, and time for a selected production order.
/// </summary>
page 55001 "APA MADCS Main Card"
{
    Caption = 'MADCS Main Card', Comment = 'ESP="Ficha principal MADCS"';
    PageType = Card;
    SourceTable = "Prod. Order Line";
    ApplicationArea = All;
    UsageCategory = Documents;
    Editable = true;
    InsertAllowed = false;
    DeleteAllowed = false;
    ModifyAllowed = true;

    layout
    {
        area(Content)
        {
            group(Verification)
            {
                // TODO: V2. Implement the verification part in the future
                Caption = 'Verificación', Comment = 'ESP="Verificación"';
                Visible = bVerification;

                part(VerificationPart; "APA MADCS Verification Part")
                {
                    SubPageLink = Status = field(Status),
                                  "Prod. Order No." = field("Prod. Order No.");
                }
            }
            group(Time)
            {
                Caption = 'Time', Comment = 'ESP="Tiempo"';
                Visible = bTime;

                part(TimePart; "APA MADCS Time Part")
                {
                    SubPageLink = Status = field(Status),
                                  "Prod. Order No." = field("Prod. Order No.");
                }
            }
            group(Stops)
            {
                // TODO: V2. Implement the stops part in the future
                Caption = 'Stops', Comment = 'ESP="Paradas"';
                Visible = bStops;

                part(StopsPart; "APA MADCS Stops Part")
                {
                    SubPageLink = Status = field(Status),
                                  "Prod. Order No." = field("Prod. Order No.");
                }
            }
            group(QualityMeasures)
            {
                // TODO: V2. Implement the quality measures part in the future
                Caption = 'Quality Measures', Comment = 'ESP="Medidas de Calidad"';
                Visible = bQualityMeasures;

                part(QualityMeasuresPart; "APA MADCS Quality MeasuresPart")
                {
                    SubPageLink = Status = field(Status),
                                  "Prod. Order No." = field("Prod. Order No.");
                }
            }
            group(Consumption)
            {
                Caption = 'Consumption', Comment = 'ESP="Consumo"';
                Visible = bConsumption;

                part(ConsumptionPart; "APA MADCS Consumption Part")
                {
                    SubPageLink = Status = field(Status),
                                  "Prod. Order No." = field("Prod. Order No.");
                }
            }
            group(Outputs)
            {
                Caption = 'Outputs', Comment = 'ESP="Salidas"';
                Visible = bOutputs;

                part(OutputsPart; "APA MADCS Outputs Part")
                {
                    SubPageLink = Status = field(Status),
                                  "Prod. Order No." = field("Prod. Order No.");
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {
            group(Options)
            {
                Caption = 'Process', Comment = 'ESP="Proceso"';

                action(VerificationAct)
                {
                    Caption = 'Verifications', Comment = 'ESP="Verificaciones"';
                    ToolTip = 'Manage verifications for the production order.', Comment = 'ESP="Gestiona las verificaciones para la orden de producción."';
                    Image = CheckList;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    Visible = false; // TODO: V2. Temporarily hide until implemented

                    trigger OnAction()
                    begin
                        // TODO: Do the job of showing the verification part
                        SetVisibility(Enum::"APA MADCS Visibility Options"::Verifications);
                        CurrPage.Update();
                    end;
                }

                action(TimeAct)
                {
                    Caption = 'Time', Comment = 'ESP="Tiempo"';
                    ToolTip = 'Manage the time tracking for the production order.', Comment = 'ESP="Gestiona el seguimiento del tiempo para la orden de producción."';
                    Image = Timeline;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        SetVisibility(Enum::"APA MADCS Visibility Options"::Time);
                        CurrPage.Update();
                    end;
                }

                action(StopsAct)
                {
                    Caption = 'Stops', Comment = 'ESP="Paradas"';
                    ToolTip = 'Manage stops for the production order.', Comment = 'ESP="Gestiona las paradas para la orden de producción."';
                    Image = Stop;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    Visible = false; // TODO: V2.Temporarily hide until implemented

                    trigger OnAction()
                    begin
                        // TODO: Do the job of showing the stops part
                        SetVisibility(Enum::"APA MADCS Visibility Options"::Stops);
                        CurrPage.Update();
                    end;
                }

                action(QualityMeasuresAct)
                {
                    Caption = 'Quality Measures', Comment = 'ESP="Medidas de Calidad"';
                    ToolTip = 'Manage quality measures for the production order.', Comment = 'ESP="Gestiona las medidas de calidad para la orden de producción."';
                    Image = Questionaire;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;
                    Visible = false; // TODO: V2. Temporarily hide until implemented

                    trigger OnAction()
                    begin
                        // TODO: Do the job of showing the quality measures part
                        SetVisibility(Enum::"APA MADCS Visibility Options"::"Quality Measures");
                        CurrPage.Update();
                    end;
                }

                action(ConsumptionAct)
                {
                    Caption = 'Consumption', Comment = 'ESP="Consumo"';
                    ToolTip = 'Manage the consumption of components for the production order.', Comment = 'ESP="Gestiona el consumo de componentes para la orden de producción."';
                    Image = ConsumptionJournal;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        SetVisibility(Enum::"APA MADCS Visibility Options"::Consumptions);
                        CurrPage.Update();
                    end;
                }

                action(OutputsAct)
                {
                    Caption = 'Outputs', Comment = 'ESP="Salidas"';
                    ToolTip = 'Manage the outputs for the production order.', Comment = 'ESP="Gestiona las salidas para la orden de producción."';
                    Image = OutputJournal;
                    Promoted = true;
                    PromotedOnly = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    ApplicationArea = All;

                    trigger OnAction()
                    begin
                        SetVisibility(Enum::"APA MADCS Visibility Options"::Outputs);
                        CurrPage.Update();
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    var
        APAMADCSPostingManagement: Codeunit "APA MADCS Posting Management";
    begin
        APAMADCSPostingManagement.LogAction(Rec, true);
        InitVisibility();
    end;

    trigger OnClosePage()
    var
        APAMADCSPostingManagement: Codeunit "APA MADCS Posting Management";
    begin
        APAMADCSPostingManagement.LogAction(Rec, false);
    end;

    var
        bVerification: Boolean;
        bConsumption: Boolean;
        bTime: Boolean;
        bOutputs: Boolean;
        bQualityMeasures: Boolean;
        bStops: Boolean;

    local procedure SetVisibility(optType: Enum "APA MADCS Visibility Options")
    begin
        bVerification := optType = Enum::"APA MADCS Visibility Options"::Verifications;
        bTime := optType = Enum::"APA MADCS Visibility Options"::Time;
        bStops := optType = Enum::"APA MADCS Visibility Options"::Stops;
        bQualityMeasures := optType = Enum::"APA MADCS Visibility Options"::"Quality Measures";
        bConsumption := optType = Enum::"APA MADCS Visibility Options"::Consumptions;
        bOutputs := optType = Enum::"APA MADCS Visibility Options"::Outputs;
    end;

    local procedure InitVisibility()
    begin
        bVerification := false;
        bTime := true;
        bStops := false;
        bQualityMeasures := false;
        bConsumption := false;
        bOutputs := false;
    end;
}
