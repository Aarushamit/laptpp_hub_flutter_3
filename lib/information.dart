class Information{
  String title;
  String description;

  Information(this.title, this.description);

  Information.fromJson(Map<String, dynamic>json){
    title = json['title'];
    description = json['description'];

  }
}