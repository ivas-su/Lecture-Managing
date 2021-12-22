// TODO: Set series in GUI
table 50003 "Lecture Setup" {
    DataClassification = ToBeClassified;
    
    fields {
        field(1; "No."; Code[20]) {
            Caption = 'No.';
            DataClassification = ToBeClassified;
        }
        field(2; "Lecture Nos."; Code[20]) {
            Caption = 'Lecture Nos.';
            TableRelation = "No. Series";
        }
    }
    
    keys {
        key(PK; "No.") {
            Clustered = true;
        }
    }    
}