// FIXME
codeunit 50000 "SMTP Reg. Entry Mailing" {

    /*
        Name	DataType	Subtype	Length
        NoEmailParticipants	Text		
        MsgHeader	Text		
        MsgFooter	Text		
        MailBuffer	Record	Name/Value Buffer


        Name	ConstValue
        EmptyMailFieldError	There are participants without E-mail. Continue?\
        FooterTemplate	You are invited to event:\\Direction name: "%1"\Date: %2\\Lecture name 1: "%3"\Prelector name 1: %4\\Lecture name 2: "%5"\Prelector name 2: %6\
        HeaderTemplate	Dear, %1 %2\\

    */

    var
        HeaderTemplate : TextConst ENU = 'Dear, %1 %2\\';
        FooterTemplate : TextConst ENU = 'You are invited to event:\\Direction name: "%1"\Date: %2\\Lecture name 1: "%3"\Prelector name 1: %4\\Lecture name 2: "%5"\Prelector name 2: %6\';
        EmptyMailFieldError : TextConst ENU = 'There are participants without E-mail. Continue?\';
        MsgHeader : Text;
        MsgFooter : Text;
        Mailbuffer : List of [Text];
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
            Mailbuffer.Add(StrSubstNo(MsgHeader + MsgFooter, Contact."First Name", Contact.Surname));
        END;
        UNTIL RegistrationEntry.NEXT = 0;

        // IF NoEmailParticipants.Count() <> 0 THEN
        //     IF CONFIRM(EmptyMailFieldError + NoEmailParticipants) THEN
        //         sendTemplateRequest;
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
        MailManagement : Codeunit "Mail Management";
        Mail : Record "Email Item";
        idx : Integer;
    begin
        Mail.SetBodyText('Hello');
        for idx := 1 to Mailbuffer.Count() do begin
            Message(Mailbuffer.Get(idx));
        end;

        // SMTPMail.CreateMessage(
        //  '',
        //  MailManagement.GetSenderEmailAddress,
        //  RegistrationEntry."Participant E-mail",
        //  'Yess',
        //  'Msg',
        //  TRUE
        // );
        // 
        // SMTPMail.Send;
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

}
