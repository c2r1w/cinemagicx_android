


// Future<void> main(List<String> args) async {
//   final hdr = {
//     "content-type": "application/json",
//     "Authorization":
//         "key=AAAAENlwMkk:APA91bHR14AUuANcsx4j-q_OWxnd48BkQ1oBuvUnMwEkawXztSHipgzbnG1IPGf7M8ns2fxvCiegnjgWUU-d3RaoJnsLxmZMn9MhkAds0oZlDZ6yvrInBNqxxccZpB7S_ihJtr_qxm_z"
//   };
//   final yp = await http.post(Uri.parse("https://fcm.googleapis.com/fcm/send"),
//       headers: hdr,
//       body: jsonEncode({
//         "notification": {"title": "call", "body": "Video Call"},
//         "data": {"type": true, "id": "65ec68a99f8cb88834f5da2d"},
//         "to": "/topics/65ec68a99f8cb88834f5da2d"
//         // "cjORX4zUTNOajJ0-eUMuTj:APA91bE9DzO6k9oAHdlMGDZQ7ZKxMasZxBRAA_5Frw9sig15UdMpPk_8ZPEFqYG7kAyudcXLZoDhNF8D1VXhiQvjlubPUTd0ez79-1_RvGQF_cBrqVGFdHzbHgsz4iMbRSz1tkFWqMvU"
//       }));

//   print(yp.body);
// }





//  const response = await axios.post('https://fcm.googleapis.com/fcm/send', message, {
//         headers: {
//             'Authorization': `key=AAAAENlwMkk:APA91bHR14AUuANcsx4j-q_OWxnd48BkQ1oBuvUnMwEkawXztSHipgzbnG1IPGf7M8ns2fxvCiegnjgWUU-d3RaoJnsLxmZMn9MhkAds0oZlDZ6yvrInBNqxxccZpB7S_ihJtr_qxm_z`,
//             'Cxontent-Type': 'application/json'
//         }
//     });

//      const message = {
        

//         to: "/topics/"+req.query.id

//     }