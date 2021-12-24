table 50002 Lecture {

    DataClassification = ToBeClassified;
    DataCaptionFields = "Code", Name, "Direction Name", "Prelector Name";
    Caption = 'Lecture';

    fields {
        field(1; "Direction Code"; Code[20]) {
            Caption = 'Direction Code';
            DataClassification = ToBeClassified;
            TableRelation = Direction."Code";
        }
        field(2; "Code"; Code[20]) {
            Caption = 'Code';
            Editable = false;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Rec."Code" <> xRec."Code" then begin
                    LectureSetup.Get();
                    NoSeriesManagement.TestManual(LectureSetup."Lecture Nos.");
                    Rec."Code" := '';
                end;
            end;

        }
        field(3; "Direction Name"; Text[50]) {
            Caption = 'Direction Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (
                Direction.Name where (
                    "Code" = field("Direction Code")
                )
            );
        }
        field(4; Name; Text[50]) {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(5; "Prelector Code"; Code[20]) {
            Caption = 'Prelector Code';
            TableRelation = Employee."No." where (
                "Direction Code" = field("Direction Code")
            );
        }
        field(6; "Prelector Name"; Text[50]) {
            Caption = 'Prelector Name';
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
            Editable = false;
            TableRelation = "No. Series";
        }
    }

    keys {
        key(PK; "Direction Code","Code", "Additional Doc. index") {
            Clustered = true;
        }
    }

    var
        LectureSetup : Record "Lecture Setup";
        NoSeriesManagement : Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if Rec."Code" = '' then begin
            LectureSetup.Get();
            LectureSetup.TestField("Lecture Nos.");
            NoSeriesManagement.InitSeries(
                LectureSetup."Lecture Nos.",
                xRec."No. Series",
                0D,
                Rec."Code",
                Rec."No. Series"
            );
        end;
    end;
    
}
