page 50007 "Event List" {
    
    ApplicationArea = All;
    Caption = 'List of events';
    PageType = List;
    SourceTable = "Event";
    UsageCategory = Lists;
    Editable = false;
    CardPageId = "Event Doc. Page";
    
    layout {
        area(content) {
            repeater(General) {
                field("Direction Code"; Rec."Direction Code")
                {
                    ToolTip = 'Specifies the value of the "Direction Code" field.';
                    ApplicationArea = All;
                }
                field("Direction Name"; Rec."Direction Name")
                {
                    ToolTip = 'Specifies the value of the "Direction Name" field.';
                    ApplicationArea = All;
                }
                field("Event Date"; Rec."Event Date")
                {
                    ToolTip = 'Specifies the value of the "Event Date" field.';
                    ApplicationArea = All;
                }
                field("Lecture Code 1"; Rec."Lecture Code 1")
                {
                    ToolTip = 'Specifies the value of the "Lecture Code 1" field.';
                    ApplicationArea = All;
                }
                field("Lecture Name 1"; Rec."Lecture Name 1")
                {
                    ToolTip = 'Specifies the value of the "Lecture Name 1" field.';
                    ApplicationArea = All;
                }
                field("Prelector Code 1"; Rec."Prelector Code 1")
                {
                    ToolTip = 'Specifies the value of the "Prelector Code 1" field.';
                    ApplicationArea = All;
                }
                field("Prelector Name 1"; Rec."Prelector Name 1")
                {
                    ToolTip = 'Specifies the value of the "Prelector Name 1" field.';
                    ApplicationArea = All;
                }
                field("Lecture Code 2"; Rec."Lecture Code 2")
                {
                    ToolTip = 'Specifies the value of the "Lecture Code 2" field.';
                    ApplicationArea = All;
                }
                field("Lecture Name 2"; Rec."Lecture Name 2")
                {
                    ToolTip = 'Specifies the value of the "Lecture Name 2" field.';
                    ApplicationArea = All;
                }
                field("Prelector Code 2"; Rec."Prelector Code 2")
                {
                    ToolTip = 'Specifies the value of the "Prelector Code 2" field.';
                    ApplicationArea = All;
                }
                field("Prelector Name 2"; Rec."Prelector Name 2")
                {
                    ToolTip = 'Specifies the value of the "Prelector Name 2" field.';
                    ApplicationArea = All;
                }
                field("Number of people present"; Rec."Number of people present")
                {
                    ToolTip = 'Specifies the value of the "Number of people present" field.';
                    ApplicationArea = All;
                }
                field("Number of registered"; Rec."Number of registered")
                {
                    ToolTip = 'Specifies the value of the "Number of registered" field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions {
        area(Processing) {
            action("Export all events") {
                ApplicationArea = All;
                Image = XMLFile;
                Promoted = true;
                PromotedCategory = Process;
                PromotedOnly = true;
                Caption = 'Export all events';
                ToolTip = 'Exports data in xml';

                trigger OnAction()
                var
                    CrmXml: XmlPort CRMExport;
                begin
                    CrmXml.Run();
                end;

            }
        }
    }

}
