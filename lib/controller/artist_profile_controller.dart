// import 'package:get/get.dart';
// import 'package:mahar_tv/model/movie_builder_model.dart';
// import 'package:mahar_tv/services/api_repo.dart';
// import 'package:mahar_tv/utils/app_theme.dart';
// import 'package:mahar_tv/utils/constants.dart';

// class ArtistProfileController extends GetxController {
//   final isLoading = false.obs;

//   final RxList<MovieBuilderModel> seriesBuilderList = <MovieBuilderModel>[].obs;

//   @override
//   void onInit() async {
//     super.onInit();
//     await getBuilderList();
//   }

//   @override
//   void onReady() {
//     //
//   }

//   @override
//   void onClose() {
//     //
//   }

//   Future<void> getBuilderList() async {
//     isLoading.value = true;
//     try {
//       final result = await ApiRepo().getSeriesBuilderList();
//       seriesBuilderList.value = result;
//     } catch (e) {
//       isLoading.value = false;
//       constants.showSnackBar(
//           title: 'Error', msg: e.toString(), textColor: AppTheme.red);
//     } finally {
//       isLoading.value = false;
//     }
//   }
// }
