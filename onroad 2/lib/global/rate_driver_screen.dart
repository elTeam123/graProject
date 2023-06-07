import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:onroad/global/global.dart';
import 'package:smooth_star_rating_nsafe/smooth_star_rating.dart';
class RateProviderScreen extends StatefulWidget
{
String? assignedProviderId;
RateProviderScreen({this.assignedProviderId});
  @override
  State<RateProviderScreen> createState() => _RateProviderScreen();
}




class _RateProviderScreen extends State<RateProviderScreen>
{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Dialog(
        shape:  RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          margin:  const EdgeInsets.all(8),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children:  [
              const Text(
                  'Rate Service',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight:  FontWeight.bold,
                  color:  Colors.black54,
                ),
              ),
               const SizedBox(height: 22.0,),
              const Divider(height: 4.0, thickness: 4.0,),
              const SizedBox(height: 22.0,),
              SmoothStarRating(
                rating: countStar,
                allowHalfRating: true,
                starCount: 5,
                size: 46,
                onRatingChanged: (valueOfStars)
                {
                  countStar = valueOfStars;
                  if(countStar == 1 )
                  {
                    setState(() {
                      titleRating = "Very Bad" ;
                    });
                  }
                  if(countStar == 2 )
                  {
                    setState(() {
                      titleRating = "Bad" ;
                    });
                  }if(countStar == 3 )
                  {
                    setState(() {
                      titleRating = "good" ;
                    });
                  }if(countStar == 4 )
                  {
                    setState(() {
                      titleRating = "Very good" ;
                    });
                  }if(countStar == 5 )
                  {
                    setState(() {
                      titleRating = "Excellent" ;
                    });
                  }
                },
              ),
              const SizedBox(height: 12.0,),
              Text(
                titleRating,
                style:const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
              const SizedBox(height: 18.0,),
              ElevatedButton(
                  onPressed: ()
                  {
                    DatabaseReference rateProviderRef = FirebaseDatabase.instance.ref()
                        .child("provider")
                        .child(widget.assignedProviderId!)
                        .child("ratings");
                    rateProviderRef.once().then((snap) 
                    {
                      //
                      if(snap.snapshot.value == null)
                      {
                        rateProviderRef.set(countStar.toString());
                        SystemNavigator.pop();
                      }
                      else
                      {
                        double lastRatings = double.parse(snap.snapshot.value.toString());
                      double avgRatings =  (lastRatings + countStar) / 2 ;
                      rateProviderRef.set(avgRatings.toString());
                      SystemNavigator.pop();
                      }
                      Fluttertoast.showToast(msg: "App will restart now");
                    });
                    
                  }, 
                   style:ElevatedButton.styleFrom(
                     backgroundColor: Colors.green
                     ) ,
                  child:  const Text(
                    "Submit",
                    style:TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
              )
              
            ],
          ),
          
        )
      ), 
    );}
}
