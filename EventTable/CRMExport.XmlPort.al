xmlport 50000 CRMExport {

    Caption = 'CRMExport';
    Direction = Export;
    UseRequestPage = true;

    schema {
        textelement(RootNodeName) {
            tableelement("Event"; "Event") {
                fieldelement(DirectionCode; "Event"."Direction Code"){}
                fieldelement(EventDate; "Event"."Event Date") {}
                tableelement(RegistrationEntry; "Registration Entry") {
                    LinkTable = "Event";
                    LinkFields = "Direction Code" = field("Direction Code"),
                                 "Event Date" = field("Event Date");
                    fieldelement(Name; RegistrationEntry."Participant Name") {}
                    fieldelement(PhoneNo; RegistrationEntry."Participant Phone No.") {}
                    fieldelement(Email; RegistrationEntry."Participant E-mail") {}
                }
            }
        }
    }
}
