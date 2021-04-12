import 'package:blockchain_auth/utils/colors.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              height: 110,
              color: persian_blue,
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width,
              child: Text(
                "   Hello \n User",
                textAlign: TextAlign.start,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: white, fontSize: 36, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              color: flamingo,
//                  child: SvgPicture.asset(
//                    "assets/images/shopping/peep_both.svg",
//                    height: MediaQuery.of(context).size.height,
//                    width: MediaQuery.of(context).size.width,
//                  ),
            ),
          ],
        )),
      ),
    );
  }
}
