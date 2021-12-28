page 50006 "Registration Entry Subpage"
{

    PageType = ListPart;
    SourceTable = "Registration Entry";
    Caption = 'Registration Entry Subpage';

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Direction Code"; Rec."Direction Code")
                {
                    ToolTip = 'Specifies the value of the "Direction Code" field.';
                    ApplicationArea = All;
                }
                field("Direction Name"; Rec."Direction Name")
                {
                    ToolTip = 'Specifies the value of the "Direction Name" field.';
                    ApplicationArea = All;
                }
                field("Event Date"; Rec."Event Date")
                {
                    ToolTip = 'Specifies the value of the "Event Date" field.';
                    ApplicationArea = All;
                }
                field("Participant Contact No."; Rec."Participant Contact No.")
                {
                    ToolTip = 'Specifies the value of the "Participant Contact No." field.';
                    ApplicationArea = All;
                }
                field("Participant E-mail"; Rec."Participant E-mail")
                {
                    ToolTip = 'Specifies the value of the "Participant E-mail" field.';
                    ApplicationArea = All;
                }
                field("Participant Name"; Rec."Participant Name")
                {
                    ToolTip = 'Specifies the value of the "Participant Name" field.';
                    ApplicationArea = All;
                }
                field("Participant Phone No."; Rec."Participant Phone No.")
                {
                    ToolTip = 'Specifies the value of the "Participant Phone No." field.';
                    ApplicationArea = All;
                }
                field(Present; Rec.Present)
                {
                    ToolTip = 'Specifies the value of the "Present" field.';
                    ApplicationArea = All;
                }
                field(Registered; Rec.Registered)
                {
                    ToolTip = 'Specifies the value of the "Registered" field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Processing)
        {

            action("Add some particiapnts")
            {

                Caption = 'Add participants';
                ApplicationArea = All;
                ToolTip = 'Add several participants';
                Image = Add;

                trigger OnAction()
                var
                    Contact: Record Contact;
                    ActiveRec: Record Contact;
                    SelectedRecord: Record Contact;
                    ContactListPage: Page "Contact Person List";
                    NoMarkedRecordsMsg: Label 'No marked records';
                    ErrorContactMsg: Label 'These participants not added\%1', Comment = '%1 - list of not added participants';
                begin
                    Contact.Reset();
                    
                    ContactListPage.SETTABLEVIEW(Contact);
                    ContactListPage.LOOKUPMODE(TRUE);

                    if ContactListPage.RunModal() = Action::LookupOK then begin
                        SelectedRecord := Contact;
                        ContactListPage.SetSelection(SelectedRecord);
                        SelectedRecord.MARKEDONLY(TRUE);
                        if not SelectedRecord.FindFirst() then begin
                            ContactListPage.GETRECORD(ActiveRec);
                            Message(NoMarkedRecordsMsg);
                        end else
                            convertAndSetLinkToRegEntry(SelectedRecord);
                        if ErrorContacts <> '' then
                            Message(ErrorContactMsg, ErrorContacts);
                            ErrorContacts := '';
                    end;
                end;

            }
        }
    }

    var
        ErrorContacts: Text;

    local procedure convertAndSetLinkToRegEntry(var Contact: Record Contact)
    var
        RegistrationEntry: Record "Registration Entry";
        typeHelper : Codeunit "Type Helper";
        TemplateErr: Label '%1 = %2, %3 = %4',
            Comment = '%1 - FCaption, %2 - No., %3 - FCaption, %4 - Name';
    begin
        repeat
            RegistrationEntry.Init();
            RegistrationEntry."Direction Code" := rec."Direction Code";
            RegistrationEntry."Event Date" := rec."Event Date";
            RegistrationEntry."Participant Contact No." := Contact."No.";
            if not RegistrationEntry.Insert(true) then
                ErrorContacts += StrSubstNo(TemplateErr, Contact.FieldCaption("Company No."), Contact."No.", Contact.FieldCaption(Name), Contact.Name) + typeHelper.CRLFSeparator();
        until Contact.Next() = 0;
    end;

}
