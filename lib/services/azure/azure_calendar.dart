import 'dart:convert';
import 'package:dio/dio.dart';
import '../../models/user_model.dart';

class AzureCalendarService {
  static const String _graphEndpoint = 'https://graph.microsoft.com/v1.0';
  
  final Dio _dio;
  String? _accessToken;
  
  AzureCalendarService({Dio? dio}) : _dio = dio ?? Dio();
  
  /// Initialize the calendar service with access token
  Future<void> initialize(String accessToken) async {
    _accessToken = accessToken;
    _dio.options.baseUrl = _graphEndpoint;
    _dio.options.headers['Authorization'] = 'Bearer $accessToken';
    _dio.options.headers['Content-Type'] = 'application/json';
  }
  
  /// Create a calendar event
  Future<CalendarEvent> createEvent({
    required String subject,
    required String body,
    required DateTime startTime,
    required DateTime endTime,
    required String timeZone,
    List<String>? attendeeEmails,
    String? location,
    bool isAllDay = false,
    EventImportance importance = EventImportance.normal,
    String? categories,
  }) async {
    try {
      final eventData = {
        'subject': subject,
        'body': {
          'contentType': 'HTML',
          'content': body,
        },
        'start': {
          'dateTime': startTime.toIso8601String(),
          'timeZone': timeZone,
        },
        'end': {
          'dateTime': endTime.toIso8601String(),
          'timeZone': timeZone,
        },
        'isAllDay': isAllDay,
        'importance': importance.name,
        if (location != null) 'location': {
          'displayName': location,
        },
        if (attendeeEmails != null && attendeeEmails.isNotEmpty)
          'attendees': attendeeEmails.map((email) => {
            'emailAddress': {
              'address': email,
              'name': email,
            },
            'type': 'required',
          }).toList(),
        if (categories != null) 'categories': [categories],
      };
      
      final response = await _dio.post('/me/events', data: eventData);
      
      return CalendarEvent.fromJson(response.data);
    } catch (e) {
      throw CalendarException('Failed to create event: $e');
    }
  }
  
  /// Get calendar events for a date range
  Future<List<CalendarEvent>> getEvents({
    DateTime? startTime,
    DateTime? endTime,
    int? top,
    String? filter,
    String? orderBy,
  }) async {
    try {
      final queryParams = <String, String>{};
      
      if (startTime != null && endTime != null) {
        queryParams['\$filter'] = 
            "start/dateTime ge '${startTime.toIso8601String()}' and start/dateTime lt '${endTime.toIso8601String()}'";
      }
      
      if (filter != null) {
        final existingFilter = queryParams['\$filter'];
        queryParams['\$filter'] = existingFilter != null 
            ? '$existingFilter and $filter'
            : filter;
      }
      
      if (orderBy != null) {
        queryParams['\$orderby'] = orderBy;
      }
      
      if (top != null) {
        queryParams['\$top'] = top.toString();
      }
      
      final response = await _dio.get(
        '/me/events',
        queryParameters: queryParams,
      );
      
      final events = response.data['value'] as List;
      return events.map((event) => CalendarEvent.fromJson(event)).toList();
    } catch (e) {
      throw CalendarException('Failed to get events: $e');
    }
  }
  
  /// Get a specific event by ID
  Future<CalendarEvent?> getEvent(String eventId) async {
    try {
      final response = await _dio.get('/me/events/$eventId');
      return CalendarEvent.fromJson(response.data);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      throw CalendarException('Failed to get event: $e');
    }
  }
  
