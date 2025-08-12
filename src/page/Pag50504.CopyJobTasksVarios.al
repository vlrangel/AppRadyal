page 50504 "Copy Job Tasks Varios"
{
    // Caption = 'Copy Job Tasks';
    Caption = 'Copiar tareas de proyecto a varios Proyectos';
    PageType = StandardDialog;

    layout
    {
        area(content)
        {
            group("Copy from")
            {
                //Caption = 'Copy from';
                Caption = 'Copiar Desde';
                field(SourceJobNo; SourceJobNo)
                {
                    ApplicationArea = Jobs;
                    // Caption = 'Job No.';
                    Caption = 'No. Proyecto';
                    TableRelation = Job;
                    //ToolTip = 'Specifies the job number.';
                    ToolTip = 'Especifica el numero de proyecto';

                    trigger OnValidate()
                    begin
                        if (SourceJobNo <> '') and not SourceJob.Get(SourceJobNo) then
                            Error(Text003, SourceJob.TableCaption(), SourceJobNo);

                        FromJobTaskNo := '';
                        ToJobTaskNo := '';
                    end;
                }
                field(FromJobTaskNo; FromJobTaskNo)
                {
                    ApplicationArea = Jobs;
                    //  Caption = 'Job Task No. from';
                    Caption = 'No. de Tarea proyecto desde ....';
                    ToolTip = 'Specifies the first job task number to be copied from. Only planning lines with a job task number equal to or higher than the number specified in this field will be included.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        JobTask: Record "Job Task";
                    begin
                        if SourceJob."No." <> '' then begin
                            JobTask.SetRange("Job No.", SourceJob."No.");
                            OnLookupFromJobTaskNoOnAfterSetJobTaskFilters(JobTask);
                            if PAGE.RunModal(PAGE::"Job Task List", JobTask) = ACTION::LookupOK then
                                FromJobTaskNo := JobTask."Job Task No.";
                        end;
                    end;

                    trigger OnValidate()
                    var
                        JobTask: Record "Job Task";
                    begin
                        if (FromJobTaskNo <> '') and not JobTask.Get(SourceJob."No.", FromJobTaskNo) then
                            Error(Text003, JobTask.TableCaption(), FromJobTaskNo);
                    end;
                }
                field(ToJobTaskNo; ToJobTaskNo)
                {
                    ApplicationArea = Jobs;
                    //Caption = 'Job Task No. to';
                    Caption = 'No. de Tarea proyecto hasta ....';
                    ToolTip = 'Specifies the last job task number to be copied from. Only planning lines with a job task number equal to or lower than the number specified in this field will be included.';

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        JobTask: Record "Job Task";
                    begin
                        if SourceJobNo <> '' then begin
                            JobTask.SetRange("Job No.", SourceJobNo);
                            OnLookupToJobTaskNoOnAfterSetJobTaskFilters(JobTask);
                            if PAGE.RunModal(PAGE::"Job Task List", JobTask) = ACTION::LookupOK then
                                ToJobTaskNo := JobTask."Job Task No.";
                        end;
                    end;

                    trigger OnValidate()
                    var
                        JobTask: Record "Job Task";
                    begin
                        if (ToJobTaskNo <> '') and not JobTask.Get(SourceJobNo, ToJobTaskNo) then
                            Error(Text003, JobTask.TableCaption(), ToJobTaskNo);
                    end;
                }
                field("From Source"; Source)
                {
                    ApplicationArea = Jobs;
                    //Caption = 'Source';
                    Caption = 'Origen';
                    OptionCaption = 'Job Planning Lines,Job Ledger Entries,None';
                    ToolTip = 'Specifies the basis on which you want the planning lines to be copied. If, for example, you want the planning lines to reflect actual usage and invoicing of items, resources, and general ledger expenses on the job you copy from, then select Job Ledger Entries in this field.';

                    trigger OnValidate()
                    begin
                        ValidateSource();
                    end;
                }
                field("Planning Line Type"; PlanningLineType)
                {
                    ApplicationArea = Jobs;
                    // Caption = 'Incl. Planning Line Type';
                    Caption = 'Incl. tipo líneas de planificacion';
                    Enabled = PlanningLineTypeEnable;
                    OptionCaption = 'Budget+Billable,Budget,Billable';
                    ToolTip = 'Specifies how copy planning lines. Budget+Billable: All planning lines are copied. Budget: Only lines of type Budget or type Both Budget and Billable are copied. Billable: Only lines of type Billable or type Both Budget and Billable are copied.';
                }
                field("Ledger Entry Line Type"; LedgerEntryType)
                {
                    ApplicationArea = Jobs;
                    //Caption = 'Incl. Ledger Entry Line Type';
                    Caption = 'Incl. tipo lineas mov.';
                    Enabled = LedgerEntryLineTypeEnable;
                    OptionCaption = 'Usage+Sale,Usage,Sale';
                    ToolTip = 'Specifies how to copy job ledger entries. Usage+Sale: All job ledger entries are copied. Entries of type Usage are copied to new planning lines of type Budget. Entries of type Sale are copied to new planning lines of type Billable. Usage: All job ledger entries of type Usage are copied to new planning lines of type Budget. Sale: All job ledger entries of type Sale are copied to new planning lines of type Billable.';
                }
                field(FromDate; FromDate)
                {
                    ApplicationArea = Jobs;
                    //Caption = 'Starting Date';
                    Caption = 'Fecha Inicial';
                    ToolTip = 'Specifies the date from which the report or batch job processes information.';
                }
                field(ToDate; ToDate)
                {
                    ApplicationArea = Jobs;
                    //Caption = 'Ending Date';
                    Caption = 'Fecha final';
                    ToolTip = 'Specifies the date to which the report or batch job processes information.';
                }
            }
            group("Copy to")
            {
                //Caption = 'Copy to';
                Caption = 'Copiar a';
                field(TargetJobNo; TargetJobNo)
                {
                    ApplicationArea = Jobs;
                    //Caption = 'Job No.';
                    Caption = 'No. proyecto';
                    TableRelation = Job;
                    ToolTip = 'Specifies the job number.';

                    trigger OnValidate()
                    begin

                        //  TargetJobArray[i] := TargetJobNo;
                        //if (TargetJobNo <> '') and not TargetJob.Get(TargetJobNo) then;
                        //  Error(Text003, TargetJob.TableCaption(), TargetJobNo);
                    end;

                    trigger OnLookup(var Text: Text): Boolean
                    var
                        pJobList: page "Job List";
                        JobRec: Record Job;
                        whereBarra: Text;
                        barra: Text;
                    begin
                        Clear(pJobList);
                        Clear(TargetJobArray);
                        Clear(TargetJobNo);
                        barra := '|';
                        if JobRec.FindFirst() then begin
                            pJobList.SetTableView(JobRec);
                            pJobList.SetRecord(JobRec);
                            if pJobList.RunModal() = Action::OK then begin
                                pJobList.GetRecord(JobRec);
                                pJobList.SetSelectionFilter(JobRec);
                                if JobRec.FindSet() then
                                    repeat
                                        i := i + 1;
                                        TargetJobNo := TargetJobNo + JobRec."No." + barra;
                                        TargetJobArray[i] := JobRec."No.";
                                    until JobRec.Next() = 0;
                            end;
                            whereBarra := '>';
                            TargetJobNo := DelChr(TargetJobNo, whereBarra, barra);
                        end;
                    end;
                }
            }
            group(Apply)
            {
                // Caption = 'Apply';
                Caption = 'Aplicar';
                field(CopyQuantity; CopyQuantity)
                {
                    ApplicationArea = Jobs;
                    // Caption = 'Copy Quantity';
                    Caption = 'Copiar cantidad';
                    ToolTip = 'Specifies that the quantities will be copied to the new job.';
                }
                field(CopyDimensions; CopyDimensions)
                {
                    ApplicationArea = Dimensions;
                    // Caption = 'Copy Dimensions';
                    Caption = 'Copiar Dimensiones';
                    ToolTip = 'Specifies that the dimensions will be copied to the new job task.';
                }
            }
        }
    }

    actions
    {
    }

    trigger OnOpenPage()
    begin
        PlanningLineType := PlanningLineType::"Budget+Billable";
        LedgerEntryType := LedgerEntryType::"Usage+Sale";
        OnOpenPageOnBeforeValidateSource(CopyQuantity, CopyDimensions, Source, PlanningLineType, LedgerEntryType);
        ValidateSource();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        IsHandled: Boolean;
        x: Integer;
        LogArray: Integer;
    begin
        x := 0;
        LogArray := i;

        salir := false;
        IsHandled := false;
        OnBeforeOnQueryClosePage(CloseAction, SourceJob, TargetJob, IsHandled, CopyQuantity, CopyDimensions, Source, PlanningLineType, LedgerEntryType, FromJobTaskNo, ToJobTaskNo, FromDate, ToDate);
        if IsHandled then
            exit(IsHandled);

        if CloseAction in [ACTION::OK, ACTION::LookupOK] then begin
            ValidateUserInput();
            CopyJob.SetCopyOptions(false, CopyQuantity, CopyDimensions, Source, PlanningLineType, LedgerEntryType);
            CopyJob.SetJobTaskRange(FromJobTaskNo, ToJobTaskNo);
            CopyJob.SetJobTaskDateRange(FromDate, ToDate);
            OnQueryClosePageOnBeforeCopyJobTasks(CopyJob, CopyQuantity, CopyDimensions, Source, PlanningLineType, LedgerEntryType);
            repeat
                x := x + 1;
                TargetJob.SetRange(TargetJob."No.", TargetJobArray[x]);
                if TargetJob.FindFirst() then begin
                    CopyJob.CopyJobTasks(SourceJob, TargetJob);

                end else begin
                    salir := true;
                end;

            until (x = i) or (salir = true);
            Message(Text001);
        end
    end;

    var
        TargetJobArray: array[30] of Code[20];
        salir: Boolean;
        i: Integer;
        Text001: Label 'The job was successfully copied.';
        Text003: Label '%1 %2 does not exist.', Comment = 'Job Task 1000 does not exist.';
        PlanningLineTypeEnable: Boolean;
        LedgerEntryLineTypeEnable: Boolean;
        Text004: Label 'Provide a valid source %1.';
        Text005: Label 'Provide a valid target %1.';

    protected var
        SourceJob, TargetJob : Record Job;
        CopyJob: Codeunit "Copy Job";
        SourceJobNo, FromJobTaskNo, ToJobTaskNo : Code[20];
        TargetJobNo: Code[100];
        FromDate, ToDate : Date;
        Source: Option "Job Planning Lines","Job Ledger Entries","None";
        PlanningLineType: Option "Budget+Billable",Budget,Billable;
        LedgerEntryType: Option "Usage+Sale",Usage,Sale;
        CopyQuantity, CopyDimensions : Boolean;

    local procedure ValidateUserInput()
    begin
        if (SourceJobNo = '') or not SourceJob.Get(SourceJobNo) then
            Error(Text004, SourceJob.TableCaption());

        // if (TargetJobNo = '') or not TargetJob.Get(TargetJobNo) then
        //     Error(Text005, TargetJob.TableCaption());
    end;

    local procedure ValidateSource()
    begin
        case true of
            Source = Source::"Job Planning Lines":
                begin
                    PlanningLineTypeEnable := true;
                    LedgerEntryLineTypeEnable := false;
                end;
            Source = Source::"Job Ledger Entries":
                begin
                    PlanningLineTypeEnable := false;
                    LedgerEntryLineTypeEnable := true;
                end;
            Source = Source::None:
                begin
                    PlanningLineTypeEnable := false;
                    LedgerEntryLineTypeEnable := false;
                end;
        end;
    end;

    procedure SetFromJob(SourceJob2: Record Job)
    begin
        SourceJob := SourceJob2;
        SourceJobNo := SourceJob."No.";
    end;

    procedure SetToJob(TargetJob2: Record Job)
    begin
        TargetJob := TargetJob2;
        TargetJobNo := TargetJob."No.";
    end;

    [IntegrationEvent(false, false)]
    local procedure OnLookupFromJobTaskNoOnAfterSetJobTaskFilters(var JobTask: Record "Job Task")
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnLookupToJobTaskNoOnAfterSetJobTaskFilters(var JobTask: Record "Job Task")
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnBeforeOnQueryClosePage(var CloseAction: Action; var SourceJob: Record Job; var TargetJob: Record Job; var IsHandled: Boolean; var CopyQuantity: Boolean; var CopyDimensions: Boolean; var Source: Option "Job Planning Lines","Job Ledger Entries","None"; var PlanningLineType: Option "Budget+Billable",Budget,Billable; var LedgerEntryType: Option "Usage+Sale",Usage,Sale; var FromJobTaskNo: Code[20]; var ToJobTaskNo: Code[20]; var FromDate: Date; var ToDate: Date)
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnOpenPageOnBeforeValidateSource(var CopyQuantity: Boolean; var CopyDimensions: Boolean; var Source: Option "Job Planning Lines","Job Ledger Entries","None"; var PlanningLineType: Option "Budget+Billable",Budget,Billable; var LedgerEntryType: Option "Usage+Sale",Usage,Sale);
    begin
    end;

    [IntegrationEvent(true, false)]
    local procedure OnQueryClosePageOnBeforeCopyJobTasks(var CopyJob: Codeunit "Copy Job"; var CopyQuantity: Boolean; var CopyDimensions: Boolean; var Source: Option "Job Planning Lines","Job Ledger Entries","None"; var PlanningLineType: Option "Budget+Billable",Budget,Billable; var LedgerEntryType: Option "Usage+Sale",Usage,Sale);
    begin
    end;
}

