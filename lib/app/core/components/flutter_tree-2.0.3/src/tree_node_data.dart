class TreeNodeData {
  String title;
  bool expaned;
  bool checked;
  dynamic extra;
  List<TreeNodeData> children;

  TreeNodeData({
    required this.title,
    required this.expaned,
    required this.checked,
    required this.children,
    this.extra,
  });
}