  /// Update an existing event
  Future<CalendarEvent> updateEvent({
    required String eventId,
    String? subject,
    String? body,
    DateTime? startTime,
    DateTime? endTime,
    String? timeZone,
    List<String>? attendeeEmails,
    String? location,
    bool? isAllDay,
    EventImportance? importance,
  }) async {
    try {
      final updateData = <String, dynamic>{};
      
      if (subject != null) updateData['subject'] = subject;
      if (body != null) {
        updateData['body'] = {
          'contentType': 'HTML',
          'content': body,
        };
      }
      if (startTime != null && timeZone != null) {
        updateData['start'] = {
          'dateTime': startTime.toIso8601String(),
          'timeZone': timeZone,
        };
      }
      if (endTime != null && timeZone != null) {
        updateData['end'] = {
          'dateTime': endTime.toIso8601String(),
          'timeZone': timeZone,
        };
      }
      if (isAllDay != null) updateData['isAllDay'] = isAllDay;
      if (importance != null) updateData['importance'] = importance.name;
      if (location != null) {
        updateData['location'] = {'displayName': location};
      }
      if (attendeeEmails != null) {
        updateData['attendees'] = attendeeEmails.map((email) => {
          'emailAddress': {
            'address': email,
            'name': email,
          },
          'type': 'required',
        }).toList();
      }
      
      final response = await _dio.patch('/me/events/$eventId', data: updateData);
      
      return CalendarEvent.fromJson(response.data);
    } catch (e) {
      throw CalendarException('Failed to update event: $e');
    }
  }
  
  /// Delete an event
  Future<void> deleteEvent(String eventId) async {
    try {
      await _dio.delete('/me/events/$eventId');
    } catch (e) {
      throw CalendarException('Failed to delete event: $e');
    }
  }
  
  /// Get user's calendars
  Future<List<Calendar>> getCalendars() async {
    try {
      final response = await _dio.get('/me/calendars');
      
      final calendars = response.data['value'] as List;
      return calendars.map((cal) => Calendar.fromJson(cal)).toList();
    } catch (e) {
      throw CalendarException('Failed to get calendars: $e');
    }
  }
  
  /// Create a reminder for a need
  Future<CalendarEvent> createNeedReminder({
    required String needId,
    required String needTitle,
    required DateTime reminderTime,
    String? description,
    String timeZone = 'UTC',
  }) async {
    final subject = 'YOLO Need Reminder: $needTitle';
    final body = description ?? 'Reminder for your need: $needTitle';
    
    return await createEvent(
      subject: subject,
      body: body,
      startTime: reminderTime,
      endTime: reminderTime.add(const Duration(minutes: 15)),
      timeZone: timeZone,
      importance: EventImportance.high,
      categories: 'YOLO Need',
    );
  }
  
  /// Create appointment with helper
  Future<CalendarEvent> createHelperAppointment({
    required String needId,
    required String needTitle,
    required String helperEmail,
    required DateTime appointmentTime,
    required Duration duration,
    String? location,
    String? notes,
    String timeZone = 'UTC',
  }) async {
    final subject = 'YOLO Help Session: $needTitle';
    final body = '''
<h3>YOLO Need Help Session</h3>
<p><strong>Need:</strong> $needTitle</p>
<p><strong>Need ID:</strong> $needId</p>
${notes != null ? '<p><strong>Notes:</strong> $notes</p>' : ''}
<p>This is a scheduled help session through the YOLO Need App.</p>
''';
    
    return await createEvent(
      subject: subject,
      body: body,
      startTime: appointmentTime,
      endTime: appointmentTime.add(duration),
      timeZone: timeZone,
      attendeeEmails: [helperEmail],
      location: location,
      importance: EventImportance.high,
      categories: 'YOLO Help Session',
    );
  }
  
  /// Get upcoming reminders
  Future<List<CalendarEvent>> getUpcomingReminders({
    int daysAhead = 7,
  }) async {
    final now = DateTime.now();
    final endTime = now.add(Duration(days: daysAhead));
    
    return await getEvents(
      startTime: now,
      endTime: endTime,
      filter: "categories/any(c: c eq 'YOLO Need')",
      orderBy: 'start/dateTime',
    );
  }
  
  /// Check availability for a time slot
  Future<bool> checkAvailability({
    required DateTime startTime,
    required DateTime endTime,
    String timeZone = 'UTC',
  }) async {
    try {
      final requestData = {
        'schedules': ['me'],
        'startTime': {
          'dateTime': startTime.toIso8601String(),
          'timeZone': timeZone,
        },
        'endTime': {
          'dateTime': endTime.toIso8601String(),
          'timeZone': timeZone,
        },
        'availabilityViewInterval': 60,
      };
      
      final response = await _dio.post('/me/calendar/getSchedule', data: requestData);
      
      final schedules = response.data['value'] as List;
      if (schedules.isNotEmpty) {
        final schedule = schedules.first;
        final busyTimes = schedule['busyViewData'] as String?;
        
        // If all slots are free (represented by '0'), then available
        return busyTimes?.contains('1') != true;
      }
      
      return true;
    } catch (e) {
      throw CalendarException('Failed to check availability: $e');
    }
  }
  
