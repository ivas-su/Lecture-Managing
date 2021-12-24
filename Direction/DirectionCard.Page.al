page 50001 "Direction Card" {

    CaptionML = ENU = 'Direction Card',
                RUS = 'Направление';
    PageType = Card;
    SourceTable = Direction;
    
    layout {
        area(content) {
            group(General) {
                field("Code"; Rec."Code") {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name) {
                    ToolTip = 'Specifies the value of the Name field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Responsible Person Code"; Rec."Responsible Person Code") {
                    ToolTip = 'Specifies the value of the Responsible Person Code field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Responsible Person Name"; Rec."Responsible Person Name") {
                    ToolTip = 'Specifies the value of the Responsible Person Name field.';
                    ApplicationArea = All;
                    Lookup = false;
                    DrillDown = false;
                    AssistEdit = false;
                }
            }
        }
    }
}
