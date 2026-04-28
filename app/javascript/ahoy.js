// Ahoy.js - Simple page view tracker
// Sends a POST to /ahoy/visits on each page load

(function() {
  function getCookie(name) {
    var match = document.cookie.match(new RegExp('(^| )' + name + '=([^;]+)'));
    return match ? decodeURIComponent(match[2]) : null;
  }

  function setCookie(name, value, duration) {
    var expires = "";
    if (duration) {
      var date = new Date();
      date.setTime(date.getTime() + duration);
      expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + encodeURIComponent(value) + expires + "; path=/; SameSite=Lax";
  }

  function generateToken() {
    return ([1e7]+-1e3+-4e3+-8e3+-1e11).replace(/[018]/g, function(c) {
      return (c ^ crypto.getRandomValues(new Uint8Array(1))[0] & 15 >> c / 4).toString(16);
    });
  }

  function trackVisit() {
    var visitToken = getCookie("ahoy_visit");
    var visitorToken = getCookie("ahoy_visitor");

    if (!visitToken) {
      visitToken = generateToken();
      setCookie("ahoy_visit", visitToken, 4 * 60 * 60 * 1000); // 4 hours
    }

    if (!visitorToken) {
      visitorToken = generateToken();
      setCookie("ahoy_visitor", visitorToken, 2 * 365 * 24 * 60 * 60 * 1000); // 2 years
    }

    var data = {
      visit_token: visitToken,
      visitor_token: visitorToken,
      platform: "Web",
      landing_page: window.location.href,
      screen_width: window.screen.width,
      screen_height: window.screen.height,
      js: true
    };

    // Add referrer if present
    if (document.referrer && document.referrer !== "") {
      data.referrer = document.referrer;
    }

    // Add user agent
    data.user_agent = navigator.userAgent;

    fetch("/ahoy/visits", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify(data),
      keepalive: true
    }).catch(function(err) {
      // Silently fail - analytics shouldn't break the site
      console.debug("Ahoy tracking error:", err);
    });
  }

  // Track on page load
  if (document.readyState === "loading") {
    document.addEventListener("DOMContentLoaded", trackVisit);
  } else {
    trackVisit();
  }

  // Track on Turbo navigation
  document.addEventListener("turbo:load", trackVisit);
})();
