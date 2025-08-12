pageextension 50520 SalesOrderSubform extends "Sales Order Subform" //46
{
    layout
    {
        addafter(Quantity)
        {

            // field("Job No."; Rec."Job No.")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the number of the related project. If you fill in this field and the Project Task No. field, then a project ledger entry will be posted together with the sales line.';
            //     //    Editable = true;
            // }
            // field("Job Task No."; Rec."Job Task No.")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the number of the related project task.';
            //     //   Editable = true;
            // }
            // field("Job Contract Entry No."; Rec."Job Contract Entry No.")
            // {
            //     ApplicationArea = All;
            //     ToolTip = 'Specifies the entry number of the project planning line that the sales line is linked to.';
            //     //  Editable = true;
            // }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
        pg42: Page 42;
}