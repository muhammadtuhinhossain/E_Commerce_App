import 'package:flutter/material.dart';
class ReviewWidget extends StatelessWidget {
  const ReviewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4),
      child: Column(
        children: [
          Column(
            children: [
              Row(
                spacing: 10,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                    ),
                    child: Icon(Icons.person_outline_outlined,color: Colors.grey.shade500,size: 18,),
                  ),
                  Text('Tuhin Hasan',style: TextStyle(fontSize: 18, fontWeight: .w500),),
                ],
              ),
              const SizedBox(height: 12,),
              Text('''There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form,'''),
            ],
          ),
          const SizedBox(height: 12,),
          Divider(),
        ],
      ),
    );
  }
}