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
                    Contact : Record Contact;
                    ActiveRec : Record Contact;
                    ContactListPage : Page "Contact Person List";
                    NoMarkedRecordsMsg : TextConst ENU = 'No marked records', RUS = 'Нет выделеных участников';
                    ErrorContactMsg : TextConst ENU = 'These participants not added\%1', RUS = 'Есть не добаленые участники\%1';
                begin
                    ContactListPage.SETTABLEVIEW(Contact);
                    ContactListPage.LOOKUPMODE(TRUE);
                    ContactListPage.RunModal();
                    
                    ContactListPage.SetSelection(Contact);
                    Contact.MARKEDONLY(TRUE);
                    if not Contact.FindFirst() then begin
                        ContactListPage.GETRECORD(ActiveRec);
                        Message(NoMarkedRecordsMsg);
                    end else
                        repeat
                            convertAndSetLinkToRegEntry(Contact);
                        until Contact.Next() = 0;
                    if ErrorContacts <> '' then
                        Error(ErrorContactMsg, ErrorContacts);
                end;

            }
        }
    }

    var
        ErrorContacts : Text;

    local procedure convertAndSetLinkToRegEntry(var Contact : Record Contact)
    var
        RegistrationEntry : Record "Registration Entry";
    begin
        RegistrationEntry.Init();
        RegistrationEntry."Direction Code" := rec."Direction Code";
        RegistrationEntry."Event Date" := rec."Event Date";
        RegistrationEntry."Participant Contact No." := Contact."No.";
        if not RegistrationEntry.Insert(true) then 
            ErrorContacts += StrSubstNo('Contact No. = %1, Name = %2', Contact."No.", Contact.Name) + '\';
    end;

}
