class Manager {
  const Manager(this.id);
  final String id;
  final String firstName = "ELGamed";
  @override
  List<Object> get props => [id];

  static const empty = Manager('-');
}
