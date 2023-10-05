// disable about:config warning
user_pref("browser.aboutConfig.showWarning", false);
// use mozilla location services rather than google
user_pref("geo.provider.network.url", "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%");
// disable OS geolocation
user_pref("geo.provider.ms-windows-location", false); // [WINDOWS]
user_pref("geo.provider.use_corelocation", false); // [MAC]
user_pref("geo.provider.use_gpsd", false); // [LINUX]
user_pref("geo.provider.use_geoclue", false); // [FF102+] [LINUX]

// prefered language to en-US
user_pref("intl.accept_languages", "en-US, en");
// use it regardless of the system locale
user_pref("javascript.use_us_english_locale", true); // [HIDDEN PREF]
// disable recommendations pane for addons
user_pref("extensions.getAddons.showPane", false); // [HIDDEN PREF]
user_pref("extensions.htmlaboutaddons.recommendations.enabled", false);
user_pref("browser.discovery.enabled", false);

// disable a bunch of telemetry
user_pref("datareporting.policy.dataSubmissionEnabled", false);
user_pref("datareporting.healthreport.uploadEnabled", false);
user_pref("toolkit.telemetry.unified", false);
user_pref("toolkit.telemetry.enabled", false); // see [NOTE]
user_pref("toolkit.telemetry.server", "data:,");
user_pref("toolkit.telemetry.archive.enabled", false);
user_pref("toolkit.telemetry.newProfilePing.enabled", false); // [FF55+]
user_pref("toolkit.telemetry.shutdownPingSender.enabled", false); // [FF55+]
user_pref("toolkit.telemetry.updatePing.enabled", false); // [FF56+]
user_pref("toolkit.telemetry.bhrPing.enabled", false); // [FF57+] Background Hang Reporter
user_pref("toolkit.telemetry.firstShutdownPing.enabled", false); // [FF57+]

user_pref("toolkit.telemetry.coverage.opt-out", true); // [HIDDEN PREF]
user_pref("toolkit.coverage.opt-out", true); // [FF64+] [HIDDEN PREF]
user_pref("toolkit.coverage.endpoint.base", "");

user_pref("browser.ping-centre.telemetry", false);

user_pref("browser.newtabpage.activity-stream.feeds.telemetry", false);
user_pref("browser.newtabpage.activity-stream.telemetry", false);

// disable studies
user_pref("app.shield.optoutstudies.enabled", false);

// disable normandy
user_pref("app.normandy.enabled", false);
user_pref("app.normandy.api_url", "");

// disable crash reports
user_pref("breakpad.reportURL", "");
user_pref("browser.tabs.crashReporting.sendReport", false); // [FF44+]

user_pref("browser.crashReports.unsubmittedCheck.autoSubmit2", false); // [DEFAULT: false]

// disable captive portal detection, this is a desktop, why would I need it lmao
user_pref("captivedetect.canonicalURL", "");
user_pref("network.captive-portal-service.enabled", false); // [FF52+]

user_pref("network.connectivity-service.enabled", false);


// stop prefetching stuff, saves network and privacy
user_pref("network.prefetch-next", false);
user_pref("network.dns.disablePrefetch", true);
// disable predictor
user_pref("network.predictor.enabled", false);
user_pref("network.predictor.enable-prefetch", false); // [FF48+] [DEFAULT: false]
// disable connect on link hover
user_pref("network.http.speculative-parallel-limit", 0);

user_pref("browser.places.speculativeConnect.enabled", false);


// disable GIO protocols
user_pref("network.gio.supported-protocols", "");


// disable attempting to fix typos in domains
user_pref("browser.fixup.alternate.enabled", false); // [DEFAULT: false FF104+]

// disable location bar speculative connect
user_pref("browser.urlbar.speculativeConnect.enabled", false);


// disable leaking stuff to DNS
user_pref("browser.urlbar.dnsResolveSingleWordsAfterSearch", 0); // [DEFAULT: 0 FF104+]

// disable sponsored content in url bar
user_pref("browser.urlbar.suggest.quicksuggest.nonsponsored", false); // [FF95+]
user_pref("browser.urlbar.suggest.quicksuggest.sponsored", false);

