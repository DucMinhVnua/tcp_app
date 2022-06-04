/// enable network proxy
const debugNetworkProxy = false;

/// some constants Local Key
const kLocalKey = {
  "userInfo": "userInfo",
  "recentSearches": "recentSearches",
  "home": "home",
};

/// Logging config
const kLOG_TAG = "[TCP]";
const kLOG_ENABLE = false;

void printLog(dynamic data) {
  if (kLOG_ENABLE) {
    // ignore: avoid_print
    print("[${DateTime.now().toUtc()}]$kLOG_TAG${data.toString()}");
  }
}
