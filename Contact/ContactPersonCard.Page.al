page 50010 "Contact Person Card"
{
    
    PageType = Card;
    SourceTable = Contact;
    Caption = 'Contact Person Card';
    
    layout
    {
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the "No." field.';
                    ApplicationArea = All;
                    Caption = 'Contact code';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the "Name" field.';
                    ApplicationArea = All;
                    Caption = 'Name';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the "Address" field.';
                    ApplicationArea = All;
                    Caption = 'Address';
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the "Phone No." field.';
                    ApplicationArea = All;
                    Caption = 'Phone No.';
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the "Email" field.';
                    ApplicationArea = All;
                    Caption = 'E-mail';
                }
                field("Company No."; Rec."Company No.")
                {
                    ToolTip = 'Specifies the value of the "Company No." field.';
                    ApplicationArea = All;
                    Caption = 'Company No.';
                }
                field("Job Title"; Rec."Job Title")
                {
                    ToolTip = 'Specifies the value of the "Job Title" field.';
                    ApplicationArea = All;
                    Caption = 'Job title';
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        rec.Type := rec.Type::Person;
    end;
    
}
