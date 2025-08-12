pageextension 50506 "WAPP TimeSheet Lines" extends "WAPP TimeSheet Lines" //50253
{
    layout
    {
        addafter(Marked)
        {

            field("Llevar al Diario"; Rec."Llevar al Diario")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Llevar al Diario field.', Comment = '%';
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action("Mark Selected al Diario")
            {

                // Caption = 'Mark Selected', comment = 'ESP="Marcar Seleccion"';
                Caption = 'Marcar para Diario de Proyectos';
                ApplicationArea = All;
                Image = Select;
                trigger OnAction()
                var
                    TimeLines: Record "WAPP TimeSheets Lines";
                begin
                    CurrPage.SetSelectionFilter(TimeLines);
                    TimeLines.ModifyAll(TimeLines."Llevar al Diario", true);
                end;

            }
            action("Un Mark Selected al Diario")
            {
                Caption = 'Desmarcar al Diario';
                ApplicationArea = All;
                Image = Undo;
                trigger OnAction()
                var
                    TimeLines: Record "WAPP TimeSheets Lines";
                begin
                    CurrPage.SetSelectionFilter(TimeLines);
                    TimeLines.ModifyAll(TimeLines."Llevar al Diario", false);
                end;

            }
        }
    }

    var
        myInt: Integer;
}