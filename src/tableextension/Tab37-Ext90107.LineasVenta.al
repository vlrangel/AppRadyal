/// <summary>
/// TableExtension LineasVenta (ID 90107) extends Record Sales Line.
/// </summary>
tableextension 90107 LineasVenta extends "Sales Line" //37
{
    fields
    {
        field(85000; "Linea Retencion"; Boolean) { }
        field(85001; "Sujeto IRPF"; Boolean) { }
        field(85002; "Situación inmueble"; Code[10]) { }
        field(85003; "Referencia catastral"; Text[30]) { }
    }
}
