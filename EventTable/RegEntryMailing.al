codeunit 50000 "Reg. Entry Mailing" {

    var
        HeaderTemplate : TextConst ENU = 'Dear, %1 %2\\';
        FooterTemplate : TextConst ENU = 'You are invited to event:\\Direction name: "%1"\Date: %2\\Lecture name 1: "%3"\Prelector name 1: %4\\Lecture name 2: "%5"\Prelector name 2: %6\';
        EmptyMailFieldError : TextConst ENU = 'There are participants without E-mail. Continue?\';
        MsgHeader : Text;
        MsgFooter : Text;
        Messages : List of [Text];
        Emails : List of [Text];
        NoEmailParticipants : List of [Text];

    procedure SendRequests(VAR RegistrationEntry : Record "Registration Entry")
    var
        Contact : Record Contact;
    begin
        setMsgTemplate(RegistrationEntry);

        REPEAT
            RegistrationEntry.CALCFIELDS("Participant E-mail");
            IF checkEmailFieldNotEmpty(RegistrationEntry) THEN BEGIN
                Contact.GET(RegistrationEntry."Participant Contact No.");
                Messages.Add(StrSubstNo(MsgHeader + MsgFooter, Contact."First Name", Contact.Surname));
                Emails.Add(Contact."E-Mail");
            END;
        UNTIL RegistrationEntry.NEXT = 0;

        IF NoEmailParticipants.Count() <> 0 THEN begin
            IF CONFIRM(EmptyMailFieldError + stringConcatention(NoEmailParticipants)) THEN
                sendTemplateRequest();
        end else begin
            sendTemplateRequest();
        end;

    end;    

    local procedure checkEmailFieldNotEmpty(RegEntry : Record "Registration Entry") : Boolean
    begin
        IF RegEntry."Participant E-mail" = '' THEN BEGIN
            RegEntry.CALCFIELDS("Participant Name");
            NoEmailParticipants.Add(
            RegEntry."Direction Code" + ', ' 
            + FORMAT(RegEntry."Event Date") + ', ' 
            + RegEntry."Participant Contact No." + ', '
            + RegEntry."Participant Name" + '\'
            );
            EXIT(FALSE);
        END;
        EXIT(TRUE);
    end;

    local procedure sendTemplateRequest()
    var
        EMessage : Codeunit "Email Message";
        EmailMgt : Codeunit Email;
        idx : Integer;
    begin
        for idx := 1 to Messages.Count() do begin
            EMessage.Create(Emails.Get(idx), 'Event invitation', Messages.Get(idx));
            EmailMgt.Send(EMessage);
        end;
    end;

    local procedure setMsgTemplate(VAR RegistrationEntry : Record "Registration Entry")
    var
        EventRec : Record "Event";
    begin
        EventRec.GET(RegistrationEntry."Direction Code", RegistrationEntry."Event Date");
        EventRec.CALCFIELDS("Lecture Name 1","Lecture Name 2", "Prelector Name 1", "Prelector Name 2", "Direction Name");

        MsgHeader := HeaderTemplate;
        MsgFooter := STRSUBSTNO(
            FooterTemplate,
            EventRec."Direction Name",
            EventRec."Event Date",
            EventRec."Lecture Name 1",
            EventRec."Prelector Name 1",
            EventRec."Lecture Name 2",
            EventRec."Prelector Name 2"
        );
    end;

    local procedure stringConcatention(strings : list of [Text]) : Text
    var
        result : Text;
        idx : Integer;
    begin
        for idx := 1 to strings.Count() do begin
            result += strings.Get(idx);
        end;
        exit(result);
    end;

}
