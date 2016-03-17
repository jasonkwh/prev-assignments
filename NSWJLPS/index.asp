<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"[]>
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-US" xml:lang="en">
<head><LINK REL="SHORTCUT ICON" href="images/favicon.ico">
    <!--
    Created by Artisteer v3.0.0.39952
    Base template (without user's data) checked by http://validator.w3.org : "This page is valid XHTML 1.0 Transitional"
    -->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>NSW Justice Link Police System</title>
    <meta name="description" content="Description" />
    <meta name="keywords" content="Keywords" />


    <link rel="stylesheet" href="style.css" type="text/css" media="screen" />
    <!--[if IE 6]><link rel="stylesheet" href="style.ie6.css" type="text/css" media="screen" /><![endif]-->
    <!--[if IE 7]><link rel="stylesheet" href="style.ie7.css" type="text/css" media="screen" /><![endif]-->

    <script type="text/javascript" src="jquery.js"></script>
    <script type="text/javascript" src="script.js"></script>
	<script type="text/javascript">
	function validateForm()
	{	
	
	var un=document.forms["loginForm"]["employeeID"].value;
	let = /[a-z]/;	
	num = /[0-9]/;
	var illegalChars = /[\W_]/;
	
	if (un.length<6)
		{
		alert("Username must be at least 6 characters");
		return false;
		}	
	if(isNaN(un)) 
		{	
        alert("Username must contain numerals only.");
		return false;
		}	
	if (illegalChars.test(un)) 
		{
		alert("Username contains invalid symbols.");
		return false;
		}
	if (un.length>20)
		{
		alert("Username must be a maximum of 20 characters");
		return false;
		}	
		
	
	var ps1=document.forms["loginForm"]["password1"].value;	
	if (ps1.length<6)
		{
		alert("Password must be at least 6 characters");
		return false;
		}	
	if(!num.test(ps1) || !let.test(ps1)) 
		{	
        alert("Password must contain letters and numerals.");
		return false;
		}	
	if (illegalChars.test(ps1)) 
		{
		alert("Password contains invalid symbols.");
		return false;
		}
	if (ps1.length>20)
		{
		alert("Password must be a maximum of 20 characters");
		return false;
		}	
	}
		
	</script>
</head>
<body>
<div id="art-page-background-glare">
    <div id="art-page-background-glare-image"> </div>
</div>
<div id="art-main">
    <div class="art-sheet">
        <div class="art-sheet-tl"></div>
        <div class="art-sheet-tr"></div>
        <div class="art-sheet-bl"></div>
        <div class="art-sheet-br"></div>
        <div class="art-sheet-tc"></div>
        <div class="art-sheet-bc"></div>
        <div class="art-sheet-cl"></div>
        <div class="art-sheet-cr"></div>
        <div class="art-sheet-cc"></div>
        <div class="art-sheet-body">
            <div class="art-header">
                <div class="art-header-clip">
                <div class="art-header-center">
                    <div class="art-header-jpeg"></div>
                </div>
                </div>
                <div class="art-logo">
                                 <h1 class="art-logo-name"><a href="./index.asp"></a></h1>
                                                 <h2 class="art-logo-text"></h2>
                                </div>
            </div>
            <div class="cleared reset-box"></div>
<div class="art-nav">
	<div class="art-nav-l"></div>
	<div class="art-nav-r"></div>
<div class="art-nav-outer">
	<ul class="art-hmenu">	
		<li>
			<a href="./login.asp"><span class="l"></span><span class="r"></span><span class="t">Log In</span></a>
		</li>	
        <li>
			<a href="./support.asp"><span class="l"></span><span class="r"></span><span class="t">Support</span></a>
		</li>	
	</ul>
</div>
</div>
<div class="cleared reset-box"></div>
<div class="art-content-layout">
                <div class="art-content-layout-row">
                    <div class="art-layout-cell art-sidebar1">
<div class="art-vmenublock">
    <div class="art-vmenublock-tl"></div>
    <div class="art-vmenublock-tr"></div>
    <div class="art-vmenublock-bl"></div>
    <div class="art-vmenublock-br"></div>
    <div class="art-vmenublock-tc"></div>
    <div class="art-vmenublock-bc"></div>
    <div class="art-vmenublock-cl"></div>
    <div class="art-vmenublock-cr"></div>
    <div class="art-vmenublock-cc"></div>
    <div class="art-vmenublock-body">
                <div class="art-vmenublockheader">
                    <div class="l"></div>
                    <div class="r"></div>
                    <h3 class="t">Version 1.22</h3>
                </div>
                <div class="art-vmenublockcontent">
                    <div class="art-vmenublockcontent-body">
                <ul class="art-vmenu">
	<li>
		<a href="./readme.txt" class="active"><span class="l"></span><span class="r"></span><span class="t">Changelogs</span></a>
	</li>	
</ul>
                
                                		<div class="cleared"></div>
                    </div>
                </div>
		<div class="cleared"></div>
    </div>
</div>

                      <div class="cleared"></div>
                    </div>
                    <div class="art-layout-cell art-content">
<div class="art-post">
    <div class="art-post-body">
<div class="art-post-inner art-article">
                                <h2 class="art-postheader">Login</h2>
                <div class="cleared"></div>
                                <div class="art-postcontent">
								
								
								<FORM NAME="loginForm" METHOD=POST ACTION="verify.asp" onsubmit="return validateForm()">								
																
								<div class="row">
								<span class="label">Employee ID:</span><span class="formw"><input type=Integer name="employeeID"></span>
								</div>
								
								<div class="row">
								<span class="label">Password:</span><span class="formw"><input type=password name="password1"><p> </p><a href="./passwordretrieve.asp">Forgot password?</a></span>
                                </div>
								
								<center>
								<div class="row"><span class="errormsg"><%=errorMessage%></span></div>
								</center>
								
								<div class="row">
								<span class="label"></span><span class="formw"><INPUT TYPE=SUBMIT value="Login"></span>
								</div>
								 								
								</div>
								
								</form>
                </div>
                <div class="cleared"></div>
                </div>

		<div class="cleared"></div>
    </div>
</div>

                      <div class="cleared"></div>
                    </div>
                </div>
            </div>
            <div class="cleared"></div>
            <div class="art-footer">
                <div class="art-footer-t"></div>
                <div class="art-footer-l"></div>
                <div class="art-footer-b"></div>
                <div class="art-footer-r"></div>
                <div class="art-footer-body">
                            <div class="art-footer-text">
                                <p><a href="./login.asp">Login</a> | <a href="./support.asp">Support</a> | <a href="javascript:(function(){f='http://www.delicious.com/save?url='+encodeURIComponent(window.location.href)+'&title='+encodeURIComponent(document.title)+'&notes='+encodeURIComponent(''+(window.getSelection?window.getSelection():document.getSelection?document.getSelection():document.selection.createRange().text))+'&v=6&';a=function(){if(!window.open(f+'noui=1&jump=doclose','deliciousuiv6','location=1,links=0,scrollbars=0,toolbar=0,width=710,height=660'))location.href=f+'jump=yes'};if(/Firefox/.test(navigator.userAgent)){setTimeout(a,0)}else{a()}})()">Add to Delicious</a></p><p>(C) Super Brilliant Jason. All Rights Reserved.</p>
                                                            </div>
                    <div class="cleared"></div>
                </div>
            </div>
    		<div class="cleared"></div>
        </div>
    </div>
    <div class="cleared"></div>
</div>

</body>
</html>
