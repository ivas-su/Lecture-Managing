table 50000 Direction {
    DataClassification = ToBeClassified;
    DataCaptionFields = "Code", Name, "Responsible Person Code", "Responsible Person Name";
    Caption = 'Direction';

    fields {
        field(1; "Code"; Code[20]) {
            Caption = 'Code';
            Editable = false;
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                if Rec."Code" <> xRec."Code" then begin
                    DirectionSetup.Get();
                    NoSeriesManagement.TestManual(DirectionSetup."Direction Nos.");
                    Rec."Code" := '';
                end;
            end;
        }
        field(2; Name; Text[50]) {
            Caption = 'Name';
            DataClassification = ToBeClassified;
        }
        field(3; "Responsible Person Code"; Code[20]) {
            Caption = 'Responsible Person Code';
            DataClassification = ToBeClassified;
            TableRelation = Employee."No.";
        }
        field(4; "Responsible Person Name"; Text[100]) {
            Caption = 'Responsible Person Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (
                Employee."First Name" where (
                    "No." = field("Responsible Person Code")
                )
            );
        }
        field(97; "No. Series"; Code[20]) {
            Caption = 'No. Series';
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
        NoSeriesManagement : Codeunit NoSeriesManagement;

    trigger OnInsert()
    begin
        if Rec."Code" = '' then begin
            DirectionSetup.Get();
            DirectionSetup.TestField("Direction Nos.");
            NoSeriesManagement.InitSeries(
                DirectionSetup."Direction Nos.",
                xRec."No. Series",
                0D,
                Rec."Code",
                Rec."No. Series"
            );
        end;
    end;
}