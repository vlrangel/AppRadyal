page 50201 LineasPartesWeb
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "WAPP TimeSheets Lines";
    Editable = true;
    Caption = 'Lineas de Partes de Horas';

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("TimeSheet No."; Rec."TimeSheet No.")
                {
                    //DrillDown = true;
                    // TableRelation = "WAPP TimeSheets"."TimeSheet No.";
                    LookupPageId = "WAPP TimeSheet Card";
                    ToolTip = 'Specifies the value of the Nº Parte Horas field.';
                }
                field("Resource No."; Rec."Resource No.")
                {
                    ToolTip = 'Specifies the value of the Nº Recurso field.';
                }
                field("Nombre Recurso"; "Nombre Recurso")
                {
                    ToolTip = 'Specifies the value of the name resource field.';

                }

                field("Job No."; Rec."Job No.")
                {
                    ToolTip = 'Specifies the value of the Nº Proyecto field.';
                }
                field("Job Description"; Rec."Job Description")
                {
                    ToolTip = 'Specifies the value of the Proyecto field.';
                }

                field("Job Task No."; Rec."Job Task No.")
                {
                    ToolTip = 'Specifies the value of the Nº Tarea field.';
                }
                field("Job Task Description"; Rec."Job Task Description")
                {
                    ToolTip = 'Specifies the value of the Tarea field.';
                }
                field(Hours; Rec.Hours)
                {
                    ToolTip = 'Specifies the value of the Horas field.';
                }
                field("Work Type Code"; Rec."Work Type Code")
                {
                    ToolTip = 'Specifies the value of the Cód. Tipo Trabajo field.';
                }
                field("Work Type Description"; Rec."Work Type Description")
                {
                    ToolTip = 'Specifies the value of the Tipo Trabajo field.';
                }

                field(Marked; Rec.Marked)
                {
                    ToolTip = 'Specifies the value of the Marked field.';
                }

                field("Ok Jefe"; Rec."Ok Jefe")
                {
                    ToolTip = 'Specifies the value of the Ok Jefe field.';
                }
                field("Llevar al Diario"; Rec."Llevar al Diario")
                {
                    ToolTip = 'Specifies the value of the Llevar al Diario field.', Comment = '%';
                }
                field(Completed; Rec.Completed)
                {
                    ToolTip = 'Specifies the value of the Completado field.';
                }


                field("Activity Code"; Rec."Activity Code")
                {
                    ToolTip = 'Specifies the value of the Cód. Actividad field.';
                }
                field("Activity Description"; Rec."Activity Description")
                {
                    ToolTip = 'Specifies the value of the Actividad field.';
                }
                field(Blocked; Rec.Blocked)
                {
                    ToolTip = 'Specifies the value of the Bloqueado field.';
                }
                field(Bloked; Rec.Bloked)
                {
                    ToolTip = 'Specifies the value of the Blocked field.';
                }
                field("Date"; Rec."Date")
                {
                    ToolTip = 'Specifies the value of the Fecha field.';
                }
                field(Description; Rec.Description)
                {
                    ToolTip = 'Specifies the value of the Descripción field.';
                }
                field(Holiday; Rec.Holiday)
                {
                    ToolTip = 'Specifies the value of the Festivo field.';
                }
                field(Invoiced; Rec.Invoiced)
                {
                    ToolTip = 'Specifies the value of the Invoiced field.';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {

            action("Control imputacion Recursos")
            {
                ApplicationArea = All;

                //    RunObject = page "Horas recursos";
            }
            action(EditarPagina)
            {
                ApplicationArea = All;
                Visible = false;

                trigger OnAction()
                begin
                    ppagEditable := false;
                    CurrPage.Editable(ppagEditable);
                    CurrPage.Update(true);
                end;
            }
            action("Create Invoice by TimeSheet")
            {
                ApplicationArea = All;
                Caption = 'Create Invoice by Resource';
                Image = NewInvoice;
                Visible = false;
                trigger OnAction()
                var
                    Lines: Record "WAPP TimeSheets Lines";
                    Text001: Label 'Nothing to invoice';
                // ControldeProcesos: Codeunit ControlDeProcesos;
                begin

                    Lines.SetRange("TimeSheet No.", Rec."TimeSheet No.");
                    Lines.SetRange(Marked, true);
                    Lines.SetRange("Ok Jefe", true);
                    if Not Lines.FindFirst() Then Error(Text001);
                    //  ControldeProcesos.Facturar(Lines);
                end;
            }
            action("Crear Diario proyectos")
            {
                ApplicationArea = all;
                Caption = 'Crear Diario de proyectos';
                // Enabled = CosteBoolean;
                trigger OnAction()
                var
                    myInt: Integer;
                    ControldeProcesos: Codeunit Procesos;
                    Lines: Record "WAPP TimeSheets Lines";
                    Text001: Label 'Nothing to lines';
                begin

                    Lines.SetRange("TimeSheet No.", Rec."TimeSheet No.");
                    Lines.SetRange("Ok Jefe", true);
                    Lines.SetRange(Marked, true);
                    Lines.SetRange(Invoiced, false);
                    Lines.SetRange("Llevar al Diario", true);

                    if Not Lines.FindFirst() Then Error(Text001);
                    ControldeProcesos.CrearDiarioProyectos(Lines);
                    //  ControldeProcesos.CrearDiarioProyectos();
                end;
            }
            action(Marcar)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    Lines: Record "WAPP TimeSheets Lines";
                begin
                    SetSelectionFilter(Rec);
                    // rec.Marked := true;
                    rec.ModifyAll(rec.Marked, true);
                end;
            }
            action(Desmarcar)
            {
                ApplicationArea = All;

                trigger OnAction()
                var
                    Lines: Record "WAPP TimeSheets Lines";
                begin
                    SetSelectionFilter(Rec);
                    // rec.Marked := true;
                    rec.ModifyAll(rec.Marked, false);
                end;
            }


            action("Marcar Lineas para el  Diario")
            {
                Image = Select;
                ApplicationArea = All;
                Caption = 'Marcar lineas para el Diario';
                ToolTip = 'Las lineas que esten marcadas SI generaran Lineas en el Diario de Proyecto';

                trigger OnAction()
                var
                    Lines: Record "WAPP TimeSheets Lines";
                begin
                    SetSelectionFilter(Rec);
                    rec.ModifyAll(rec."Llevar al Diario", true);
                end;
            }
            action("Un Mark Selected al Diario")
            {
                Caption = 'Desmarcar Lineas para el Diario de Proyecto';
                ApplicationArea = All;
                Image = Undo;
                ToolTip = 'Las lineas que esten desmarcada NO generaran Lineas en el Diario de Proyecto';
                trigger OnAction()
                var
                    TimeLines: Record "WAPP TimeSheets Lines";
                begin
                    CurrPage.SetSelectionFilter(TimeLines);
                    TimeLines.ModifyAll(TimeLines."Llevar al Diario", false);
                end;

            }
            action(Responsable)
            {
                ApplicationArea = All;
                Caption = 'Marcar de Responsable';

                trigger OnAction()
                var
                    Lines: Record "WAPP TimeSheets Lines";
                begin
                    SetSelectionFilter(Rec);
                    // rec.Marked := true;
                    rec.ModifyAll(rec."Ok Jefe", true);
                end;
            }
            action("Desmarcar Responsable")
            {
                ApplicationArea = All;
                Caption = 'DesMarcar de Responsable';

                trigger OnAction()
                var
                    Lines: Record "WAPP TimeSheets Lines";
                begin
                    SetSelectionFilter(Rec);
                    // rec.Marked := true;
                    rec.ModifyAll(rec."Ok Jefe", false);
                end;
            }

        }
    }



    trigger OnOpenPage()
    begin
        ppagEditable := true;
        CurrPage.Editable(ppagEditable);
        CurrPage.Update(true);
    end;




    procedure PaginaEditable()
    begin
        ppagEditable := true;
        CurrPage.Editable(ppagEditable);
        CurrPage.Update(true);
    end;

    trigger OnAfterGetRecord()
    begin
        Clear("Nombre Recurso");
        Clear("Coste Recurso");
        if RResource.Get(rec."Resource No.") then begin
            "Nombre Recurso" := RResource.Name;
            "Coste Recurso" := RResource."Unit Cost";
        end else begin
            Clear("Nombre Recurso");
            Clear("Coste Recurso");
        end;
        /*
                ///>>>>
                Clear(Precio1);
                Clear(Precio2);
                Clear(SalarioAnual);
                LinesHisContrato.SetRange(Empleado, Rec."Resource No.");
                LinesHisContrato.SetRange("Tarifa Actúal", true);
                if LinesHisContrato.FindFirst() then begin
                    Precio1 := LinesHisContrato."Tarifa 1";
                    Precio2 := LinesHisContrato."Tarifa 2";
                    SalarioAnual := LinesHisContrato."Salario Año";
                end else begin
                    Clear(Precio1);
                    Clear(Precio2);
                    Clear(SalarioAnual);
                end;
                ///>>>>>
        */
    end;

    var
        "Nombre Recurso": Text[150];
        RResource: Record Resource;
        RProyecto: Record Job;
        "Nombre Proyecto": Text[150];
        "Coste Recurso": Decimal;
        //   LinesHisContrato: Record "Lin Hist contrato empleado";
        Precio1: Decimal;
        Precio2: Decimal;
        SalarioAnual: Decimal;
        ppagEditable: Boolean;
        ConfSetup: Record "Jobs Setup";

        CosteBoolean: Boolean;
        FacturacionBoolean: Boolean;
}