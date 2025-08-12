pageextension 50505 "WAPP TimeSheet Card" extends "WAPP TimeSheet Card" //50252
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
        addlast(Processing)
        {
            action("Crear Diario proyectos.")
            {
                ApplicationArea = all;
                Caption = 'Crear Diario de proyectos';
                // Enabled = CosteBoolean;
                Visible = false;
                trigger OnAction()
                var
                    myInt: Integer;
                    //ControldeProcesos: Codeunit EventosRadial;
                    ControldeProcesos: Codeunit Procesos;
                    Lines: Record "WAPP TimeSheets Lines";
                    Text001: Label 'Nothing to invoice';
                begin
                    Lines.SetRange("TimeSheet No.", Rec."TimeSheet No.");
                    if Not Lines.FindFirst() Then Error(Text001);
                    ControldeProcesos.CrearDiarioProyectos(Lines);
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        ConfSetup.Get();
        case ConfSetup."Aplicar Tipo" of
            ConfSetup."Aplicar Tipo"::Coste:
                begin
                    CosteBoolean := true;
                    FacturacionBoolean := false;
                end;
            ConfSetup."Aplicar Tipo"::Factura:
                begin
                    CosteBoolean := false;
                    FacturacionBoolean := true;
                end;
        end;
    end;

    var
        ConfSetup: Record "Jobs Setup";
        CosteBoolean: Boolean;
        FacturacionBoolean: Boolean;
}