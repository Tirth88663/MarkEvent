class EventModel {
  String? eventName;
  String? aboutEvent;
  String? venue;
  String? organizer;

  EventModel({this.eventName, this.aboutEvent, this.venue, this.organizer});

  //receiving data from server
  factory EventModel.fromMap(map) {
    return EventModel(
      eventName: map['eventName'],
      aboutEvent: map['aboutEvent'],
      venue: map['venue'],
      organizer: map['organizer'],
    );
  }
  //sending data to server
  Map<String, dynamic> toMap() {
    return {
      'eventName': eventName,
      'aboutEvent': aboutEvent,
      'venue': venue,
      'organizer': organizer,
      "searchKeywords":
          setSearchParam(eventName!, aboutEvent!, venue!, organizer!),
    };
  }

  setSearchParam(
      String eventName, String aboutEvent, String venue, String organizer) {
    List<String> caseSearchList = [];
    String temp = " ";
    caseSearchList.add(temp);
    temp = "";
    for (int i = 0; i < eventName.length; i++) {
      temp = temp + eventName[i];
      caseSearchList.add(temp);
    }

    temp = "";
    for (int i = 0; i < aboutEvent.length; i++) {
      temp = temp + aboutEvent[i];
      caseSearchList.add(temp);
    }

    temp = "";
    for (int i = 0; i < venue.length; i++) {
      temp = temp + venue[i];
      caseSearchList.add(temp);
    }

    temp = "";
    for (int i = 0; i < organizer.length; i++) {
      temp = temp + organizer[i];
      caseSearchList.add(temp);
    }

    return caseSearchList;
  }
}
