pageextension 50503 "JobList" extends "job list" //89
{
    layout
    {

        addbefore(Status)
        {

            field("Bill-to Name"; Rec."Bill-to Name")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the name of the customer who pays for the job.';
            }
        }
    }

    actions
    {
        addlast("&Job")
        {

            action("Copy Job Tasks &from...")
            {
                ApplicationArea = Jobs;
                Caption = 'Copy Job Tasks &from...diferent';
                Ellipsis = true;
                Image = CopyToTask;
                ToolTip = 'Open the Copy Job Tasks page.';

                trigger OnAction()
                var
                    CopyJobTasks: Page "Copy Job Tasks Varios";
                begin
                    CopyJobTasks.SetToJob(Rec);
                    CopyJobTasks.RunModal();
                end;
            }
        }

    }

    var
        myInt: Integer;
        job: page "Job Card";
    //Copy Job Tasks
}