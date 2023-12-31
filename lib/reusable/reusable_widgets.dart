import 'package:campbelldecor/reusable/reusable_methods.dart';
import 'package:campbelldecor/screens/chat/user_chat_screen.dart';
import 'package:campbelldecor/screens/payment_screens/paymentscreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../screens/bookings_screens/cart_screen.dart';
import '../screens/dash_board/homescreen.dart';
import '../screens/searchbar/searchbar_widget.dart';
import '../utils/color_util.dart';

Container logoWidget(String imageName) {
  return Container(
    width: 350, // Set the desired width
    height: 350,
    child: Image.asset(imageName),
  );
}

Container imgContainer(String imageName, double width, double height) {
  return Container(
    width: width, // Set the desired width
    height: height,
    child: Image.asset(imageName),
  );
}

Container Profile(String userURL) {
  return Container(
    width: 120,
    height: 120,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        color: Colors.blueGrey,
        width: 2.0,
      ),
    ),
    child: ClipOval(
      child: userURL != null
          ? Image.network(
              userURL,
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            )
          : Image.network(
              'https://firebasestorage.googleapis.com/v0/b/campbelldecor-c2d1f.appspot.com'
              '/o/Users%2Fuser.png?alt=media&token=af8768f7-68e4-4961-892f-400eee8bae5d',
              width: 150,
              height: 150,
              fit: BoxFit.cover,
            ),
    ),
  );
}

/**----------------------- Image for Container List view ----------------------------------**/
ClipRRect IconImageWidget(String imageName, double height, double width) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Image.asset(
      imageName,
      fit: BoxFit.fitWidth,
      width: height,
      height: width,

      // color: Colors.transparent,
    ),
  );
}

TextField textField(String text, IconData icon, bool isPasswordType,
    TextEditingController controller) {
  return TextField(
    controller: controller,
    obscureText: isPasswordType,
    enableSuggestions: !isPasswordType,
    autocorrect: !isPasswordType,
    cursorColor: Colors.white,
    style: TextStyle(color: Colors.white.withOpacity(0.9)),
    decoration: InputDecoration(
      prefixIcon: Icon(
        icon,
        color: Colors.white70,
      ),
      labelText: text,
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
      filled: true,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      fillColor: Colors.white.withOpacity(0.3),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
          borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
    ),
    keyboardType: isPasswordType
        ? TextInputType.visiblePassword
        : TextInputType.emailAddress,
  );
}

Container reusableButton(BuildContext context, bool isLogin, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular((30))),
          )),
      child: Text(
        isLogin ? 'LOGIN ' : 'SIGN UP',
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}

Container reuseButton(BuildContext context, String text, Function onTap) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: () {
        onTap();
      },
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.black26;
            }
            return Colors.white;
          }),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular((30))),
          )),
      child: Text(
        text,
        style: const TextStyle(
            color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
      ),
    ),
  );
}

/**----------------------- Data show as Container List ---------------------------------**/
Widget reuseContainerList(String imgName, double height, double width,
    String name, DateTime date, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: SingleChildScrollView(
      child: Container(
        height: 120,
        width: 500,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Colors.blue, Colors.pink],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: IconImageWidget(imgName, height, width),
            ),
            Column(
              children: [
                Padding(
                    padding: const EdgeInsets.fromLTRB(15, 30, 15, 15),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        name,
                        style:
                            const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    )),
                Padding(
                    padding: const EdgeInsets.all(5),
                    child: Text(
                      DateFormat.yMd().format(date),
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    )),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

/**----------------------- Data show as Container List ---------------------------------**/
Widget reusePaymentContainer(String id, String name, double price,
    BuildContext context, Function onTap) {
  double bondmoney = (price / 100) * 10;
  double total = price + bondmoney;

  return Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Padding(
        padding: const EdgeInsets.fromLTRB(20, 300, 20, 0),
        child: Material(
          borderRadius: BorderRadius.circular(20),
          elevation: 8,
          color: CupertinoColors.white.withOpacity(0.6),
          child: Container(
            height: 120,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 25, 20, 0),
                        child: Text(
                          "Price Amount : \$${price.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black87),
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Text(
                          "Bond Money : \$${bondmoney.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black87),
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Text(
                          "Total Amount : \$${total.toStringAsFixed(2)}",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87),
                        )),
                  ],
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Navigation(
                              context,
                              PaymentScreen(
                                price: total,
                                id: id,
                                name: name,
                              ));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[400],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15))),
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                          child: Text(
                            "Pay",
                            style: TextStyle(color: Colors.white),
                          ),
                        )),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ],
  );
}

Widget keyLable(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: const TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.normal),
    ),
  );
}

Widget valueLable(String text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(
      text,
      style: const TextStyle(
          fontSize: 16,
          color: Colors.white70,
          fontFamily: 'OpenSans',
          fontWeight: FontWeight.normal),
    ),
  );
}

Widget generateQRCode(String data) {
  return QrImageView(
    data: data,
    version: QrVersions.auto,
    size: 100.0,
  );
}

Widget bottom_Bar(BuildContext context, int selectIndex) {
  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [
        hexStringtoColor("CB2893"),
        hexStringtoColor("9546C4"),
        hexStringtoColor("5E61F4")
      ], begin: Alignment.bottomRight, end: Alignment.topLeft),
    ),
    child: CupertinoTabBar(
        backgroundColor: Colors.transparent,
        activeColor: Colors.black45,
        inactiveColor: Colors.white70,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(CupertinoIcons.home),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(CupertinoIcons.chat_bubble_text_fill),
            ),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(CupertinoIcons.cart_badge_plus),
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.all(4.0),
              child: Icon(CupertinoIcons.search),
            ),
            label: 'Search',
          ),
        ],
        currentIndex: selectIndex,
        onTap: (index) {
          if (index == 0) {
            BottomNavigationForHome(context, HomeScreen());
          } else if (index == 1) {
            BottomNavigation(context, UserChatScreen());
          } else if (index == 2) {
            BottomNavigation(context, AddToCartScreen());
          } else if (index == 3) {
            BottomNavigation(context, SearchScreen());
          }
        }),
  );
}
