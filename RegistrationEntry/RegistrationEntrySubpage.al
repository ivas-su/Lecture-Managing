page 50006 "Registration Entry Subpage" {
    
    PageType = ListPart;
    SourceTable = "Registration Entry";
    CaptionML = ENU = 'Registration Entry Subpage',
                RUS = 'Регистрации';
    
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
                    ContactRec : Record Contact;
                    ActiveRec : Record Contact;
                    NoMarkedRecords : TextConst ENU = 'No marked records', RUS = 'Нет выделеных участников';
                    ErrorContactMsg : TextConst ENU = 'These participants not added', RUS = 'Произошла ошибка с контактами';
                begin
                    ContactListPage.SETTABLEVIEW(ContactRec);
                    ContactListPage.LOOKUPMODE(TRUE);
                    ContactListPage.RUNMODAL;
                    
                    ContactListPage.SetSelection(ContactRec);
                    ContactRec.MARKEDONLY(TRUE);
                    IF NOT ContactRec.FINDFIRST THEN BEGIN
                        ContactListPage.GETRECORD(ActiveRec);
                        MESSAGE(NoMarkedRecords);
                    END ELSE BEGIN
                        REPEAT
                            convertAndSetLinkToRegEntry(ContactRec);
                        UNTIL ContactRec.NEXT = 0;
                    END;
                    if ErrorContacts <> '' then begin
                        Error(ErrorContactMsg + '\' + ErrorContacts);
                    end;
                    
                end;

            }
        }
    }

    var
        ErrorContacts : Text;

    local procedure convertAndSetLinkToRegEntry(VAR Contact : Record Contact)
    var
        RegEntry : Record "Registration Entry";
    begin
        RegEntry.INIT;
        RegEntry."Direction Code" := rec."Direction Code";
        RegEntry."Event Date" := rec."Event Date";
        RegEntry."Participant Contact No." := Contact."No.";
        if not RegEntry.INSERT(TRUE) then begin
            ErrorContacts += StrSubstNo('Contact No. = %1, Name = %2', Contact."No.", Contact.Name) + '\';
        end;
    end;

}
