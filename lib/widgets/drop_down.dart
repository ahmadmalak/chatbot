// import 'package:ask_pdf/services/constants.dart';
// import 'package:ask_pdf/view/notifiers/query_notifier.dart';
// import 'package:ask_pdf/widgets/text_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
//
// class ModelsDrowDownWidget extends ConsumerStatefulWidget {
//   const ModelsDrowDownWidget({super.key});
//
//   @override
//   ConsumerState<ModelsDrowDownWidget> createState() =>
//       _ModelsDrowDownWidgetState();
// }
//
// class _ModelsDrowDownWidgetState extends ConsumerState<ModelsDrowDownWidget> {
//   String? currentModel;
//
//   bool isFirstLoading = true;
//   @override
//   Widget build(BuildContext context) {
//     final queryState = ref.watch(queryNotifierProvider);
//     currentModel = modelsProvider.getCurrentModel;
//     return FutureBuilder<List<QueryState>>(
//         future: modelsProvider.getModels(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting &&
//               isFirstLoading == true) {
//             isFirstLoading = false;
//             return const FittedBox(
//               child: SpinKitFadingCircle(
//                 color: Colors.lightBlue,
//                 size: 30,
//               ),
//             );
//           }
//           if (snapshot.hasError) {
//             return Center(
//               child: TextWidget(label: snapshot.error.toString()),
//             );
//           }
//           return snapshot.data == null || snapshot.data!.isEmpty
//               ? const SizedBox.shrink()
//               : FittedBox(
//                   child: DropdownButton(
//                     dropdownColor: scaffoldBackgroundColor,
//                     iconEnabledColor: Colors.white,
//                     items: List<DropdownMenuItem<String>>.generate(
//                         snapshot.data!.length,
//                         (index) => DropdownMenuItem(
//                             value: snapshot.data![index].id,
//                             child: TextWidget(
//                               label: snapshot.data![index].id,
//                               fontSize: 15,
//                             ))),
//                     value: currentModel,
//                     onChanged: (value) {
//                       setState(() {
//                         currentModel = value.toString();
//                       });
//                       modelsProvider.setCurrentModel(
//                         value.toString(),
//                       );
//                     },
//                   ),
//                 );
//         });
//   }
// }
