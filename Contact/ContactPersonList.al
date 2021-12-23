page 50009 "Contact Person List"
{
    
    CaptionML = ENU = 'Contact Person List',
                RUS = 'Список контактов';
    PageType = List;
    SourceTable = Contact;
    SourceTableView = where (Type = const(Person));
    Editable = false;
    CardPageId = "Contact Person Card";
    UsageCategory = Lists;
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("No."; Rec."No.")
                {
                    ToolTip = 'Specifies the value of the No. field.';
                    ApplicationArea = All;
                    CaptionML = ENU = 'No.',
                                RUS = 'Код участника';
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                    ApplicationArea = All;
                    CaptionML = ENU = 'Name',
                                RUS = 'Имя участника';
                }
                field(Address; Rec.Address)
                {
                    ToolTip = 'Specifies the value of the Address field.';
                    ApplicationArea = All;
                }
                field("Phone No."; Rec."Phone No.")
                {
                    ToolTip = 'Specifies the value of the Phone No. field.';
                    ApplicationArea = All;
                }
                field("E-Mail"; Rec."E-Mail")
                {
                    ToolTip = 'Specifies the value of the Email field.';
                    ApplicationArea = All;
                }
                field("Company No."; Rec."Company No.")
                {
                    ToolTip = 'Specifies the value of the Company No. field.';
                    ApplicationArea = All;
                }
                field("Job Title"; Rec."Job Title")
                {
                    ToolTip = 'Specifies the value of the Job Title field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    procedure SetSelection(VAR Contact : Record Contact)
    begin
        CurrPage.SETSELECTIONFILTER(Contact);
    end;
    
}
