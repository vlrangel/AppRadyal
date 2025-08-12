tableextension 90200 Contab extends "G/L Account" //15
{
    fields
    {
        field(90000; "Sujeto IRPF"; Boolean)
        {
            Caption = 'Sujeto IRPF';
            DataClassification = ToBeClassified;
        }
        field(90001; "Saldo Servitec"; Decimal)
        {
            Caption = 'Saldo Servitec';
            DataClassification = ToBeClassified;
        }
    }
}