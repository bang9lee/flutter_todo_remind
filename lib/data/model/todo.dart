class Todo {
  // 속성 (담길 데이터)
  final String id;
  final String content;
  final bool isDone;

  Todo({
  required this.id,
  required this.content,
  required this.isDone,
  });
  
  //Map으로 바꿔주는 toJson
  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'content' :content,
      'isDone': isDone,
    };
  }

  //Map을 Todo 객체로 바꿔 주는 fromJson
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      content: json['content'],
      isDone: json['isDone'],
    );
  }
}



