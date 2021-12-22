page 50000 "Direction List" {
    
    CaptionML = ENU = 'List of directions',
                RUS = 'Список направлений';
    PageType = List;
    SourceTable = Direction;
    CardPageId = "Direction Card";
    Editable = false;
    UsageCategory = Lists;
    ApplicationArea = All;
    
    layout {
        area(content) {
            repeater(General) {
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
                    Lookup = true;
                    LookupPageId = "Employee List";
                    DrillDown = false;
                }
                field("Responsible Person Name"; Rec."Responsible Person Name") {
                    ToolTip = 'Specifies the value of the Responsible Person Name field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
