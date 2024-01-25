import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          
            children: [
              SizedBox(height: 0.05.sh,),
              Row(
                children: [
                  SizedBox(
                    width: 0.75.sw,
                    child: ListTile(
                      title: const Text('Adelanaire Ewaoluwa'),
                      subtitle: SizedBox(
                        height: 40.h,
                        child: Row(
                          children: [
                            Container(
                              height: 5.dg,
                              width: 5.dg,
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.r),color: Colors.green,),
                              
                            ),
                            SizedBox(width: 0.01.sw,),
                            const Text('Cupertino - Male, 25')
                          ],
                        ),
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 30.r,
                  )
                ],
              ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [const Text('Upcoming Schedule'), TextButton(onPressed: (){}, child: const Text('View all'))],),
              Center(
                  child: Container(
                height: 0.23.sh,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: Colors.red),
              )), 
             Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [const Text("Let’s find the doctor"), IconButton(onPressed: (){}, icon: Transform.rotate(angle: 20.4, child: const Icon(Icons.tune)))],),
              
             

              
              // const Row(),
              // ListView()
            ]),
      ),
    );
  }
}

