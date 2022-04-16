class Contact {
  late int id;
  late String name;
  late String mobile;

  Contact({
    required this.name,
    required this.mobile,
  });

  Contact.fromMap(Map<String, dynamic> data){
    id = data['id'];
    name = data['name'];
    mobile = data['mobile'];
  }

  Map<String, dynamic> toMap(/*{bool withId = false}*/){
    Map<String, Object> data = Map<String, Object>();
    // if(withId) data['id'] = id;
    data['name'] = name;
    data['mobile'] = mobile;
    return data;
  }
}
