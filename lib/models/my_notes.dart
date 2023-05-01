class Mynotes{
  static const String NOTES = "Notes";
 String? id;
  String title;
  String descriptions;
  
  Mynotes({this.id,
  required this.descriptions,
  required this.title});

  Mynotes.fromjson(Map<String ,dynamic> json):
  this(
    id: json ["id"],
     title: json ["title"],
     descriptions: json ["descriptions"],
 
     

  );
    Mynotes.notFound(): this(descriptions: "",title: "",id: "");


  Map<String ,dynamic> tojson(){
    return{
      "id":id,
      "title":title,
      "descriptions":descriptions,
     
    };
  }
  
}