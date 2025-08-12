page 50601 PostValueEntry
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "Post Value Entry to G/L";
    Editable = true;
    Caption = 'Movimientos Registrados en mov Valor';
    Permissions = tabledata "Post Value Entry to G/L" = rmid;

    layout
    {
        area(Content)
        {
            repeater(GroupName)
            {

                field("Item No."; Rec."Item No.")
                {
                    ToolTip = 'Specifies the value of the Item No. field.';
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ToolTip = 'Specifies the value of the Posting Date field.';
                }
                field("Value Entry No."; Rec."Value Entry No.")
                {
                    ToolTip = 'Specifies the value of the Value Entry No. field.';
                }
            }
        }
        area(Factboxes)
        {

        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction();
                begin

                end;
            }
        }
    }
}