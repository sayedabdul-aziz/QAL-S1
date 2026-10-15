class TaskModel {
  String? id;
  String? title;
  String? description;
  String? date;
  String? startTime;
  String? endTime;
  int? priority;
  bool? isCompleted;

  TaskModel({
    this.id,
    this.title,
    this.description,
    this.date,
    this.startTime,
    this.endTime,
    this.priority,
    this.isCompleted,
  });

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? date,
    String? startTime,
    String? endTime,
    int? priority,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      priority: priority ?? this.priority,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
