codeunit 50200 EventosRadyal
{
    trigger OnRun()
    begin

    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Job Jnl.-Post Batch", 'OnAfterJobJnlPostLine', '', false, false)]
    local procedure OnAfterJobJnlPostLine(var JobJournalLine: Record "Job Journal Line")
    var
        Lineas: Record "WAPP TimeSheets Lines";
    begin
        Lineas.SetRange(Lineas."TimeSheet No.", JobJournalLine."Time Sheet No.1");
        Lineas.SetRange("Line No.", JobJournalLine."Time Sheet Line No.");
        if Lineas.FindFirst() then begin
            Lineas.Invoiced := true;
            Lineas.Modify(false);
        end;

    end;

    var
        myInt: Integer;
}