  /// Find meeting times
  Future<List<MeetingTimeSuggestion>> findMeetingTimes({
    required List<String> attendeeEmails,
    required Duration duration,
    DateTime? earliestTime,
    DateTime? latestTime,
    int maxCandidates = 20,
    String timeZone = 'UTC',
  }) async {
    try {
      final requestData = {
        'attendees': attendeeEmails.map((email) => {
          'emailAddress': {
            'address': email,
            'name': email,
          },
        }).toList(),
        'timeConstraint': {
          'timeslots': [
            {
              'start': {
                'dateTime': (earliestTime ?? DateTime.now()).toIso8601String(),
                'timeZone': timeZone,
              },
              'end': {
                'dateTime': (latestTime ?? DateTime.now().add(const Duration(days: 7))).toIso8601String(),
                'timeZone': timeZone,
              },
            }
          ]
        },
        'meetingDuration': 'PT${duration.inMinutes}M',
        'maxCandidates': maxCandidates,
      };
      
      final response = await _dio.post('/me/calendar/getSchedule', data: requestData);
      
      final suggestions = response.data['meetingTimeSuggestions'] as List? ?? [];
      return suggestions.map((s) => MeetingTimeSuggestion.fromJson(s)).toList();
    } catch (e) {
      throw CalendarException('Failed to find meeting times: $e');
    }
  }
  
  /// Send meeting invitation
  Future<void> sendMeetingInvitation({
    required String eventId,
    String? comment,
  }) async {
    try {
      final requestData = {
        if (comment != null) 'comment': comment,
      };
      
      await _dio.post('/me/events/$eventId/forward', data: requestData);
    } catch (e) {
      throw CalendarException('Failed to send invitation: $e');
    }
  }
  
  /// Get calendar permissions
  Future<List<CalendarPermission>> getCalendarPermissions(String calendarId) async {
    try {
      final response = await _dio.get('/me/calendars/$calendarId/calendarPermissions');
      
      final permissions = response.data['value'] as List;
      return permissions.map((p) => CalendarPermission.fromJson(p)).toList();
    } catch (e) {
      throw CalendarException('Failed to get permissions: $e');
    }
  }
}

/// Calendar Event model
class CalendarEvent {
  final String id;
  final String subject;
  final String body;
  final DateTime start;
  final DateTime end;
  final String timeZone;
  final bool isAllDay;
  final EventImportance importance;
  final String? location;
  final List<String> attendees;
  final List<String> categories;
  final EventStatus status;
  final String? webLink;
  
  CalendarEvent({
    required this.id,
    required this.subject,
    required this.body,
    required this.start,
    required this.end,
    required this.timeZone,
    required this.isAllDay,
    required this.importance,
    this.location,
    required this.attendees,
    required this.categories,
    required this.status,
    this.webLink,
  });
  
  factory CalendarEvent.fromJson(Map<String, dynamic> json) {
    final startData = json['start'] as Map<String, dynamic>;
    final endData = json['end'] as Map<String, dynamic>;
    
    return CalendarEvent(
      id: json['id'] ?? '',
      subject: json['subject'] ?? '',
      body: json['body']?['content'] ?? '',
      start: DateTime.parse(startData['dateTime']),
      end: DateTime.parse(endData['dateTime']),
      timeZone: startData['timeZone'] ?? 'UTC',
      isAllDay: json['isAllDay'] ?? false,
      importance: EventImportance.values.firstWhere(
        (e) => e.name == json['importance'],
        orElse: () => EventImportance.normal,
      ),
      location: json['location']?['displayName'],
      attendees: (json['attendees'] as List? ?? [])
          .map((a) => a['emailAddress']['address'] as String)
          .toList(),
      categories: List<String>.from(json['categories'] ?? []),
      status: EventStatus.values.firstWhere(
        (e) => e.name == json['showAs'],
        orElse: () => EventStatus.busy,
      ),
      webLink: json['webLink'],
    );
  }
}

