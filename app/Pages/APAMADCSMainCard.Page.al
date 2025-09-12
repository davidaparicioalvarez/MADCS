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
                        bConsumption := true;
                        bTime := false;
                        bOutputs := false;
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
                        bConsumption := false;
                        bTime := true;
                        bOutputs := false;
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
                        bConsumption := false;
                        bTime := false;
                        bOutputs := true;
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
        bConsumption := true;
        bTime := false;
        bOutputs := false;
    end;

    trigger OnClosePage()
    var
        APAMADCSPostingManagement: Codeunit "APA MADCS Posting Management";
    begin
        APAMADCSPostingManagement.LogAction(Rec, false);
    end;

    var
        bConsumption: Boolean;
        bTime: Boolean;
        bOutputs: Boolean;
}
