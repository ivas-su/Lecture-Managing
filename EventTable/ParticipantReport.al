report 50000 Participant
{
    Caption = 'Participant';
    DefaultLayout = RDLC;
    RDLCLayout = 'EventTable/Participant.rdl';

    dataset {
        dataitem("Event"; "Event") {
            column(DirectionCode; "Direction Code") { IncludeCaption = true; }
            column(EventDate; "Event Date") { IncludeCaption = true; }
            column(DirectionName; "Direction Name") { IncludeCaption = true; }
            column(LectureName1; "Lecture Name 1") { IncludeCaption = true; }
            column(PrelectorName1; "Prelector Name 1") { IncludeCaption = true; }
            column(LectureName2; "Lecture Name 2") { IncludeCaption = true; }
            column(PrelectorName2; "Prelector Name 2") { IncludeCaption = true; }
            dataitem("Registration Entry";"Registration Entry") {
                column(Participant_Name;"Participant Name") { IncludeCaption = true; }
                column(Participant_Phone_No_;"Participant Phone No.") { IncludeCaption = true; }
                column(Direction_Code;"Direction Code") { IncludeCaption = true; }
                column(Event_Date;"Event Date") { IncludeCaption = true; }
                column(Participant_E_mail;"Participant E-mail") { IncludeCaption = true; }
                column(Present;Present) { IncludeCaption = true; }
                column(Registered;Registered) { IncludeCaption = true; }
                column(RegisteredCounter;RegisteredCounter) {}
                column(RegisteredButNotPresentCounter;RegisteredButNotPresentCounter) {}
                column(ReportTitle;ReportTitle) {}
                column(Visitors;Visitors) {}
                column(RegisteredButNotPresent;RegisteredButNotPresent) {}

                trigger OnPreDataItem()
                begin
                    RegisteredCounter := 0;
                    RegisteredButNotPresentCounter := 0;
                end;

                trigger OnAfterGetRecord()
                begin
                    RegisteredCounter += 1;
                    if not "Registration Entry".Present and "Registration Entry".Registered then begin
                        RegisteredButNotPresentCounter += 1;
                    end;
                end;

            }
        }
    }

   
    var
        RegisteredCounter: Integer;
        PrelectorComment: label 'Prelector Comment';
        RegisteredButNotPresentCounter: Integer;
        ReportTitle: TextConst ENU = 'Report header', RUS = 'Заголовк отчета';
        Visitors: TextConst ENU = 'Visitors', RUS = 'Посетители';
        RegisteredButNotPresent: TextConst ENU = 'Registered, but not visited', RUS = 'Зарегестрированые, но не посетившие';
}
