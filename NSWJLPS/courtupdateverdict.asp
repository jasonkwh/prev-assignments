<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"[]>

<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>

<!--#include file="database.asp" -->

<%
	
	If Session("Authenticated") = 0 or Session("access") <> 3 Then
		Session.Timeout=5	
		Session("TimeoutMsg")=1	
		Response.Redirect ("login.asp")	
	End if
		

	set conn=Server.CreateObject("ADODB.Connection")
	conn.Open nswjlps_STRING
	
	courtid = Request.Form("courtid")
	verdict = UCase(Request.Form("verdict"))
	sentence = UCase(Request.Form("sentence"))
	
	sql="UPDATE courtorder SET "
	sql=sql & "verdict='" & verdict & "',"
	sql=sql & "sentence='" & sentence & "',"
	sql=sql & "courtstatus='VERDICT DECIDED'"
	sql=sql & " WHERE offenceid=" & courtid
  
	conn.Execute sql
	
	
	If verdict = "GUILTY" Then
		
		Dim rs
		Set rs = Server.CreateObject("ADODB.RecordSet")		
		getMaxID = "select max(ID) as maxid from criminal;"	
		rs.Open getMaxID, nswjlps_STRING
	
		Dim maxid	
		maxid = CLng(rs("maxid"))+1
		rs.Close()
		Set rs = Nothing
	
		set rstContent=Server.CreateObject("ADODB.RecordSet")
	
		sqlSearch = "SELECT firstname, lastname, offenderaddress, offendersuburb, offenderpostcode, offenderstate, DOB, offenderphone  FROM offence WHERE id = " & courtid
	
		rstContent.Open sqlSearch, nswjlps_STRING
	
		fname = rstContent("firstname")	
		lname = rstContent("lastname")
		oaddress = rstContent("offenderaddress")
		osuburb = rstContent("offendersuburb")
		opostcode = rstContent("offenderpostcode")
		ostate = rstContent("offenderstate")
		dob = rstContent("DOB")
		ophone = rstContent("offenderphone")
	
		set objConn = Server.CreateObject("ADODB.Connection")
		objConn.Open nswjlps_STRING

		criminalSQL = "INSERT INTO Criminal (id, firstname, lastname, streetaddress, suburb, postcode, state, phonenumber, dob) " _
		& "VALUES (" & maxid & ", '" & fname & "', '" & lname & "', '" & oaddress & "', '" & osuburb & "', " & opostcode & ", '" & ostate & "', '" & ophone & "', " & dob & ");"
				
		objConn.Execute criminalSQL
		
	End if

%>

<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-US" xml:lang="en">
<head><LINK REL="SHORTCUT ICON" href="images/favicon.ico">
    <!--
    Created by Artisteer v3.0.0.39952
    Base template (without user's data) checked by http://validator.w3.org : "This page is valid XHTML 1.0 Transitional"
    -->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Verdict Updated</title>
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
            <h1 class="art-logo-name"><</h1>
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
			<h2 class="art-postheader">Confirmation:</h2>
		<div class="cleared"></div>
        <div class="art-postcontent">							
				<p> 
				<b>The following information has been added to the Court Order: </b><br>
				<b>Offence ID:</b> <%= courtid %> <br>
				<b>Verdict:</b> <%= verdict %> <br>
				<b>Sentence:</b> <%= sentence %> <br>
				<b>Status:</b> Verdict Decided <br>		
			</p>						
		</div>						
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
