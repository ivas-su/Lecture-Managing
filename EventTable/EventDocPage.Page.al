page 50008 "Event Doc. Page" {

    PageType = Document;
    SourceTable = "Event";
    Caption = 'Event Document Page';

    layout {
        area(content) {
            group(General) {
                field("Direction Code"; Rec."Direction Code")
                {
                    ToolTip = 'Specifies the value of the "Direction Code" field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Direction Name"; Rec."Direction Name")
                {
                    ToolTip = 'Specifies the value of the "Direction Name" field.';
                    ApplicationArea = All;
                    Lookup = false;
                    DrillDown = false;
                    AssistEdit = false;
                }
                field("Event Date"; Rec."Event Date")
                {
                    ToolTip = 'Specifies the value of the "Event Date" field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Lecture Code 1"; Rec."Lecture Code 1")
                {
                    ToolTip = 'Specifies the value of the "Lecture Code 1" field.';
                    ApplicationArea = All;
                    ShowMandatory = false;
                }
                field("Lecture Name 1"; Rec."Lecture Name 1")
                {
                    ToolTip = 'Specifies the value of the "Lecture Name 1" field.';
                    ApplicationArea = All;
                    Lookup = false;
                    DrillDown = false;
                    AssistEdit = false;
                }
                field("Prelector Code 1"; Rec."Prelector Code 1")
                {
                    ToolTip = 'Specifies the value of the "Prelector Code 1" field.';
                    ApplicationArea = All;
                    ShowMandatory = false;
                }
                field("Prelector Name 1"; Rec."Prelector Name 1")
                {
                    ToolTip = 'Specifies the value of the "Prelector Name 1" field.';
                    ApplicationArea = All;
                    Lookup = false;
                    DrillDown = false;
                    AssistEdit = false;
                }
                field("Lecture Code 2"; Rec."Lecture Code 2")
                {
                    ToolTip = 'Specifies the value of the "Lecture Code 2" field.';
                    ApplicationArea = All;
                    ShowMandatory = false;
                }
                field("Lecture Name 2"; Rec."Lecture Name 2")
                {
                    ToolTip = 'Specifies the value of the "Lecture Name 2" field.';
                    ApplicationArea = All;
                    Lookup = false;
                    DrillDown = false;
                    AssistEdit = false;
                }
                field("Prelector Code 2"; Rec."Prelector Code 2")
                {
                    ToolTip = 'Specifies the value of the "Prelector Code 2" field.';
                    ApplicationArea = All;
                    ShowMandatory = false;
                }
                field("Prelector Name 2"; Rec."Prelector Name 2")
                {
                    ToolTip = 'Specifies the value of the "Prelector Name 2" field.';
                    ApplicationArea = All;
                    Lookup = false;
                    DrillDown = false;
                    AssistEdit = false;
                }
                field("Number of people present"; Rec."Number of people present")
                {
                    ToolTip = 'Specifies the value of the "Number of people present" field.';
                    ApplicationArea = All;
                }
                field("Number of registered"; Rec."Number of registered")
                {
                    ToolTip = 'Specifies the value of the "Number of registered" field.';
                    ApplicationArea = All;
                }
            }
            part(Subpage; "Registration Entry Subpage") {
                Caption = 'Registration Entry Subpage';
                SubPageLink = "Direction Code" = field("Direction Code"),
                              "Event Date" = field("Event Date");
                ApplicationArea = All;
                
            }
        }
    }

    actions {
        area(Processing) {
            action(Print) {

                ToolTip = 'Prints currant event information';
                ApplicationArea = All;
                Image = Print;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Caption = 'Print';

                trigger OnAction()
                var
                    EventRec : Record "Event";
                    RegistartionEntry : Record "Registration Entry";
                    ParticipantReport : Report Participant;
                begin
                    EventRec.Reset();
                    RegistartionEntry.Reset();
                    CurrPage.SetSelectionFilter(EventRec);
                    FilterParticipants(RegistartionEntry);
                    ParticipantReport.SetTableView(EventRec);
                    ParticipantReport.SetTableView(RegistartionEntry);
                    ParticipantReport.RunModal();
                end;
            }
            action("Send invitation") {
                
                ToolTip = 'Send invitation on emails';
                ApplicationArea = All;
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Caption = 'Send invitation';

                trigger OnAction()
                var
                    RegistrationEntry : Record "Registration Entry";
                    Mail : Codeunit "Reg. Entry Mailing";
                    ContactsErr : Label 'There are no participants';
                begin
                    FilterParticipants(RegistrationEntry);
                    if not RegistrationEntry.FindFirst() then
                        Error(ContactsErr);
                    Mail.SendRequests(RegistrationEntry);
                end;

            }
        }
    }

    local procedure FilterParticipants(VAR RegistrationEntry : Record "Registration Entry")
    begin
        RegistrationEntry.SetRange("Direction Code", rec."Direction Code");
        RegistrationEntry.SetRange("Event Date", rec."Event Date");
    end;

}
