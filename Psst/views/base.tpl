<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Psst - microblogging</title>
<link href='http://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic' rel='stylesheet' type='text/css'>
<link href="/static/style.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery.min.js"></script>
<script src="/static/vegas.min.js"></script>
<link href="/static/vegas.min.css" rel="stylesheet">
</head>
<body>
<script>
var isOpera = !!window.opera || navigator.userAgent.indexOf(' OPR/') >= 0;
    // Opera 8.0+ (UA detection to detect Blink/v8-powered Opera)
var isFirefox = typeof InstallTrigger !== 'undefined';   // Firefox 1.0+
var isSafari = Object.prototype.toString.call(window.HTMLElement).indexOf('Constructor') > 0;
    // At least Safari 3+: "[object HTMLElementConstructor]"
var isChrome = !!window.chrome && !isOpera;              // Chrome 1+
var isIE = /*@cc_on!@*/false || !!document.documentMode;   // At least IE6

if((isOpera==false) && (isChrome==false)) {
    alert("Please use Blink engine browsers (such as Chrome or Opera) to browse this site.");
}

$('#example, body').vegas({
	timer: false,
	transitionDuration: 2000,
	shuffle: true,
    slides: [
        { src: '/static/images/background1.jpg' },
        { src: '/static/images/background2.jpg' },
        { src: '/static/images/background3.jpg'}
    ]
});

function submitenter(myfield,e)
{
var keycode;
if (window.event) keycode = window.event.keyCode;
else if (e) keycode = e.which;
else return true;

if (keycode == 13)
   {
   myfield.form.submit();
   return false;
   }
else
    return true;
}
</script>
<header><a href="/"><img src="/static/images/logo.png" width="200px"/></a></header>
<div class="content">
<section>
{{!base}}
</section>
<footer>
<p>©2015 <a href="mailto:jasonkwh@gmail.com?subject=Psst">Jason Huang</a>.</p>
</footer>
</div>
<div class="sidebar">
<section>
<form name="searchForm" method="POST" action ="/search">
<input type="text" name="search" placeholder="search" class="focus" onKeyPress="return submitenter(this,event)">
</form>
</section>
</div>
<div class="sidebar2">
<section>
{{!login}}
{{!validate}}
</section>
</div>
</body>
</html>