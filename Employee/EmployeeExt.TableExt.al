tableextension 50001 EmployeeExt extends Employee {
    fields {
        field(50000; "Direction Code"; Code[20])
        {
            CaptionML = ENU = 'Direction Code',
                        RUS = 'Код направления';
            DataClassification = ToBeClassified;
            TableRelation = Direction."Code";
        }
        field(50001; "Direction Name"; Text[50])
        {
            CaptionML = ENU = 'Direction Name',
                        RUS = 'Название направления';
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
            CaptionML = ENU = 'Number of lectures',
                        RUS = 'Количество лекций';
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
