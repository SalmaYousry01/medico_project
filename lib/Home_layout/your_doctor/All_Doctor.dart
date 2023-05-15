import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:grad_project/Home_layout/your_doctor/search.dart';
import 'package:grad_project/Home_layout/your_doctor/single_doctor_widget.dart';
import 'package:provider/provider.dart';
import '../../basenavigator.dart';
import 'Alldoctor_viewmodel.dart';
import 'all_nav.dart';
import 'doctor_controller.dart';

class AllDoctor extends StatefulWidget {
  final controller = Get.put(DoctorController());
  static const String routeName = 'AllDoctor';

  @override
  State<AllDoctor> createState() => _AllDoctorState();
}

class _AllDoctorState extends BaseView<AllDoctor, AllDoctorViewModel>
    implements ALLNavigator {
  AllDoctorViewModel viewModel = AllDoctorViewModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.navigator = this;
    viewModel.readDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(
              toolbarHeight: 100,
              backgroundColor: Color(0xFF2C698D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              title: Text('Doctors'),
              centerTitle: true,
              actions: <Widget>[
                IconButton(
                    onPressed: () {
                      showSearch<Object?>(context: context, delegate: Search());
                    },
                    icon: Icon(Icons.search))
              ],
            ),
            body: Consumer<AllDoctorViewModel>(
              builder: (_, AllDoctorViewModel, c) {
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return SingleDoctortWidget(
                        AllDoctorViewModel.doctor[index]);
                  },
                  itemCount: AllDoctorViewModel.doctor.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  AllDoctorViewModel initViewModel() {
    // TODO: implement initViewModel
    return AllDoctorViewModel();
  }
}
