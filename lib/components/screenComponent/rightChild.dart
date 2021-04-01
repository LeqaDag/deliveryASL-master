// ignore: must_be_immutable
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as intl;

// ignore: must_be_immutable
class RightChild extends StatefulWidget {
  RightChild({
    this.title,
    this.message,
    this.dateTime,
    this.currentState,
    this.orderState,
    this.active = false,
    this.disabled = false,
  });

  String title;
  String message;
  bool disabled;
  DateTime dateTime;
  String currentState;
  String orderState;
  bool active;
  @override
  _RightChildState createState() => _RightChildState();
}

class _RightChildState extends State<RightChild> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.orderState);
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 6),
              Text(
                widget.title,
                style: GoogleFonts.yantramanav(
                  color: widget.disabled
                      ? Color(0xFFBABABA)
                      : widget.active
                          ? Color(0xff316686)
                          : Color(0xFF636564),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 6),
              widget.message != null
                  ? Text(
                      widget.message,
                      style: GoogleFonts.yantramanav(
                        color: widget.disabled
                            ? Color(0xFFD5D5D5)
                            : Color(0xFF636564),
                        fontSize: 16,
                      ),
                    )
                  : Container(),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(height: 6),
              Text(
                intl.DateFormat('yyyy-MM-dd').format(widget.dateTime),
                style: GoogleFonts.yantramanav(
                  color: widget.disabled
                      ? Color(0xFFBABABA)
                      : widget.active
                          ? Color(0xff316686)
                          : Color(0xFF636564),
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 6),
              Text(
                intl.DateFormat.jm().format(widget.dateTime),
                style: GoogleFonts.yantramanav(
                  color: widget.disabled
                      ? Color(0xFFBABABA)
                      : widget.active
                          ? Color(0xff316686)
                          : Color(0xFF636564),
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
