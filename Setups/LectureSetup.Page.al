page 50005 "Lecture Setup"
{
    
    Caption = 'Lecture Setup Page';
    PageType = Card;
    SourceTable = "Lecture Setup";
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
                field("Lecture Nos."; Rec."Lecture Nos.")
                {
                    ToolTip = 'Specifies the value of the Lecture Nos. field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    
}
