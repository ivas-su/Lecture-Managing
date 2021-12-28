page 50004 "Direction Setup"
{

    Caption = 'Direction Setup Page';
    PageType = Card;
    SourceTable = "Direction Setup";
    UsageCategory = Administration;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
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
