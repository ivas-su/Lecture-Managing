page 50002 "Lecture List" {
    
    CaptionML = ENU = 'List of lectures',
                RUS = 'Список лекций';
    PageType = List;
    SourceTable = Lecture;
    CardPageId = "Lecture Card";
    Editable = false;
    UsageCategory = Lists;
    ApplicationArea = All;
    
    layout {
        area(content) {
            repeater(General) {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the Code field.';
                    ApplicationArea = All;
                }
                field("Direction Code"; Rec."Direction Code")
                {
                    ToolTip = 'Specifies the value of the Direction Code field.';
                    ApplicationArea = All;
                }
                field("Direction Name"; Rec."Direction Name")
                {
                    ToolTip = 'Specifies the value of the Direction Name field.';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the Name field.';
                    ApplicationArea = All;
                }
                field("Prelector Code"; Rec."Prelector Code")
                {
                    ToolTip = 'Specifies the value of the Prelector Code field.';
                    ApplicationArea = All;
                }
                field("Prelector Name"; Rec."Prelector Name")
                {
                    ToolTip = 'Specifies the value of the Prelector Name field.';
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes) {
            part("Attached Documents"; "Document Attachment Factbox") {
                ApplicationArea = All;
                CaptionML = ENU = 'Attachments',
                            RUS = 'Вложения';
                SubPageLink = "Table ID" = const(50002),
                              "No." = field("Code");
                // FIXME: add field "Additional code" to Document attachment
            }
        }
    }
}
