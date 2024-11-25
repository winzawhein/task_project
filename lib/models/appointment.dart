// lib/models/appointment.dart
class Appointment {
  final int? id;
  final String title;
  final String customerName;
  final String company;
  final String description;
  final DateTime appointmentDate;
  final String location;

  Appointment({
    this.id,
    required this.title,
    required this.customerName,
    required this.company,
    required this.description,
    required this.appointmentDate,
    required this.location,
  });

  // Method to convert an Appointment to a Map (for SQLite insertion)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'customerName': customerName,
      'company': company,
      'description': description,
      'appointmentDate': appointmentDate.toIso8601String(),  // Store as ISO8601 string
      'location': location,
    };
  }

  // Method to create an Appointment instance from a Map (for reading from SQLite)
  factory Appointment.fromMap(Map<String, dynamic> map) {
    return Appointment(
      id: map['id'],
      title: map['title'],
      customerName: map['customerName'],
      company: map['company'],
      description: map['description'],
      appointmentDate: DateTime.parse(map['appointmentDate']),
      location: map['location'],
    );
  }

  // Method to convert Appointment to a JSON-like object (if needed for API communication)
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'customerName': customerName,
      'company': company,
      'description': description,
      'appointmentDate': appointmentDate.toIso8601String(),
      'location': location,
    };
  }

  // Factory to create Appointment from a JSON-like object (for API response)
  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      title: json['title'],
      customerName: json['customerName'],
      company: json['company'],
      description: json['description'],
      appointmentDate: DateTime.parse(json['appointmentDate']),
      location: json['location'],
    );
  }
}
