codeunit 50001 "Doc. Att. Ext" {

    local procedure DeleteAttachedDocuments(Rec: Record Lecture)
    var
        DocumentAttachment: Record "Document Attachment";
    begin
        if Rec.IsTemporary() then
            exit;
        if DocumentAttachment.IsEmpty() then
            exit;

        SetDocumentAttachmentFiltersForRecRef(DocumentAttachment, Rec);
        if Rec.IsEmpty() then
            DocumentAttachment.DeleteAll();
    end;

    local procedure SetDocumentAttachmentFiltersForRecRef(var DocumentAttachment: Record "Document Attachment"; Rec: Record Lecture)
    begin
        DocumentAttachment.SetRange("Table ID", Database::Lecture);
        DocumentAttachment.SetRange("No.", Rec."Code");
        DocumentAttachment.SetRange("Line No.", Rec."Additional Doc. index");
    end;

    [EventSubscriber(ObjectType::Table, Database::Lecture, 'OnAfterDeleteEvent', '', false, false)]
    local procedure DeleteAttachedDocumentsOnAfterDeleteEmployee(var Rec: Record Lecture; RunTrigger: Boolean)
    var
        RecRef: RecordRef;
    begin
        DeleteAttachedDocuments(Rec);
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Factbox", 'OnBeforeDrillDown', '', false, false)]
    local procedure DocAttOnBeforeDrillDown(DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef)
    var
        Lecture: Record Lecture;
    begin
        case DocumentAttachment."Table ID" of
            Database::Lecture:
                begin
                    RecRef.Open(Database::Lecture);
                    Lecture.SetRange("Code", DocumentAttachment."No.");
                    Lecture.SetRange("Additional Doc. index", DocumentAttachment."Line No.");
                    if Lecture.FindFirst() then begin
                        RecRef.GetTable(Lecture);
                    end;
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Page, Page::"Document Attachment Details", 'OnAfterOpenForRecRef', '', false, false)]
    local procedure DocAttOnAfterOpenForRecRef(var DocumentAttachment: Record "Document Attachment"; var RecRef: RecordRef; var FlowFieldsEditable: Boolean)
    var
        Lecture: Record Lecture;
        FieldRef: FieldRef;
        RecNo: Code[20];
        LineNo: Integer;
    begin
        case RecRef.Number of
            Database::Lecture:
                begin
                    FieldRef := RecRef.Field(2);
                    RecNo := FieldRef.Value();
                    DocumentAttachment.SetRange("No.", RecNo);

                    FieldRef := RecRef.Field(7);
                    LineNo := FieldRef.Value();
                    DocumentAttachment.SetRange("Line No.", LineNo);
                end;
        end;
    end;

}
