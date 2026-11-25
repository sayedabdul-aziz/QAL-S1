class AppointmentModel {
  final String? id;
  final String? patientID;
  final String? doctorID;
  final String? name;
  final String? phone;
  final String? description;
  final String? doctorName;
  final String? location;
  final DateTime? date;
  final bool? isComplete;
  final double? rating;

  AppointmentModel({
    this.id,
    this.patientID,
    this.doctorID,
    this.name,
    this.phone,
    this.description,
    this.doctorName,
    this.location,
    this.date,
    this.isComplete,
    this.rating,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      patientID: json['patientID'],
      doctorID: json['doctorID'],
      name: json['name'],
      phone: json['phone'],
      description: json['description'],
      doctorName: json['doctorName'],
      location: json['location'],
      date: DateTime.parse(json['date']),
      isComplete: json['isComplete'],
      rating: json['rating'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientID': patientID,
      'doctorID': doctorID,
      'name': name,
      'phone': phone,
      'description': description,
      'doctorName': doctorName,
      'location': location,
      'date': date?.toIso8601String(),
      'isComplete': isComplete,
      'rating': rating,
    };
  }

  Map<String, dynamic> toUpdateData() {
    return {
      if (patientID != null) 'patientID': patientID,
      if (doctorID != null) 'doctorID': doctorID,
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
      if (description != null) 'description': description,
      if (doctorName != null) 'doctorName': doctorName,
      if (location != null) 'location': location,
      if (date != null) 'date': date?.toIso8601String(),
      if (isComplete != null) 'isComplete': isComplete,
      if (rating != null) 'rating': rating,
    };
  }
}
