table 50004 "Registration Entry" {

    DataClassification = ToBeClassified;
    CaptionML = ENU = 'Registration Entry',
                RUS = 'Регистрация';

    fields {
        field(1; "Direction Code"; Code[20]) {
            CaptionML = ENU = 'Direction Code',
                        RUS = 'Код направления';
            TableRelation = Direction."Code";
        }
        field(2; "Event Date"; Date) {
            CaptionML = ENU = 'Event Date',
                        RUS = 'Дата мероприятия';
        }
        field(3; "Direction Name"; Text[50]) {
            CaptionML = ENU = 'Direction Code',
                        RUS = 'Название направление';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (
                Direction.Name where (
                    "Code" = field("Direction Code")
                )
            );
        }
        field(4; "Participant Contact No."; Code[20]) {
            CaptionML = ENU = 'Participant Contact No.',
                        RUS = 'Код участника';
            TableRelation = Contact."No." where(Type = const(Person));
        }
        field(5; "Participant Name"; Text[100]) {
            CaptionML = ENU = 'Particioant Name',
                        RUS = 'Имя участника';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (
                Contact.Name where (
                    "No." = field("Participant Contact No.")
                )
            );
        }
        field(6; "Participant E-mail"; Text[80]) {
            CaptionML = ENU = 'Participant E-mail',
                        RUS = 'Элю почта участника';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (
                Contact."E-Mail" where (
                    "No." = field("Participant Contact No.")
                )
            );
        }
        field(7; "Participant Phone No."; Text[30]) {
            CaptionML = ENU = 'Participant Phone No.',
                        RUS = 'Телефон участника';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (
                Contact."Phone No." where (
                    "No." = field("Participant Contact No.")
                )
            );
        }
        field(8; Registered; Boolean) {
            CaptionML = ENU = 'Registered',
                        RUS = 'Регистрация';
        }
        field(9; Present; Boolean) {
            CaptionML = ENU = 'Present',
                        RUS = 'Присуцтвие';
        }
    }
    
    keys {
        key(PK; "Direction Code", "Event Date", "Participant Contact No.") {
            Clustered = true;
        }
    }    
}
