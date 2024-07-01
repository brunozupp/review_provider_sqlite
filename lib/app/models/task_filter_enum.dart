enum TaskFilterEnum {
  today(label: "TODAY"),
  tomorrow(label: "TOMORROW"),
  week(label: "WEEK");

  final String label;

  const TaskFilterEnum({
    required this.label,
  });
}