import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/constant/constant.dart';
import 'package:myapp/events/logic/image_state.dart';

class ImageEventCubit extends Cubit<ImageEventState> {
  ImageEventCubit() : super(ImageEventInitState());

  static ImageEventCubit get(BuildContext context) {
    return BlocProvider.of(context);
  }

  String imageUrl =
      'https://i.picsum.photos/id/353/200/300.jpg?hmac=dp_gN1fPfq1NcUZmNjRXfOwD3UH0D4B8A-jwvjByOyc';

  getImageUrl(data) async* {
    if (data.imgUrl != null) {
      print(data.imgUrl);
      String url = data.imgUrl.toString();
      List<String>? s = url.split("/");
      String? imgUrl = "http://$ip/api/media/${s[s.length - 1]}";
      http.Response response = await http.get(Uri.parse(imgUrl));
      if (response.statusCode == 200) {
        yield (ImageEventLoadedState);
        emit(ImageEventLoadedState(url: imgUrl));
      }
      print('image url from cubit' + imageUrl);

      emit(ImageEventLoadedState(url: imageUrl));
    }
  }
}
