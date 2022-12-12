import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food/model.dart';
import 'package:food/recipeview.dart';
import 'package:food/search.dart';
import 'package:http/http.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
    bool isLoading = true;
  List<RecepieModel> recepieslist = <RecepieModel>[];

  TextEditingController searchController = TextEditingController();
  
    List reciptCatList = [
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Chilli Food"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Icecream"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Summary Food"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1593560704563-f176a2eb61db",
      "heading": "Weather Food"
    }
  ];
  
  void getRecipe(String query)async{
  
    
  // ignore: non_constant_identifier_names
  String Url = "https://api.edamam.com/search?q=$query&app_id=ebb6041c&app_key=3c33ad913ab23b8554082bfb5fdd78b5";
    Response response = await  get(Uri.parse(Url));
   Map data = jsonDecode(response.body);
     // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
         data["hits"].forEach((Element){
          RecepieModel recepieModel = RecepieModel();
          recepieModel = RecepieModel.fromMap(Element["recipe"]);
          recepieslist.add(recepieModel);
          setState(() {
          isLoading = false;
        });
          log(recepieslist.toString());
      
         });
// ignore: non_constant_identifier_names
for (var Recipe in recepieslist) {
  // ignore: avoid_print
  print(Recipe.appImgUrl);
}
    
 
  }
  @override
  void initState() {
   super.initState();
   getRecipe("Apple");
  
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Color.fromARGB(255, 28, 2, 2),
              Color.fromARGB(255, 15, 25, 1)
            ])),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
          
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: GestureDetector(
                         onTap: () {
                            if((searchController.text).replaceAll(" ", "") == "")
                            {
                              // ignore: avoid_print
                              print("Blank search");
                            }else{
                             Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Search(searchController.text)));
                            }
            
                          },
                          child: const Icon(Icons.search),
                        ),
                      ),
                      Expanded(
                        
                          child: TextField(
                            controller: searchController,
                        decoration:const InputDecoration(
                          hintText: "Search Food Recepies",
                        ),
                      )),
                    ]),
                  ),
                const  SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:const [
                      Text(
                        "What Do You Want To Cook Today?",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Lets cock something new!",
                        style: TextStyle(color: Colors.white,
                         fontSize: 20
                         ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                     Container(
                       child: isLoading? const CircularProgressIndicator(): ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: recepieslist.length,
                    itemBuilder:  (context, index) {
                    return InkWell(
                        onTap: (){
                          Navigator.push(context , MaterialPageRoute(builder:(context)=> RecipeView(recepieslist[index].appUrl.toString())));
                        },
                         child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                          ),
                          elevation: 0.0,
                          margin: const EdgeInsets.all(20),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)
                                ),
                                
                                child: Image.network(recepieslist[index].appImgUrl.toString(),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: 200,
                                ),
                                
                              ),
                              Positioned(
                                left: 0,
                                bottom: 0,
                                right: 0,
                                child:Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 5,vertical: 10
                                  ),
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(20)
                                    ),
                                    color: Colors.black54
                                  ),
                                  child: Text(recepieslist[index].appLable.toString(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                      fontWeight: FontWeight.bold
                                  ),
                                  ))
                                 ),
                                 Positioned(
                                  right: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                      color: Colors.black54,
                                      borderRadius: BorderRadius.only(
                                        bottomRight: Radius.circular(10),
                                        bottomLeft: Radius.circular(10)
                                      )
                                    ),
                                    child: Row(
                                      children: [
                                           const Icon(Icons.local_fire_department,color: Colors.white,),
                                        Text(recepieslist[index].appCalories.toString().substring(0,6),
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                        ),
                                        ),
                                      ],
                                    )))
                            ],
                          ),
                         ),
                    );
                  } ),
                     ),
                    SizedBox(
                  height: 100,
                  child: ListView.builder( itemCount: reciptCatList.length, shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){

                        return InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Search(isLoading? CircularProgressIndicator() :reciptCatList[index]["heading"])));
                          },
                          child: Card(
                              margin: const EdgeInsets.all(20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              elevation: 0.0,
                              child:Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(18.0),
                                      child: Image.network(reciptCatList[index]["imgUrl"], fit: BoxFit.cover,
                                        width: 200,
                                        height: 250,)
                                  ),
                                  Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      top: 0,
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: const BoxDecoration(
                                              color: Colors.black26),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                reciptCatList[index]["heading"],
                                                style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 28),
                                              ),
                                            ],
                                          ))),
                                ],
                              )
                          ),
                        );
                      }),
                )

                ],
              ),
            ),
          ),
        ),
      ),
    );

  }
}

