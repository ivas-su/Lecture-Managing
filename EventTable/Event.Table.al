table 50005 "Event" {

    DataClassification = ToBeClassified;
    DataCaptionFields = "Direction Name", "Event Date", "Lecture Name 1", "Prelector Name 1", "Lecture Name 2", "Prelector Name 2";
    CaptionML = ENU = 'Event',
                RUS = 'Мероприятие';
    
    fields {
        field(1; "Direction Code"; Code[20]) {
            CaptionML = ENU = 'Direction Code',
                        RUS = 'Код направления';
            DataClassification = ToBeClassified;
            TableRelation = Direction."Code";
        }
        field(2; "Event Date"; Date) {
            CaptionML = ENU = 'Event Date',
                        RUS = 'Дата мероприятия';
        }
        field(3; "Direction Name"; Text[100]) {
            CaptionML = ENU = 'Direction Name',
                        RUS = 'Название мероприятия';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (
                Direction.Name where (
                    "Code" = field("Direction Code")
                )
            );
        }
        field(4; "Lecture Code 1"; Code[20]) {
            CaptionML = ENU = 'Lecture Code 1',
                        RUS = 'Код лекции 1';
            TableRelation = Lecture."Code" where (
                "Direction Code" = field("Direction Code")
            );

            trigger OnValidate()
            begin
                checkValidLectureCodes("Lecture Code 1", "Lecture Code 2");
            end;

        }
        field(5; "Lecture Name 1"; Text[50]) {
            CaptionML = ENU = 'Lecture Name 1',
                        RUS = 'Название лекции 1';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (
                Lecture.Name where (
                    "Code" = field("Lecture Code 1")
                )
            );
        }
        field(6; "Prelector Code 1"; Code[20]) {
            CaptionML = ENU = 'Prelector Code 1',
                        RUS = 'Код лектора 1';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (
                Lecture."Prelector Code" where (
                    "Code" = field("Lecture Code 1")
                )
            );
        }
        field(7; "Prelector Name 1"; Text[50]) {
            CaptionML = ENU = 'Prelector Name 1',
                        RUS = 'Имя лектора 1';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (
                Employee."First Name" where (
                    "No." = field("Prelector Code 1")
                )
            );
        }
        field(8; "Lecture Code 2"; Code[20]) {
            CaptionML = ENU = 'Lecture Code 2',
                        RUS = 'Код лекции 2';
            TableRelation = Lecture."Code" where (
                "Direction Code" = field("Direction Code")
            );

            trigger OnValidate()
            begin
                checkValidLectureCodes("Lecture Code 1", "Lecture Code 2");
            end;

        }
        field(9; "Lecture Name 2"; Text[50]) {
            CaptionML = ENU = 'Lecture Name 2',
                        RUS = 'Название лекции 2';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (
                Lecture.Name where (
                    "Code" = field("Lecture Code 2")
                )
            );
        }
        field(10; "Prelector Code 2"; Code[20]) {
            CaptionML = ENU = 'Prelector Code 2',
                        RUS = 'Код лектора 2';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (
                Lecture."Prelector Code" where (
                    "Code" = field("Lecture Code 2")
                )
            );
        }
        field(11; "Prelector Name 2"; Text[50]) {
            CaptionML = ENU = 'Prelector Name 2',
                        RUS = 'Имя лектора 2';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (
                Employee."First Name" where (
                    "No." = field("Prelector Code 2")
                )
            );
        }
        field(12; "Number of registered"; Integer) {
            CaptionML = ENU = 'Number of registered',
                        RUS = 'Количество зарегестрированых';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count (
                "Registration Entry" where (
                    "Direction Code" = field("Direction Code"),
                    Registered = const(true)
                )
            );
        }
        field(13; "Number of people present"; Integer) {
            CaptionML = ENU = 'Number of present',
                        RUS = 'Количество присуцтвующих';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count (
                "Registration Entry" where (
                    "Direction Code" = field("Direction Code"),
                    Present = const(true)
                )
            );
        }
    }
    
    keys {
        key(PK; "Direction Code", "Event Date") {
            Clustered = true;
        }
    }

    local procedure checkValidLectureCodes(lection1: Code[20]; lection2: Code[20])
    var
        InsertErr : TextConst ENU = 'Cannot insert two simular lections', RUS = 'Нельхя добалять две одинаковые лекции';
    begin
        if lection1 = lection2 then
            Error(InsertErr);
    end;

}