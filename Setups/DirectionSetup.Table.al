table 50001 "Direction Setup" {

    DataClassification = ToBeClassified;
    
    fields {
        field(1; "No."; Code[20]) {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Direction Nos."; Code[20]) {
            Caption = 'Direction Nos.';
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
    }
    
    keys {
        key(PK; "No.") {
            Clustered = true;
        }
    }    
}