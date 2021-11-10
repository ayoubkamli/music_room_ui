const ip = '192.168.99.100';
final Uri registerUrl = Uri.parse('http://$ip/api/auth/register');
final Uri consirmationUrl = Uri.parse('http://$ip/api/email/confirm');
final Uri loginUrl = Uri.parse('http://$ip/api/auth/login');
final Uri logoutUrl = Uri.parse('http://$ip/api/user/logout');
final Uri eventUrl = Uri.parse('http://$ip/api/events');
final Uri myEventUrl = Uri.parse('http://$ip/api/my-events');
final Uri playlistUrl = Uri.parse('http://$ip/api/playlists');
final Uri userDataUrl = Uri.parse('http://$ip/api/me');
final Uri forgotPasswordUrl = Uri.parse('http://$ip/api/password/forgot');
// final Uri searchTracksUrl = Uri.parse(
//     'http://minikube-ip/api/users/search?username="simo"&page=1&limit=2');

final String searchTrackUrl = 'http://$ip/api/tracks/search?name=';

final String imageUrl =
    'https://i.picsum.photos/id/629/536/354.jpg?hmac=NWta_CV-ruzeQyb9CvcPbGAmrmMV66H8m9A2d_8rdpI';

final List<String> prefList = ["POP", "R&B", "HIP HOP", "JAZZ", "K-POP"];

const kUrl1 = 'https://luan.xyz/files/audio/ambient_c_motion.mp3';
const kUrl2 = 'https://luan.xyz/files/audio/nasa_on_a_mission.mp3';
const kUrl3 = 'http://bbcmedia.ic.llnwd.net/stream/bbcmedia_radio1xtra_mf_p';

const iconSize = 30.0;

// http://192.168.99.116/api/tracks/search?name=sia
