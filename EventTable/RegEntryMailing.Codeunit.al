codeunit 50000 "Reg. Entry Mailing" {

    var
        HeaderTemplateMsg : label 'Dear, %1 %2<br><br>', Comment = '%1 - Name, %2 - Surname';
        FooterTemplateMsg : label 'You are invited to event:<br><br>Direction name: "%1"<br>Date: %2<br><br>Lecture name 1: "%3"<br>Prelector name 1: %4<br><br>Lecture name 2: "%5"<br>Prelector name 2: %6<br>',
            Comment = '%1 - Direction Name, %2 - Event Date, %3 - Lecture Name 1, %4 - Prelector Name 1, %5 - Lecture Name 2, %6 - Prelector Name 2';
        EmptyMailFieldErr : Label 'There are participants without E-mail. Continue?\';
        MsgHeader : Text;
        MsgFooter : Text;
        Messages : List of [Text];
        Emails : List of [Text];
        NoEmailParticipants : List of [Text];

    procedure SendRequests(var RegistrationEntry : Record "Registration Entry")
    var
        Contact : Record Contact;
    begin
        setMsgTemplate(RegistrationEntry);

        repeat
            RegistrationEntry.CalcFields("Participant E-mail");
            if checkEmailFieldNotEmpty(RegistrationEntry) then begin
                Contact.Get(RegistrationEntry."Participant Contact No.");
                Messages.Add(StrSubstNo(MsgHeader + MsgFooter, Contact."First Name", Contact.Surname));
                Emails.Add(Contact."E-Mail");
            end;
        until RegistrationEntry.Next() = 0;

        if NoEmailParticipants.Count() <> 0 then begin
            if Confirm(EmptyMailFieldErr + listToString(NoEmailParticipants)) then
                sendTemplateRequest();
        end else
            sendTemplateRequest();

    end;    

    local procedure checkEmailFieldNotEmpty(RegistrationEntry : Record "Registration Entry") : Boolean
    begin
        if RegistrationEntry."Participant E-mail" = '' then begin
            RegistrationEntry.CalcFields("Participant Name");
            NoEmailParticipants.Add(
            RegistrationEntry."Direction Code" + ', ' 
            + FORMAT(RegistrationEntry."Event Date") + ', ' 
            + RegistrationEntry."Participant Contact No." + ', '
            + RegistrationEntry."Participant Name" + '\'
            );
            exit(FALSE);
        end;
        exit(TRUE);
    end;

    local procedure sendTemplateRequest()
    var
        EmailMessage : Codeunit "Email Message";
        EmailMgt : Codeunit Email;
        idx : Integer;
        SubjTxt : Label 'Event invitation';
    begin
        for idx := 1 to Messages.Count() do begin
            EmailMessage.Create(Emails.Get(idx), SubjTxt, Messages.Get(idx), true);
            EmailMgt.Send(EmailMessage);
        end;
    end;

    local procedure setMsgTemplate(var RegistrationEntry : Record "Registration Entry")
    var
        EventRec : Record "Event";
    begin
        EventRec.GET(RegistrationEntry."Direction Code", RegistrationEntry."Event Date");
        EventRec.CALCFIELDS("Lecture Name 1","Lecture Name 2", "Prelector Name 1", "Prelector Name 2", "Direction Name");

        MsgHeader := HeaderTemplateMsg;
        MsgFooter := STRSUBSTNO(
            FooterTemplateMsg,
            EventRec."Direction Name",
            EventRec."Event Date",
            EventRec."Lecture Name 1",
            EventRec."Prelector Name 1",
            EventRec."Lecture Name 2",
            EventRec."Prelector Name 2"
        );
    end;

    local procedure listToString(strings : list of [Text]) : Text
    var
        result : Text;
        idx : Integer;
    begin
        for idx := 1 to strings.Count() do
            result += strings.Get(idx);
        exit(result);
    end;

}
