class UserData
{
  int? id;
  String? username;
   String? email;
   String? firstName;
  String? lastName;
   String? gender;
  String? image;
  String? token;
 static  UserData data =UserData();
 void fetchData(userData)
{
   id=userData["id"];
   username=userData["username"];
   email=userData["email"];
   firstName=userData["firstName"];
   lastName=userData["lastName"];
   gender=userData["gender"];
   image=userData["image"];
   token=userData["token"];
}
  UserData({
    this.id,
    this.email,
    this.firstName,
    this.gender,
    this.image,
    this.lastName,
    this.token,
    this.username,
  });
}