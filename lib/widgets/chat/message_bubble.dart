
import 'package:flutter/material.dart';


class MessageBubble extends StatelessWidget {

  final String message;
  final bool isMe;
  final Key key;
  final String username;
  final String userImage;

  MessageBubble(this.message,  this.username, this.userImage, this.isMe, {this.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [ Row(
      mainAxisAlignment: isMe ?MainAxisAlignment.end :MainAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: isMe ? Theme.of(context).primaryColor : Theme.of(context).accentColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
              bottomLeft: !isMe ?Radius.circular(0) : Radius.circular(12),
              bottomRight: !isMe ? Radius.circular(12) : Radius.circular(0),
            ),

          ),
          width: 200,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical:10),
          margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: <Widget>[
              Text(username,
                        style: TextStyle(fontWeight: FontWeight.bold,
                        color: isMe ? Colors.black : Colors.white ),              
                      ),
              Text(message,
                style: TextStyle(color: isMe ? Colors.black : Colors.white),
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    ),
    Positioned(
      top: -5,
      left: isMe ? null :185,
      right: isMe ? 185: null,
      child: CircleAvatar(
        backgroundImage: NetworkImage(userImage),
      ),

      ),
    ],
    overflow: Overflow.visible,
    );
  }
}