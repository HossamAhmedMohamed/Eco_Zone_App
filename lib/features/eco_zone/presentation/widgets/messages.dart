import 'package:flutter/material.dart';
import 'package:untitled/core/utils/app_images.dart';

class Messages extends StatelessWidget {
  final bool isUser;
  final String message;
  final String date;
  const Messages({
    super.key,
    required this.isUser,
    required this.message,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
         
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [

          isUser ? Container() : ClipOval(
            child: Image.asset(
               Assets.imagesBot,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
           
          ),
          SizedBox(width: 5),
          Container(
            // width: double.infinity,
            // padding: const EdgeInsets.all(15),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            decoration: BoxDecoration(
              color: isUser ? Color(0xFF0D98BA) : Colors.grey.shade200,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: Radius.circular(isUser ? 18 : 0),
                bottomRight: Radius.circular(isUser ? 0 : 18),
              ),
          
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
                bottom: 3,
              ),
              child: Column(
                crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    textDirection: TextDirection.rtl,
                    message,
                    style: TextStyle(color: isUser ? Colors.white : Colors.black),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    textDirection: TextDirection.ltr,
                    date,
                    style: TextStyle(color: isUser ? Colors.white : Colors.black),
                  ),
                ],
              ),
            ),
          ),
         
        ],
      ),
    );
  }
}