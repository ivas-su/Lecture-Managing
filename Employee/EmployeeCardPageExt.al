pageextension 50000 "Employee Page Ext" extends "Employee Card" {

    layout {
        addlast(General) {
            field("Direction Code"; Rec."Direction Code") {
                ApplicationArea = All;
            }
            field("Direction Name";Rec."Direction Name") {
                ApplicationArea = All;
            }
            field("Number of lectures";Rec."Number of lectures") {
                ApplicationArea = All;
            }
        }
    }

}
