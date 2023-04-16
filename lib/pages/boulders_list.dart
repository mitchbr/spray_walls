import 'package:flutter/material.dart';

import 'package:spray_walls/models/boulder.dart';
import 'package:spray_walls/pages/boulders_details.dart';

class BouldersList extends StatefulWidget {
  final List listData;
  const BouldersList({super.key, required this.listData});

  @override
  State<BouldersList> createState() => _BouldersListState();
}

class _BouldersListState extends State<BouldersList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: false,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.listData.length,
      itemBuilder: (context, index) {
        return boulderTile(index);
      },
    );
  }

  Widget boulderTile(int index) {
    var item = widget.listData[index];
    return ListTile(
      title: Text(item.name),
      subtitle: Row(
        children: [
          Text(item.user),
          const SizedBox(width: 5),
          starRating(item),
          const SizedBox(width: 5),
          Text("V${item.grade}"),
        ],
      ),
      onTap: () => pushBoulderDetails(context, index),
    );
  }

  Widget starRating(Boulder item) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return Icon(
          index < item.stars ? Icons.star : Icons.star_border,
          size: 15,
        );
      }),
    );
  }

  void pushBoulderDetails(BuildContext context, index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BouldersDetails(listData: widget.listData, index: index),
      ),
    ).then((data) => setState(() => {}));
  }
}
