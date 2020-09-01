import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 30),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentDirectional.topCenter,
              colors: [
                Colors.indigo[900],
                Colors.indigo[600],
                Colors.indigo[400]
              ]
            )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80,),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Login",style: TextStyle(color: Colors.white,fontSize: 40),),
                    SizedBox(height: 20,),
                    Text("Student Attendence System",style: TextStyle(color: Colors.white,fontSize: 20),)
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(40))
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child:Column(
                        children: [
                          SizedBox(height: 60,),
                          Container(
                            decoration: BoxDecoration(
                              color:Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(color: Color.fromRGBO(27, 95, 225, 0.5),
                                blurRadius: 20,
                                offset: Offset(0,10))
                              ]
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                  ),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      hintText: "Email",
                                      border: InputBorder.none,
                                      hintStyle: TextStyle(color: Colors.grey)
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border(bottom: BorderSide(color: Colors.grey[200]))
                                  ),
                                  child: TextFormField(
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        hintText: "Password",
                                        border: InputBorder.none,
                                        hintStyle: TextStyle(color: Colors.grey)
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(height: 40,),
                          FlatButton(
                              onPressed: (){},
                              child: Text("Forgot Password?",style: TextStyle(color: Colors.grey),)),
                          SizedBox(height: 10,),
                          FlatButton(
                            onPressed: (){},
                            child: Container(
                              height: 50,
                              margin: EdgeInsets.symmetric(horizontal: 50),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color:Colors.indigo[900]
                              ),
                              child: Center(
                                child: Text("Login",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
