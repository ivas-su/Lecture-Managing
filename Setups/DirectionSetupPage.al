page 50004 "Direction Setup Page"
{
    
    Caption = 'Direction Setup Page';
    PageType = List;
    SourceTable = "Direction Setup";
    UsageCategory = Lists;
    ApplicationArea = All;
    
    layout {
        area(content) {
            group(General) {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
                field("Direction Nos."; Rec."Direction Nos.")
                {
                    ToolTip = 'Specifies the value of the Direction Nos. field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}
