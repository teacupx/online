changequote([,])dnl
dnl# foreachq(x, `item_1, item_2, ..., item_n', stmt)
dnl# quoted list, alternate improved version
define([foreachq],[ifelse([$2],[],[],[pushdef([$1])_$0([$1],[$3],[],$2)popdef([$1])])])dnl
define([_foreachq],[ifelse([$#],[3],[],[define([$1],[$4])$2[]$0([$1],[$2],shift(shift(shift($@))))])])dnl
<!DOCTYPE html>
<!-- saved from url=(0054)http://leafletjs.com/examples/quick-start-example.html -->
<html><head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Online Editor</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<script>
  // Start listening for Host_PostmessageReady message and save the
  // result for future
  window.WOPIpostMessageReady = false;
  var PostMessageReadyListener = function(e) {
    var msg = JSON.parse(e.data);
    if (msg.MessageId === 'Host_PostmessageReady') {
      window.WOPIPostmessageReady = true;
      window.removeEventListener('message', PostMessageReadyListener, false);
    }
  };
  window.addEventListener('message', PostMessageReadyListener, false);
</script>
ifelse(DEBUG,[true],foreachq([fileCSS],[LOLEAFLET_CSS],[<link rel="stylesheet" href="/loleaflet/%VERSION%/fileCSS" />
]),[<link rel="stylesheet" href="/loleaflet/%VERSION%/bundle.css" />
])dnl
<!--%BRANDING_CSS%--> <!-- add your logo here -->
<link rel="localizations" href="/loleaflet/%VERSION%/l10n/localizations.json" type="application/vnd.oftn.l10n+json"/>
<link rel="localizations" href="/loleaflet/%VERSION%/l10n/locore-localizations.json" type="application/vnd.oftn.l10n+json" />
<link rel="localizations" href="/loleaflet/%VERSION%/l10n/help-localizations.json" type="application/vnd.oftn.l10n+json"/>
<link rel="localizations" href="/loleaflet/%VERSION%/l10n/uno-localizations.json" type="application/vnd.oftn.l10n+json" />
</head>

  <body style="user-select: none;">
    <!--The "controls" div holds map controls such as the Zoom button and
        it's separated from the map in order to have the controls on the top
        of the page all the time.

        The "document-container" div is the actual display of the document, is
        what the user sees and it should be no larger than the screen size.

        The "map" div is the actual document and it has the document's size
        and width, this being inside the smaller "document-container" will
        cause the content to overflow, creating scrollbars -->

    <div class="header-wrapper">
      <div id="logo" class="logo"></div>
      <nav class="main-nav" role="navigation">
	<!-- Mobile menu toggle button (hamburger/x icon) -->
	<input id="main-menu-state" type="checkbox" />
	<label class="main-menu-btn" for="main-menu-state">
	  <span class="main-menu-btn-icon"></span>
	</label>
	<ul id="main-menu" class="sm sm-simple lo-menu"></ul>
      </nav>
      <table id="toolbar-wrapper">
	<tr>
	  <td id="toolbar-logo"></td>
	  <td id="toolbar-up"</td>
	  <td id="toolbar-hamburger"></td>
	</tr>
	<tr>
	  <td colspan="3" id="formulabar"></td>
	</tr>
      </table>
      <input id="insertgraphic" type="file" style="position: fixed; top: -100em">
    </div>

    <input id="document-name-input" type="text" disabled="true"/>

    <div id="closebuttonwrapper">
      <div class="closebuttonimage" id="closebutton"></div>
    </div>

    <div id="spreadsheet-row-column-frame">
    </div>

    <div id="document-container">
      <div id="map"></div>
    </div>
    <div id="spreadsheet-toolbar"></div>

    <div id="presentation-controls-wrapper">
      <div id="slide-sorter"></div>
      <div id="presentation-toolbar"></div>
    </div>

    <div id="toolbar-down"></div>

    <!-- Remove if you don't want the About dialog -->
    <div id="about-dialog" style="display:none; text-align: center; user-select: text">
      <h1 id="product-name">LibreOffice Online</h1>
      <hr/>
      <p id="product-string"></p>
      <h3>LOOLWSD</h3>
      <div id="loolwsd-version"></div>
      <h3>LOKit</h3>
      <div id="lokit-version"></div>
    </div>

    <script>
      window.host = '%HOST%';
      window.accessToken = '%ACCESS_TOKEN%';
      window.accessTokenTTL = '%ACCESS_TOKEN_TTL%';
      window.accessHeader = '%ACCESS_HEADER%';
      window.loleafletLogging = '%LOLEAFLET_LOGGING%';
      window.outOfFocusTimeoutSecs = %OUT_OF_FOCUS_TIMEOUT_SECS%;
      window.idleTimeoutSecs = %IDLE_TIMEOUT_SECS%;
    </script>
ifelse(DEBUG,[true],foreachq([fileJS],[LOLEAFLET_JS],
[    <script src="/loleaflet/%VERSION%/fileJS"></script>
]),
[    <script src="/loleaflet/%VERSION%/bundle.js"></script>
])dnl
    <!--%BRANDING_JS%--> <!-- logo onclick handler -->
</body></html>
