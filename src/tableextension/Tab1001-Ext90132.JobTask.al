/// <summary>
/// TableExtension JobTask (ID 90132) extends Record Job Task.
/// </summary>
tableextension 90132 JobTask extends "Job Task" //1001
{
    fields
    {
        field(90000; "Visible Web."; Boolean)
        {
            Caption = 'Visible Web';
            DataClassification = ToBeClassified;
            ObsoleteReason = 'duplicado en version WEPP';
            ObsoleteState = Removed;

        }
    }
}
