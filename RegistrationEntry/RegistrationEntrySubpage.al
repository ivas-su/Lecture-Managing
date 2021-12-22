page 50006 "Registration Entry Subpage" {
    
    Caption = 'Registration Entry Subpage';
    PageType = ListPart;
    SourceTable = "Registration Entry";
    
    layout {
        area(content) {
            repeater(General) {
                field("Direction Code"; Rec."Direction Code")
                {
                    ToolTip = 'Specifies the value of the Direction Code field.';
                    ApplicationArea = All;
                }
                field("Direction Name"; Rec."Direction Name")
                {
                    ToolTip = 'Specifies the value of the Direction Name field.';
                    ApplicationArea = All;
                }
                field("Event Date"; Rec."Event Date")
                {
                    ToolTip = 'Specifies the value of the Event Date field.';
                    ApplicationArea = All;
                }
                field("Participant Contact No."; Rec."Participant Contact No.")
                {
                    ToolTip = 'Specifies the value of the Participant Contact No. field.';
                    ApplicationArea = All;
                }
                field("Participant E-mail"; Rec."Participant E-mail")
                {
                    ToolTip = 'Specifies the value of the Participant E-mail field.';
                    ApplicationArea = All;
                }
                field("Participant Name"; Rec."Participant Name")
                {
                    ToolTip = 'Specifies the value of the Participant Name field.';
                    ApplicationArea = All;
                }
                field("Participant Phone No."; Rec."Participant Phone No.")
                {
                    ToolTip = 'Specifies the value of the Participant Phone No. field.';
                    ApplicationArea = All;
                }
                field(Present; Rec.Present)
                {
                    ToolTip = 'Specifies the value of the Present field.';
                    ApplicationArea = All;
                }
                field(Registered; Rec.Registered)
                {
                    ToolTip = 'Specifies the value of the Registered field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions {
        area(Processing) {
            action("Add some particiapnts") {
                CaptionML = ENU = 'Add participants',
                            RUS = 'Добавить участников';
                ApplicationArea = All;

                trigger OnAction()
                var 
                    ContactListPage : Page "Contact Person List";
                    Contact : Record Contact;
                begin
                    ContactListPage.SetTableView(Contact);
                    ContactListPage.LookupMode(true);
                    ContactListPage.RunModal();

                    rec.FindFirst();
                    
                end;
            }
        }
    }

}
