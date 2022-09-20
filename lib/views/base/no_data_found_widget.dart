import 'package:flutter/material.dart';

class NoDataFoundWidget extends StatelessWidget {
  const NoDataFoundWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView(),
        Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.hourglass_empty, size: 80, color: Colors.black54,),
              SizedBox(height: 16,),
              Text('No Data Found!!', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25, color: Colors.black54),)
            ],
          ),
        ),
      ],
    );
  }
}
