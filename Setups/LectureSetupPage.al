page 50005 LectureSetupPage
{
    
    ApplicationArea = All;
    Caption = 'LectureSetupPage';
    PageType = List;
    SourceTable = "Lecture Setup";
    UsageCategory = Lists;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Lecture Nos."; Rec."Lecture Nos.")
                {
                    ToolTip = 'Specifies the value of the Lecture Nos. field.';
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                }
            }
        }
    }
    
}
