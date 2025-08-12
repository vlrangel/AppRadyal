tableextension 50253 WAPPTimeSheetsLine extends "WAPP TimeSheets Lines" //50252
{
    fields
    {
        field(50002; Invoiced; Boolean)
        {
            Caption = 'Invoiced';
            DataClassification = ToBeClassified;
        }

        field(50003; Bloked; Boolean)
        {
            Caption = 'Blocked';
        }
        field(50004; "Ok Jefe"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
        field(50005; "Llevar al Diario"; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }

    trigger OnInsert()
    var
        DiarioComprobar: Record "Job Journal Line";
        lError: Label 'El parte %1 de la linea %2 esta en el diario de proyecto, no se puede añadir teniendo lineas en la misma fecha en el diario';
        lError2: Label 'El parte %1 de la linea %2 y fecha %3,esta facturado, no se puede insertar un nuevo registro con la misma fecha';
        TimeSheeRec: Record "WAPP TimeSheets Lines";
    begin
        if Rec."TimeSheet No." <> '' then begin
            DiarioComprobar.SetRange("Time Sheet No.1", rec."TimeSheet No.");
            DiarioComprobar.setrange("Posting Date", Rec.Date);
            if DiarioComprobar.FindFirst() then begin
                Error(lError, rec."TimeSheet No.", rec."Line No.");
            end;

            TimeSheeRec.SetRange("TimeSheet No.", Rec."TimeSheet No.");
            TimeSheeRec.SetRange(TimeSheeRec.Date, Rec.Date);
            TimeSheeRec.SetRange(Invoiced, true);
            if TimeSheeRec.FindFirst() then
                Error(lError2, rec."TimeSheet No.", rec."Line No.", rec.Date);
        end;
    end;

    trigger OnModify()
    var
        DiarioComprobar: Record "Job Journal Line";
        lError: Label 'El parte %1 de la linea %2 esta en el diario de proyecto, no se puede modificar';
        lError2: Label 'El parte %1 de la linea %2 esta facturado, no se puede modificar';
    begin

        DiarioComprobar.SetRange("Time Sheet No.1", rec."TimeSheet No.");
        DiarioComprobar.SetRange("Time Sheet Line No.", Rec."Line No.");
        if DiarioComprobar.FindFirst() then begin
            Error(lError, rec."TimeSheet No.", rec."Line No.");
        end;
        if (Rec.Hours <> xRec.Hours) and (xRec."TimeSheet No." <> '') then
            if Rec.Invoiced then
                Error(lError2, rec."TimeSheet No.", rec."Line No.");
    end;

    trigger OnDelete()
    var
        DiarioComprobar: Record "Job Journal Line";
        lError: Label 'El parte %1 de la linea %2 esta en el diario de proyecto, no se puede borrar';
        lError2: Label 'El parte %1 de la linea %2 esta facturado, no se puede borrar';
    begin
        if rec."TimeSheet No." <> '' then begin
            DiarioComprobar.SetRange("Time Sheet No.1", rec."TimeSheet No.");
            DiarioComprobar.SetRange("Time Sheet Line No.", Rec."Line No.");
            if DiarioComprobar.FindFirst() then begin
                Error(lError, rec."TimeSheet No.", rec."Line No.");
            end;
            if Rec.Invoiced then
                Error(lError2, rec."TimeSheet No.", rec."Line No.");
        end;
    end;

    var
        myInt: Integer;
}