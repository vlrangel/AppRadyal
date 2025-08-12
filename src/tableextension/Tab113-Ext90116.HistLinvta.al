/// <summary>
/// TableExtension HistLinvta (ID 90116) extends Record Sales Invoice Line.
/// </summary>
tableextension 90116 HistLinvta extends "Sales Invoice Line" //113
{
    fields
    {
        field(85000; "Linea Retencion"; Boolean) { }
        field(85001; "Sujeto IRPF"; Boolean) { }
        field(85002; "Situación inmueble"; Code[10]) { }
        field(85003; "Referencia catastral"; Text[30]) { }
    }
}

