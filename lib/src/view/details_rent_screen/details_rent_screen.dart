import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pgroom/src/uitels/image_string/image_string.dart';

class DetailsRentInfoScreen extends StatefulWidget {
  const DetailsRentInfoScreen({super.key});

  @override
  State<DetailsRentInfoScreen> createState() => _DetailsRentInfoScreenState();
}

class _DetailsRentInfoScreenState extends State<DetailsRentInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details info"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "House Name ",
                style: TextStyle(fontSize: 22),
              ),
              Image(image: AssetImage(roomImage)),
              SizedBox(height: 20,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Address :- ",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  Expanded(
                    child: Text(
                        " gour colony yadunandan nager tifra bilaspur , chhatttisgarh, near papu popular palar salun",
                      softWrap: true,),
                  ),

                ],
              ),
            SizedBox(height: 10,),

            Row(
              children: [
                Text("Price :-",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                Text("  2000/- monthly")
              ],
            ),
              SizedBox(height: 10,),

               Row(
                 children: [
                   Text("Rental Room Type :-",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 18),),
                   Text("  Boys hostal")
                 ],
               ),
              SizedBox(height: 10,),
              Text("Services :-",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.only(left: 13),
                child: GridView.builder(

                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 150,
                      childAspectRatio: 6,

                      mainAxisSpacing: 12,

                    ),
                    itemCount: 10,
                    itemBuilder: (context,index){
                      return  Row(
                        children: [
                          Icon(Icons.download_done,size: 18,color: Colors.green,),
                          SizedBox(width: 2,),
                          Text("Table fan")
                        ],
                      );
                    }),
              ),

              SizedBox(height: 10,),
              Text("Bills & charges:-",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),



            ],
          ),
        ),
      ),
    );
  }
}
