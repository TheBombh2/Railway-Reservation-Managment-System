import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';

class FromToInformationBox extends StatelessWidget {
  const FromToInformationBox({
    required this.fromCity,
    required this.toCity,
    super.key,
  });
  final String fromCity;
  final String toCity;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xffF2F2F2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 3,
      child: Padding(
        padding: EdgeInsets.all(11),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'From',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                ),
                
                Expanded(
                  flex: 2,
                  child: Text(
                    fromCity,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(0, 0, 0, 0.6),
                    ),
                  ),
                )
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Dash(
                    direction: Axis.vertical,
                    length: 45,
                    dashColor:Color(0xff0076CB),
                    dashThickness: 6,
                  ),
                ),
                
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Divider(thickness: 1,color: Colors.grey,),
                  ),
                )
              ],
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 1,
                  child: Text(
                    'To',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                
                Expanded(
                  flex: 2,
                  child: Align(
                    alignment:Alignment.centerLeft,
                    child: Text(
                      toCity,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(0, 0, 0, 0.6),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}