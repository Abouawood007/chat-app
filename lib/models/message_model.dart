class Message{
  final String message;
  final String id;
  Message(this.message,this.id);
  factory Message.fromJson(jsonData){
    return  Message(jsonData['messages'],jsonData['id']);
    //هنا الداتا رجعالي على هيئة map
    //ف json Data عبارة عن map عشان وبعمل access عشان اجيب ال value بتاعت ال key messages ال هي الرسايل بتاعتي
    //ملاحظة ف الابلكيشن ده انا كان راجعلي (قايمة الرسايل)  list من ال maps ف هعمل for loop عشان اعرض ال maps اللي جوه ال list وعن طريق الmodel ده انا هعمل access ع ال map واجيب قيمة ال key اللي هي الرسايل بتاعتي
  }
}