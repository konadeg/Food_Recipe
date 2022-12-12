


class RecepieModel{ 
 final String? appLable ;  
final String? appImgUrl ;
final double? appCalories;
 final String? appUrl;

  RecepieModel({this.appCalories,this.appImgUrl,this.appLable,this.appUrl});

  factory RecepieModel.fromMap(dynamic recipe){
    return RecepieModel(
      appLable: recipe["label"],
      appCalories: recipe["calories"],
      appImgUrl:recipe["image"],
      appUrl: recipe["url"]
    );
  }


}