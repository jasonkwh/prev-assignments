<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"[]>
<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="database.asp" -->
<%
	
	If Session("Authenticated") = 0 or Session("access") <> 3 Then
		Session.Timeout=5	
		Session("TimeoutMsg")=1	
		Response.Redirect ("login.asp")	
	End if
		

%>
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-US" xml:lang="en">
<head><LINK REL="SHORTCUT ICON" href="images/favicon.ico">
    <!--
    Created by Artisteer v3.0.0.39952
    Base template (without user's data) checked by http://validator.w3.org : "This page is valid XHTML 1.0 Transitional"
    -->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Search Court Order</title>
    <meta name="description" content="Description" />
    <meta name="keywords" content="Keywords" />


    <link rel="stylesheet" href="style.css" type="text/css" media="screen" />
    <!--[if IE 6]><link rel="stylesheet" href="style.ie6.css" type="text/css" media="screen" /><![endif]-->
    <!--[if IE 7]><link rel="stylesheet" href="style.ie7.css" type="text/css" media="screen" /><![endif]-->

    <script type="text/javascript" src="jquery.js"></script>
    <script type="text/javascript" src="script.js"></script>
	<script type="text/javascript">
	window.history.forward();
	function noBack()
	{
		windown.history.forward();
	}	
	
	function showHint()
	{
	var xmlhttp;
		xmlhttp=new XMLHttpRequest();
		first = document.getElementById("firstname").value
		last = document.getElementById("lastname").value
		offence = document.getElementById("offencename").value
		court = document.getElementById("courtname").value
		courtd = document.getElementById("courtdate").value
		courtt = document.getElementById("courttime").value
		
		if (last=="" && first=="" && offence=="" && court=="" && courtd=="" && courtt=="")
		{
			document.getElementById("cotable").innerHTML="";
			return;
		}
		
		xmlhttp.onreadystatechange=function()
		{
			if (xmlhttp.readyState==4 && xmlhttp.status==200)
			{
				document.getElementById("cotable").innerHTML=xmlhttp.responseText;
			}
		}
		
	xmlhttp.open("GET","courtgetco.asp?f="+first+"&l="+last+"&o="+offence+"&c="+court+"&d="+courtd+"&t="+courtt ,true);
	xmlhttp.send();
	}

	var exdays=60;
	var exdate=new Date();
	exdate.setDate(exdate.getDate() + exdays);
	
	function setCookie(c_name,value)
	{	
		var c_value=escape(value) + ((exdays==null) ? "" : "; expires="+exdate.toUTCString());
		document.cookie=c_name + "=" + c_value;
	}	
	
	function editCourtOrder(offenceid)
	{
		setCookie("courteditcoid",offenceid)
		window.location = "courteditco.asp"
	}	
	</script>
	</head>
		<body onload = "noBack();" onpageshow = "if (event.persisted)noBack();" onunload="">
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
            <h1 class="art-logo-name"></h1>
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
				<a href="./logout.asp" class="active"><span class="l"></span><span class="r"></span><span class="t">Log Out</span></a>
			</li>
			<li>
				<a href="./courtchangepassword.asp" class="active"><span class="l"></span><span class="r"></span><span class="t">Settings</span></a>
			</li>
            <li>
				<a href="./courtsupport.asp" class="active"><span class="l"></span><span class="r"></span><span class="t">Support</span></a>
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
        <h3 class="t">Court</h3>
        </div>
        <div class="art-vmenublockcontent">
        <div class="art-vmenublockcontent-body">
		<ul class="art-vmenu">
			<li>
				<a href="./courthome.asp"><span class="l"></span><span class="r"></span><span class="t">Assign Court Order</span></a>
			</li>
			<li>
				<a href="./courtaddcoverdict.asp"><span class="l"></span><span class="r"></span><span class="t">Add Verdict</span></a>
			</li>
			<li>
				<a href="./courtsearch.asp"><span class="l"></span><span class="r"></span><span class="t">Search Court Order</span></a>
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
			<h2 class="art-postheader"> Search Court Order </h2>
		<div class="cleared"></div>
        <div class="art-postcontent">
			
		<!--<FORM NAME="viewCourtOrder" METHOD=POST ACTION="update.asp" onsubmit="return validateForm()">-->								
		
			<div class="row">
			<span class="label">First Name:</span><span class="formw"><input type=text name="firstname" id="firstname" autocomplete="off" onkeyup="showHint()"></span>
			</div>
			
			<div class="row">
			<span class="label">Last Name:</span><span class="formw"><input type=text name="lastname" id="lastname" autocomplete="off" onkeyup="showHint()"></span>
			</div>
		
			<div class="row">
			<span class="label">Offence:</span><span class="formw"><input type=text name="offencename" id="offencename" autocomplete="off" onkeyup="showHint()"></span>
			</div>

			<div class="row">
			<span class="label">Court Name:</span><span class="formw"><input type=text name="courtname" id="courtname" autocomplete="off" onkeyup="showHint()"></span>
			</div>			

			<div class="row">
			<span class="label">Court Date:</span><span class="formw"><input type=text name="courtdate" id="courtdate" autocomplete="off" onkeyup="showHint()"></span>
			</div>

			<div class="row">
			<span class="label">Court Time:</span><span class="formw"><input type=text name="courttime" id="courttime" autocomplete="off" onkeyup="showHint()"></span>
			</div>
			
			<!--<div class="row">
			<span class="label"></span><span class="formw"><INPUT TYPE=SUBMIT value="Search"></span>
			</div>-->
			
			</div>
			
			<br><br>
			
			<div id="cotable"></div>
			
		<!--</form>-->
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
			<p><a href="./logout.asp">Logout</a> | <a href="./courtchangepassword.asp">Settings</a> | <a href="./courtsupport.asp">Support</a></p><p>(C) Super Brilliant Jason. All Rights Reserved.</p>
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