// disable potential HTTPS MITM [!] attacks
user_pref("security.ssl.require_safe_negotiation", true);

// disable round trip time data
user_pref("security.tls.enable_0rtt_data", false);

// actually verify that the key is correct
user_pref("security.OCSP.require", true);


// disable accesibility services
user_pref("accessibility.force_disabled", 1);

// disable UITour
user_pref("browser.uitour.enabled", false);

// disable remote debugging
user_pref("devtools.debugger.remote-enabled", false); // [DEFAULT: false]

// disable loading link from clipboard using middle mouse button
user_pref("middlemouse.contentLoadURL", false);

// disable websites overriding firefox's keyboard shortcuts
user_pref("webchannel.allowObject.urlWhitelist", "");

// disable non-english characters in domain names to prevent spoofing
user_pref("network.IDN_show_punycode", true);

// use PDFJS viewer
user_pref("pdfjs.disabled", false); // [DEFAULT: false]
user_pref("pdfjs.enableScripting", true); // [FF86+]

// disable permissions delegation
user_pref("permissions.delegation.enabled", false);

// use system colors
user_pref("browser.display.use_system_colors", false); // [DEFAULT: false NON-WINDOWS]


// use default non native theme to reduce api calls
user_pref("widget.non-native-theme.enabled", true); // [DEFAULT: true]

// open tabs meant for a new window in a new tab instead
user_pref("browser.link.open_newwindow", 3); // [DEFAULT: 3]
user_pref("browser.link.open_newwindow.restriction", 0);

// [!!!] Disable WebGL, this WILL break some stuff [!!!]
user_pref("webgl.disabled", true);


// a bunch of various things
user_pref("extensions.blocklist.enabled", true); // [DEFAULT: true]
// enforce no referer spoofing
user_pref("network.http.referer.spoofSource", false); // [DEFAULT: false]
// enforce delay on confirmation dialogs to prevent a race condition
user_pref("security.dialog_enable_delay", 1000); // [DEFAULT: 1000]
// enforce first party isolation
user_pref("privacy.firstparty.isolate", false); // [DEFAULT: false]
// enforce SmartBlock
user_pref("extensions.webcompat.enable_shims", true); // [DEFAULT: true]
// [!!!] Disable TLS 1.0/1.1
user_pref("security.tls.version.enable-deprecated", false); // [DEFAULT: false]
/* 6011: enforce disabling of Web Compatibility Reporter [FF56+]
 * Web Compatibility Reporter adds a "Report Site Issue" button to send data to Mozilla
 * [WHY] To prevent wasting Mozilla's time with a custom setup ***/
user_pref("extensions.webcompat-reporter.enabled", false); // [DEFAULT: false]

// disable stupid button
user_pref("extensions.webcompat-reporter.enabled", false); // [DEFAULT: false]

// send do not track
user_pref("privacy.donottrackheader.enabled", true);

// set initial paint delay
user_pref("nglayout.initialpaint.delay", 0); // default=5; used to be 250
user_pref("nglayout.initialpaint.delay_in_oopif", 0); // default=5

// GPU acceleration
user_pref("gfx.canvas.accelerated", true); // DEFAULT macOS LINUX [FF110]; not compatible with WINDOWS integrated GPUs
user_pref("gfx.canvas.accelerated.cache-items", 4096); // default=2048; alt=8192
user_pref("gfx.canvas.accelerated.cache-size", 512); // default=256; alt=1024
user_pref("gfx.content.skia-font-cache-size", 20); // default=5; Chrome=20

// network buffer things to reduce CPU usage
user_pref("network.buffer.cache.size", 262144); // 256 kb; default=32768 (32 kb)
user_pref("network.buffer.cache.count", 128); // default=24

// set max HTTP connections
user_pref("network.http.max-connections", 1800); // default=900
user_pref("network.http.max-persistent-connections-per-server", 10); // default=6; download connections; anything above 10 is excessive
user_pref("network.http.max-urgent-start-excessive-connections-per-host", 5); // default=3

user_pref("network.ssl_tokens_cache_capacity", 10240); // default=2048; more TLS token caching (fast reconnects)
