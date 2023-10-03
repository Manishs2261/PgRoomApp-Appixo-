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

              Text("Price :-",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),

            Padding(padding: EdgeInsets.only(left: 20),
            child: Column(
              children: [
                DetailsRowWidgets(title: "Single Person :-  ", price: '2000/- '
                    'month',icon: Icons.done,),
                DetailsRowWidgets(title: "doble Person :-  ", price: '1600/- '
                    'month',icon: Icons.done,),
                DetailsRowWidgets(title: "triple Person :-  ", price: '1200/- '
                    'month',icon: Icons.done,),
                DetailsRowWidgets(title: "four + :-  ", price: '1000/- '
                    'month',icon: Icons.done,),
                DetailsRowWidgets(title: "Famaily  :-  ", price: '5000/- '
                    'month',icon: Icons.done,),
              ],
            ),),

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  DetailsRowWidgets(title: "Wi-Fi", icon: Icons.close),
                  DetailsRowWidgets(title: "Fan", icon: Icons.done),
                  DetailsRowWidgets(title: "Light", icon: Icons.done),

                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  DetailsRowWidgets(title: "table", icon: Icons.close),
                  DetailsRowWidgets(title: "chair", icon: Icons.done),
                  DetailsRowWidgets(title: "locker", icon: Icons.close),

                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  DetailsRowWidgets(title: "Bed", icon: Icons.close),
                  DetailsRowWidgets(title: "gadda", icon: Icons.done),
                  DetailsRowWidgets(title: "bed sheet", icon: Icons.done),



                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [


                  DetailsRowWidgets(title: "parking", icon: Icons.done),
                  DetailsRowWidgets(title: "barhroom \n attech", icon: Icons
                      .done),
                  DetailsRowWidgets(title: "barhroom \n shareable", icon: Icons
                      .done),

                ],
              ),



              SizedBox(height: 10,),
              Text("Bills & charges:-",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [

                  DetailsRowWidgets(title: "Electricity bill", icon: Icons.done),
                  DetailsRowWidgets(title: "water bill", icon: Icons.done),

                ],
              ),

              SizedBox(height: 10,),
              Text("Permission:-",
                style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Column(
                  children: [
                    DetailsRowWidgets(title: "Girl", icon: Icons.done),
                    DetailsRowWidgets(title: "Boy", icon: Icons.done),
                    DetailsRowWidgets(title: "family member", icon: Icons.done),
                    DetailsRowWidgets(title: "cooking", icon: Icons.done),
                  ],
                ),
              ),
              SizedBox(height: 50,),

              ElevatedButton(onPressed: (){}, child: Text("contect now")),
              SizedBox(height: 50,),

            ],
          ),
        ),
      ),
    );
  }
}

class DetailsRowWidgets extends StatelessWidget {
   DetailsRowWidgets({
    required this.title, this.price = "",required this.icon,
    super.key,
  });
  String title;
  String price ;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [

        Icon(icon,color: Colors.green,size: 20,),
        SizedBox(width: 5,),
        Text(title),
        Text(price)
      ],
    );
  }
}
