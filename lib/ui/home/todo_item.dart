import 'package:flutter/material.dart';
import 'package:flutter_todo_remind/ui/home/todo_text_button.dart';

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.isChecked,
    required this.text,
    required this.onDelete,
    required this.onEdit,
  });

  /// 1. 체크여부 -> bool
  final bool isChecked;

  /// 2. 글자 -> String
  final String text;

  /// 3. 삭제 터치했을 때 실행될 함수 -> void Function()
  final void Function() onDelete;

  /// 4. 수정 터치했을 때 실행될 함수 -> void Function()
  final void Function() onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFF7990F8).withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          // 1. CheckBox 사용
          // 2. Container + Icon 이용해서 구현
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: Color(0xFFD6D6D6),
                width: 2,
              ),
            ),
            // 3항 연산자
            // boolean ? 참 : 거짓
            child: isChecked
                ? Icon(
                    Icons.check,
                    size: 20,
                    color: Colors.blue,
                  )
                : null,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                color: Color(0xFF121212),
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(width: 12),
          TodoTextButton(
            text: '삭제',
            onTap: onDelete,
          ),
          SizedBox(width: 12),
          TodoTextButton(
            text: '수정',
            onTap: onEdit,
          ),
        ],
      ),
    );
  }
}
