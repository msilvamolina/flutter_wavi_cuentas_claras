import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ResponsiveContainer extends StatelessWidget {
  final Widget child;

  const ResponsiveContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile =
        !GetPlatform.isMobile ? MediaQuery.of(context).size.width < 700 : true;
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          radius: 0.9,
          colors: [
            Colors.purple[400]!,
            Colors.purple[900]!,
          ],
        ),
      ),
      child: !isMobile
          ? Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: 600),
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Card(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      child: child,
                    ),
                  ),
                ),
              ),
            )
          : child,
    );
  }
}
