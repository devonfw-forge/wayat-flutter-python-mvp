import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, msg1, msg2) { 
    Widget okButton = TextButton(  
    child: const Text("OK"),  
    onPressed: () {  
        Navigator.pop(context);  
    },  
    );  
    
    // Create AlertDialog  
    AlertDialog alert = AlertDialog(  
      title: Text(msg1),  
      content: Text(msg2),  
      actions: [  
          okButton,  
      ],  
    );  
    
    // show the dialog  
    showDialog(  
    context: context,  
    builder: (BuildContext context) {  
        return alert;  
    },  
    );  
}