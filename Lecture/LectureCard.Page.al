page 50003 "Lecture Card" {
    
    Caption = 'Lecture Card';
    PageType = Card;
    SourceTable = Lecture;
    
    layout {
        area(content) {
            group(General) {
                field("Code"; Rec."Code")
                {
                    ToolTip = 'Specifies the value of the "Code" field.';
                    ApplicationArea = All;
                }
                field("Direction Code"; Rec."Direction Code")
                {
                    ToolTip = 'Specifies the value of the "Direction Code" field.';
                    ApplicationArea = All;
                    Lookup = true;
                }
                field("Direction Name"; Rec."Direction Name")
                {
                    ToolTip = 'Specifies the value of the "Direction Name" field.';
                    ApplicationArea = All;
                }
                field(Name; Rec.Name)
                {
                    ToolTip = 'Specifies the value of the "Name" field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Prelector Code"; Rec."Prelector Code")
                {
                    ToolTip = 'Specifies the value of the "Prelector Code" field.';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Prelector Name"; Rec."Prelector Name")
                {
                    ToolTip = 'Specifies the value of the "Prelector Name" field.';
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes) {
            part("Attachmed Documents"; "Document Attachment Factbox") {
                ApplicationArea = All;
                Caption = 'Attachemts';
                SubPageLink = "Table ID" = const(50002),
                              "No." = field("Code"),
                              "Line No." = field("Additional Doc. index");
            }
        }
    }
}
