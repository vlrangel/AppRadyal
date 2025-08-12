/// <summary>
/// TableExtension PaymentMethod (ID 90125) extends Record Payment Method.
/// </summary>
tableextension 90125 PaymentMethod extends "Payment Method" //289
{
    fields
    {

        field(90000; "Num de cuenta banco en factura"; Text[30]) { }
        field(90001; "SWIFT"; Text[12]) { }
    }
}
