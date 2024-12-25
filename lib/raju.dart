import 'package:flutter_hls_parser/flutter_hls_parser.dart';
import 'package:http/http.dart' as http;

const backendurl = "http://api.cinemagicx.com/api";

const imgUrl = "http://cdn.cinemagicx.com/";

// // const sentotp = "/sendotp";//{"number":"83748374"}
// const backendurl = "http://192.168.1.36:3000/api";

// const imgUrl = "http://192.168.1.43:3000/uploads/";

const sentotp = "/sendotp"; //{"number":"83748374"}

Future<void> getHLSVideoUrls() async {
  final fpxt = Uri.parse(
      'https://dacastmmod-mmd-cust.lldns.net/127--1711186015--1711186135--8f4b53d770aa95a1be8b4ab82544f02c/e5/7b127d5f-3b75-4c9c-ae84-7d7ddbd9c832/5bda7af1-b37e-424e-a1a7-3a0c013983c2/stream.ismd/stream-audio=125720.m3u8?stream=2bb303f5-dac2-1c00-24e4-9449893b521f_rendition%3B87681312-6924-2316-add8-d7c66315fef9_rendition%3B8ca0a648-039c-c32c-70e1-5f02a26cd797_rendition');
  final response = await http.get(fpxt);

  if (response.statusCode == 200) {
    final playList =
        await HlsPlaylistParser.create().parseString(fpxt, response.body);
    playList as HlsMediaPlaylist;

    print(playList.segments[1].url);
  } else {
    throw Exception('Failed to load HLS playlist');
  }
}




// void main(List<String> args) {
//   getHLSVideoUrls();
// }
