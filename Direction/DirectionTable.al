table 50000 Direction {
    DataClassification = ToBeClassified;
    DataCaptionFields = "Code", Name, "Responsible Person Code", "Responsible Person Name";
    CaptionML = ENU='Direction', 
                RUS='Направление';

    fields {
        field(1; "Code"; Code[20]) {
            CaptionML = ENU = 'Code',
                        RUS = 'Код';
            Editable = false;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Rec."Code" <> xRec."Code" then begin
                    DirectionSetup.Get();
                    NoSeriesMgt.TestManual(DirectionSetup."Direction Nos.");
                    Rec."Code" := '';
                end;
            end;
        }
        field(2; Name; Text[50]) {
            CaptionML = ENU='Name', 
                        RUS='Название';
            DataClassification = ToBeClassified;
        }
        field(3; "Responsible Person Code"; Code[20]) {
            CaptionML = ENU='Responsible Person Code', 
                        RUS='Код ответственного';
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(4; "Responsible Person Name"; Text[100]) {
            CaptionML = ENU='Responsible Person Name', 
                        RUS='Имя ответственного';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (
                Employee."First Name" where (
                    "No." = field("Responsible Person Code")
                )
            );
        }
        field(97; "No. Series"; Code[20]) {
            CaptionML = ENU = 'No. Series',
                        RUS = 'Серия номеров';
            Editable = false;
            TableRelation = "No. Series";
        }
    }
    
    keys {
        key(PK; "Code") {
            Clustered = true;
        }
    }

    var
        DirectionSetup : Record "Direction Setup";
        NoSeriesMgt : Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if Rec."Code" = '' then begin
            DirectionSetup.Get();
            DirectionSetup.TestField("Direction Nos.");
            NoSeriesMgt.InitSeries(
                DirectionSetup."Direction Nos.",
                xRec."No. Series",
                0D,
                Rec."Code",
                Rec."No. Series"
            );
        end;
    end;
}