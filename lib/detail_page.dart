import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'data.dart';
import 'ad_helper.dart';


class DetailPage extends StatelessWidget {
  final PirithInfo pirithInfo;
  const DetailPage({Key key, this.pirithInfo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            /*Padding(
              padding: EdgeInsets.fromLTRB(32, 32, 32, 5),
              child: Text(
                pirithInfo.name ?? '',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 36,
                ),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 32.0, right: 32.0),
                child: Divider(
                  color: Colors.black54,
                )),*/
            Expanded(
              //padding: EdgeInsets.all(32.0),
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                child: SizedBox(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            image: AssetImage(pirithInfo.mainImage ?? ''),
                          ),
                        ),
                        SizedBox(height: 50,),
                        Text(
                          pirithInfo.description ?? '',
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                        SizedBox(height: 50,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            image: AssetImage(pirithInfo.image2 ?? ''),
                          ),
                        ),
                        SizedBox(height: 50,),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image(
                            image: AssetImage(pirithInfo.image3 ?? ''),
                          ),
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