/// Calendar model
class Calendar {
  final String id;
  final String name;
  final String color;
  final bool isDefaultCalendar;
  final String changeKey;
  final bool canShare;
  final bool canViewPrivateItems;
  final bool canEdit;
  final String owner;
  
  Calendar({
    required this.id,
    required this.name,
    required this.color,
    required this.isDefaultCalendar,
    required this.changeKey,
    required this.canShare,
    required this.canViewPrivateItems,
    required this.canEdit,
    required this.owner,
  });
  
  factory Calendar.fromJson(Map<String, dynamic> json) {
    return Calendar(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      color: json['color'] ?? '',
      isDefaultCalendar: json['isDefaultCalendar'] ?? false,
      changeKey: json['changeKey'] ?? '',
      canShare: json['canShare'] ?? false,
      canViewPrivateItems: json['canViewPrivateItems'] ?? false,
      canEdit: json['canEdit'] ?? false,
      owner: json['owner']?['address'] ?? '',
    );
  }
}

/// Meeting Time Suggestion model
class MeetingTimeSuggestion {
  final DateTime start;
  final DateTime end;
  final double confidence;
  final String organizerAvailability;
  final List<AttendeeAvailability> attendeeAvailability;
  
  MeetingTimeSuggestion({
    required this.start,
    required this.end,
    required this.confidence,
    required this.organizerAvailability,
    required this.attendeeAvailability,
  });
  
  factory MeetingTimeSuggestion.fromJson(Map<String, dynamic> json) {
    final meetingTime = json['meetingTimeSlot'] as Map<String, dynamic>;
    final startData = meetingTime['start'] as Map<String, dynamic>;
    final endData = meetingTime['end'] as Map<String, dynamic>;
    
    return MeetingTimeSuggestion(
      start: DateTime.parse(startData['dateTime']),
      end: DateTime.parse(endData['dateTime']),
      confidence: (json['confidence'] ?? 0).toDouble(),
      organizerAvailability: json['organizerAvailability'] ?? '',
      attendeeAvailability: (json['attendeeAvailability'] as List? ?? [])
          .map((a) => AttendeeAvailability.fromJson(a))
          .toList(),
    );
  }
}

/// Attendee Availability model
class AttendeeAvailability {
  final String email;
  final String availability;
  
  AttendeeAvailability({
    required this.email,
    required this.availability,
  });
  
  factory AttendeeAvailability.fromJson(Map<String, dynamic> json) {
    return AttendeeAvailability(
      email: json['attendee']?['emailAddress']?['address'] ?? '',
      availability: json['availability'] ?? '',
    );
  }
}

/// Calendar Permission model
class CalendarPermission {
  final String id;
  final bool isRemovable;
  final bool isInsideOrganization;
  final String role;
  final List<String> allowedRoles;
  final String emailAddress;
  
  CalendarPermission({
    required this.id,
    required this.isRemovable,
    required this.isInsideOrganization,
    required this.role,
    required this.allowedRoles,
    required this.emailAddress,
  });
  
  factory CalendarPermission.fromJson(Map<String, dynamic> json) {
    return CalendarPermission(
      id: json['id'] ?? '',
      isRemovable: json['isRemovable'] ?? false,
      isInsideOrganization: json['isInsideOrganization'] ?? false,
      role: json['role'] ?? '',
      allowedRoles: List<String>.from(json['allowedRoles'] ?? []),
      emailAddress: json['emailAddress']?['address'] ?? '',
    );
  }
}

/// Event Importance enum
enum EventImportance {
  low,
  normal,
  high,
}

/// Event Status enum
enum EventStatus {
  free,
  tentative,
  busy,
  oof,
  workingElsewhere,
}

/// Custom exception for calendar operations
class CalendarException implements Exception {
  final String message;
  
  const CalendarException(this.message);
  
  @override
  String toString() => 'CalendarException: $message';
} 