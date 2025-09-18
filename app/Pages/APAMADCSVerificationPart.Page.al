/// <summary>
/// APA MADCS Verification Part
/// Part page for managing Verification in production orders.
/// This page will be used within the main MADCS card to display and manage output data.
/// </summary>
page 55006 "APA MADCS Verification Part"
{
    // TODO:
    Caption = 'Verification', Comment = 'ESP="Verificación"';
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

                    }
                }
                group(DataGrp)
                {
                    ShowCaption = false;

                }
            }
        }
    }

    var
}