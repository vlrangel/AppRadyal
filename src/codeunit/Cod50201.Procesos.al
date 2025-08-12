codeunit 50201 Procesos
{
    trigger OnRun()
    begin

    end;


    procedure CrearDiarioProyectos(var Lines: Record "WAPP TimeSheets Lines")
    var
        DiarioProyecto: Record "Job Journal Line";
        DiarioLineas: Record "Job Journal Line";
        DiarioComprobar: Record "Job Journal Line";
        ConfSetupJob: Record "Jobs Setup";
        nline: Integer;
        Recurso: Record Resource;

    begin
        ConfSetupJob.Get();
        ConfSetupJob.TestField("Journal Batch Name");
        ConfSetupJob.TestField("Journal Template Name");

        Lines.SetRange(Marked, true);
        Lines.SetRange("TimeSheet No.");
        //esta funcion estaba en la app parte de horas, se ha creado el campo llevar al diario, para que marque aquellas lineas que quiere llevar
        //al diario.
        Lines.SetRange("Llevar al Diario", true);
        if Lines.FindFirst() then begin
            repeat
                DiarioProyecto.Validate(DiarioProyecto."Journal Template Name", ConfSetupJob."Journal Template Name");
                DiarioProyecto.Validate(DiarioProyecto."Journal Batch Name", ConfSetupJob."Journal Batch Name");

                DiarioComprobar.SetRange("Time Sheet No.1", Lines."TimeSheet No.");
                DiarioComprobar.SetRange("Time Sheet Line No.", Lines."Line No.");
                if not DiarioComprobar.FindFirst() then begin


                    DiarioLineas.SetRange(DiarioLineas."Journal Template Name", ConfSetupJob."Journal Template Name");
                    DiarioLineas.SetRange(DiarioLineas."Journal Batch Name", ConfSetupJob."Journal Batch Name");
                    if DiarioLineas.FindLast() then
                        nline := DiarioLineas."Line No." + 10000
                    else
                        nline := nline + 10000;

                    // DiarioProyecto.SetUpNewLine(DiarioProyecto);
                    DiarioProyecto.SetUpNewLine(DiarioLineas);
                    DiarioProyecto."Line No." := nline;
                    DiarioProyecto."Line Type" := DiarioProyecto."Line Type"::Budget;
                    DiarioProyecto.Validate("Job No.", Lines."Job No.");
                    DiarioProyecto.Validate("Job Task No.", Lines."Job Task No.");
                    DiarioProyecto.Validate(Type, DiarioProyecto.Type::Resource);
                    DiarioProyecto.Validate("No.", Lines."Resource No.");
                    DiarioProyecto.Validate("Work Type Code", Lines."Work Type Code");
                    DiarioProyecto.Validate("Posting Date", Lines.Date);
                    DiarioProyecto.Validate(Quantity, Lines.Hours);



                    //if Recurso.get(Lines."Resource No.") then
                    //    DiarioProyecto.Validate("Unit Cost", Recurso."Unit Cost");
                    //DiarioProyecto."Time Sheet No." := Lines."TimeSheet No.";

                    DiarioProyecto."Time Sheet No.1" := Lines."TimeSheet No.";
                    DiarioProyecto."Time Sheet Line No." := Lines."Line No.";
                    DiarioProyecto."Time Sheet Date" := Lines.Date;
                    DiarioProyecto.Insert(true);

                    if Lines.Description <> '' then begin
                        DiarioProyecto.Description := CopyStr(Lines.Description, 1, 100);
                    end else
                        DiarioProyecto.Description := Lines."Activity Code";
                    DiarioProyecto.Modify(true);

                end;
            until Lines.Next = 0;
        end;
    end;

    var
        myInt: Integer;
}