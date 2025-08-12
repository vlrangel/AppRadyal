pageextension 50602 ItemCardEx extends "Item Card" //30
{
    layout
    {
        // Add changes to page layout here
        modify("Cost is Posted to G/L")
        {
            Editable = true;
        }
        modify("Cost is Adjusted")
        {
            Editable = true;
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}