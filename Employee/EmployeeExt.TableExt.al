tableextension 50001 EmployeeExt extends Employee {
    fields {
        field(50000; "Direction Code"; Code[20])
        {
            Caption = 'Direction Code';
            DataClassification = ToBeClassified;
            TableRelation = Direction."Code";
        }
        field(50001; "Direction Name"; Text[50])
        {
            Caption = 'Direction Name';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup (
                Direction.Name where (
                    "Code" = field("Direction Code")
                )
            );

        }
        field(50002; "Number of lectures"; Integer)
        {
            Caption = 'Number of lectures';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = count (
                Lecture where (
                    "Prelector Code" = field("No.")
                )
            );
        }
    }
}
