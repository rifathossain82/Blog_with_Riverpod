import 'package:flutter/material.dart';

class NoInternetConnectionWidget extends StatelessWidget {
  const NoInternetConnectionWidget({Key? key}) : super(key: key);

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
              Icon(Icons.cloud_off, size: 80, color: Colors.black54,),
              SizedBox(height: 16,),
              Text('No Internet Connection!!', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25, color: Colors.black54),)
            ],
          ),
        ),
      ],
    );
  }
}
