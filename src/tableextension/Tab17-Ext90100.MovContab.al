/// <summary>
/// TableExtension MovContab (ID 90100) extends Record G/L Entry.
/// </summary>
tableextension 90100 MovContab extends "G/L Entry" //17
{
    fields
    {
        field(90000; "Sujeto IRPF"; Boolean)
        {
            ObsoleteState = Removed;
            Caption = 'Sujeto IRPF';
            DataClassification = ToBeClassified;
        }
        field(90001; "Saldo Servitec"; Decimal)
        {
            ObsoleteState = Removed;
            Caption = 'Saldo Servitec';
            DataClassification = ToBeClassified;
        }
    }
}
