import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class BaseNavigator {
  
}



 
  class BaseViewModel<NAV extends BaseNavigator> extends ChangeNotifier {
  NAV? navigator = null;
}


  abstract class BaseView<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> implements BaseNavigator {
  late VM viewModel;

   VM initViewModel();

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel = initViewModel();
  }
      @override
  void hideDialog() {
    Navigator.pop(context);
  }

  @override
  void showLoading({String message = "Loading"}) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Row(
              children: [
                Text(message),
                CircularProgressIndicator(),
              ],
            ),
          ),
        );
      },
    );
  }

    }