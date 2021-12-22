table 50002 Lecture {

    DataClassification = ToBeClassified;
    DataCaptionFields = "Code", Name, "Direction Name", "Prelector Name";
    CaptionML = ENU='Lecture', 
                RUS='Лекция';

    fields {
        field(1; "Direction Code"; Code[20]) {
            CaptionML = ENU = 'Direction Code',
                        RUS = 'Код направление';
            DataClassification = ToBeClassified;
            TableRelation = Direction."Code";
        }
        field(2; "Code"; Code[20]) {
            CaptionML = ENU = 'Code',
                        RUS = 'Код лекции';
            Editable = false;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Rec."Code" <> xRec."Code" then begin
                    LectureSetup.Get();
                    NoSeriesMgt.TestManual(LectureSetup."Lecture Nos.");
                    Rec."Code" := '';
                end;
            end;

        }
        field(3; "Direction Name"; Text[50]) {
            CaptionML = ENU = 'Direction Name',
                        RUS = 'Название направлений';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (
                Direction.Name where (
                    "Code" = field("Direction Code")
                )
            );
        }
        field(4; Name; Text[50]) {
            CaptionML = ENU = 'Name',
                        RUS = 'Название лекции';
            DataClassification = ToBeClassified;
        }
        field(5; "Prelector Code"; Code[20]) {
            CaptionML = ENU = 'Prelector Code',
                        RUS = 'Код лектора';
            TableRelation = Employee."No." where (
                "Direction Code" = field("Direction Code")
            );
        }
        field(6; "Prelector Name"; Text[50]) {
            CaptionML = ENU = 'Prelector Name',
                        RUS = 'Имя лектора';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (
                Employee."First Name" where (
                    "No." = field("Prelector Code")
                )
            );
        }
        field(7; "Additional Doc. index"; Integer) {
            Editable = false;
            AutoIncrement = true;
        }
        field(97; "No. Series"; Code[20]) {
            Caption = 'No. Series';
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys {
        key(PK; "Direction Code","Code") {
            Clustered = true;
        }
    }

    var
        LectureSetup : Record "Lecture Setup";
        NoSeriesMgt : Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if Rec."Code" = '' then begin
            LectureSetup.Get();
            LectureSetup.TestField("Lecture Nos.");
            NoSeriesMgt.InitSeries(
                LectureSetup."Lecture Nos.",
                xRec."No. Series",
                0D,
                Rec."Code",
                Rec."No. Series"
            );
        end;
    end;
    
}
