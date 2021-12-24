pageextension 50000 "Employee Card" extends "Employee Card" {

    layout {
        addlast(General) {
            field("Direction Code"; Rec."Direction Code") {
                ToolTip = 'Specifies the value of the "Direction code" field.';
                ApplicationArea = All;
            }
            field("Direction Name";Rec."Direction Name") {
                ToolTip = 'Specifies the value of the "Direction name" field.';
                ApplicationArea = All;
            }
            field("Number of lectures";Rec."Number of lectures") {
                ToolTip = 'Specifies the value of the "Number of lectures" field.';
                ApplicationArea = All;
            }
        }
    }

}
