table 50004 "Registration Entry" {

    DataClassification = ToBeClassified;
    Caption = 'Registration Entry';

    fields {
        field(1; "Direction Code"; Code[20]) {
            Caption = 'Direction Code';
            TableRelation = Direction."Code";
        }
        field(2; "Event Date"; Date) {
            Caption = 'Event Date';
        }
        field(3; "Direction Name"; Text[50]) {
            Caption = 'Direction Code';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (
                Direction.Name where (
                    "Code" = field("Direction Code")
                )
            );
        }
        field(4; "Participant Contact No."; Code[20]) {
            Caption = 'Participant Contact No.';
            TableRelation = Contact."No." where(Type = const(Person));
        }
        field(5; "Participant Name"; Text[100]) {
            Caption = 'Particioant Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (
                Contact.Name where (
                    "No." = field("Participant Contact No.")
                )
            );
        }
        field(6; "Participant E-mail"; Text[80]) {
            Caption = 'Participant E-mail';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (
                Contact."E-Mail" where (
                    "No." = field("Participant Contact No.")
                )
            );
        }
        field(7; "Participant Phone No."; Text[30]) {
            Caption = 'Participant Phone No.';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (
                Contact."Phone No." where (
                    "No." = field("Participant Contact No.")
                )
            );
        }
        field(8; Registered; Boolean) {
            Caption = 'Registered';
        }
        field(9; Present; Boolean) {
            Caption = 'Present';
        }
    }
    
    keys {
        key(PK; "Direction Code", "Event Date", "Participant Contact No.") {
            Clustered = true;
        }
    }    
}
