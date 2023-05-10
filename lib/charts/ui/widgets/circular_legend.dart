import 'package:flutter/material.dart';
import '/commons/index.dart';

class CircularLegend extends StatelessWidget {

  final List<Map<String, dynamic>> xys;

  const CircularLegend({
    super.key,
    required this.xys
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: xys.length,
      separatorBuilder: (_, __) => const Divider(),
      itemBuilder: (context, index) {
        Map<String, dynamic> xy = xys[index];
        return ListTile(
          dense: true,
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Text(xy['x'], style: theme.textTheme.titleSmall),
          subtitle: Text(removeDecimalZero(xy['y']), style: theme.textTheme.bodySmall),
          trailing: Text("${removeDecimalZero(xy['percent'])}%", style: theme.textTheme.titleMedium),
        );
      }
    );
  }

}
