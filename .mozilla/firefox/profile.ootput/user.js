//    Firefox 1.5.0.1 user.js     //
//                                //
//    for use with all themes     //
//                                //
//           by Grypen            //

// http://www.users.on.net/~grypen/Downloads/?C=M%3BO=D

// Put an end to blinking text!
user_pref("browser.blink_allowed", false);

// Prevent downloading of Favicons and Site Icons
user_pref("browser.chrome.favicons", false);
user_pref("browser.chrome.site_icons", false);

// Stop Download Manager popup when finished
user_pref("browser.download.manager.showAlertOnComplete", false);

// Stop yellow bar popping up when a plugin is not installed but required
user_pref("plugin.default_plugin_disabled", false);

// Turn off Automatic Image Resizing
user_pref("browser.enable_automatic_image_resizing", false);

// Disable network prefetching
user_pref("network.prefetch-next", false);

// Disable clicked link from having dotted border
user_pref("browser.display.focus_ring_width", 0);

// Slow Page Loading Fix:
user_pref("network.dns.disableIPv6", true);

// Speedup settings for broadband
user_pref("content.max.tokenizing.time", 3000000);
user_pref("content.notify.backoffcount", 5);
user_pref("content.notify.interval", 750000);
user_pref("content.notify.ontimer", true);
user_pref("content.interrupt.parsing", true);
user_pref("content.maxtextrun", 8191);
user_pref("content.switch.threshold", 750000);
// user_pref("browser.cache.disk_cache_ssl", true);
user_pref("network.http.max-connections", 48);
user_pref("network.http.max-connections-per-server", 32);
user_pref("network.http.max-persistent-connections-per-proxy", 16);
user_pref("network.http.max-persistent-connections-per-server", 8);
user_pref("network.http.pipelining", true);
user_pref("network.http.pipelining.maxrequests", 8);
user_pref("network.http.proxy.pipelining", true);
user_pref("nglayout.initialpaint.delay", 0);
user_pref("dom.disable_window_status_change", true);
user_pref("dom.max_script_run_time", 5);
user_pref("browser.sessionhistory.max_total_viewers", 4);
user_pref("browser.block.target_new_window", true);
user_pref("browser.tabs.closeButtons", 2);
user_pref("security.dialog_enable_delay", 0);
