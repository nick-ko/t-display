const baseUrl = "https://tdisplay.tinitz.com/api/";

const queingUrl = "http://devpankart.egaz.shop/api/";

final headers = {
  'Content-Type': 'application/json',
  'Accept': 'application/json'
};

Map<String, String> headersToken(String token) {
  return {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };
}
