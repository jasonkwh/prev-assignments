<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="database.asp" -->

<!--
    METADATA
    TYPE="typelib"
    UUID="CD000000-8B95-11D1-82DB-00C04FB1625D" 
    NAME="CDO for Windows 2000 Library"
--> 

<%
	
	If Session("Authenticated") = 0 or Session("access") <> 3 Then
		Session.Timeout=5	
		Session("TimeoutMsg")=1	
		Response.Redirect ("login.asp")	
	End if

	set conn=Server.CreateObject("ADODB.Connection")
	conn.Open nswjlps_STRING
	
	courtid = Request.Form("offenceid")
	coday = Request.Form("FirstSelectDay")
	comonth = Request.Form("FirstSelectMonth")
	coyear = Request.Form("FirstSelectYear")
	cotime = Request.Form("time")
	
	codate = CStr(coday) + "/" + comonth + "/" + CStr(coyear)
	
	sql="UPDATE courtorder SET "
	sql=sql & "courttime='" & cotime & "',"
	sql=sql & "courtdate='" & codate & "',"
	sql=sql & "courtstatus='AWAITING VERDICT'"
	sql=sql & " WHERE offenceid=" & courtid
  
	conn.Execute sql

	set conn=Server.CreateObject("ADODB.Connection")
	conn.Open nswjlps_STRING
	
	sqlEmail="SELECT offenderemail FROM offence WHERE id = " & Request.Form("offenceid")

	set rsEmail = Server.CreateObject("ADODB.RecordSet")

	rsEmail.Open sqlEmail, nswjlps_STRING

	If (IsNull(rsEmail("offenderemail")) Or IsEmpty(rsEmail("offenderemail"))) Then
	
		email = "No Email Avaliable"
		'Session.Timeout=5
		'Session("WrongPassword") = 1
		'Response.Redirect("courtchangepassword.asp")
		
	Else
	
		set conn=Server.CreateObject("ADODB.Connection")
		conn.Open nswjlps_STRING
	
		sqlSearch="SELECT offence.id, offence.firstname, offence.lastname, offence.offencename, offence.offenderemail, courtorder.courtname FROM offence, courtorder WHERE offence.id = courtorder.offenceid AND id = " & Request.Form("offenceid")
		
		set rs = Server.CreateObject("ADODB.RecordSet")

		rs.Open sqlSearch, nswjlps_STRING

		email = UCase(rs("offenderemail"))
	
		' EMAIL CODE BELOW
			Set myMail = CreateObject("CDO.Message")
			
			myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
			myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "smtp.gmail.com"
			myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 465
			myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = 1
			myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = true
			myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendusername") = "jasonkwh"
			myMail.Configuration.Fields.Item("http://schemas.microsoft.com/cdo/configuration/sendpassword") = "Meme4eva"
			myMail.Configuration.Fields.Update
			
			myMail.Subject = "NSWJLPS - Court Date"
			myMail.From = "jasonkwh@gmail.com"
			myMail.To = email
			myMail.TextBody = "Hi " + rs("firstName") + "," + Chr(13) + Chr(13) + "The court date and time for your offence: " + rs("offencename") + " has been set." + Chr(13) + Chr(13) + "The court date is " + codate + " at " + cotime + Chr(13) + Chr(13) + "Please be at "+ rs("courtname") + " court at the given date and time " + Chr(13) + Chr(13) + "Regards, " + Chr(13) + "NSWJLPS"
			myMail.Send
			
			set myMail=nothing

		'END OF EMAIL CODE
	
	End If

			

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"[]>
<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-US" xml:lang="en">
<head><LINK REL="SHORTCUT ICON" href="images/favicon.ico">
    <!--
    Created by Artisteer v3.0.0.39952
    Base template (without user's data) checked by http://validator.w3.org : "This page is valid XHTML 1.0 Transitional"
    -->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Court Order Updated</title>
    <meta name="description" content="Description" />
    <meta name="keywords" content="Keywords" />


    <link rel="stylesheet" href="style.css" type="text/css" media="screen" />
    <!--[if IE 6]><link rel="stylesheet" href="style.ie6.css" type="text/css" media="screen" /><![endif]-->
    <!--[if IE 7]><link rel="stylesheet" href="style.ie7.css" type="text/css" media="screen" /><![endif]-->

    <script type="text/javascript" src="jquery.js"></script>
    <script type="text/javascript" src="script.js"></script>
	<script type="text/javascript">
    window.history.forward();
    function noBack() { window.history.forward(); }   
	</SCRIPT>
	
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
		<h2 class="art-postheader">
			Confirmation:
        </h2>
		<div class="cleared"></div>
        <div class="art-postcontent">							
				<p> 
				<b>The following information has been added to the Court Order: </b><br>
				<b>Date:</b> <%= codate %> <br>
				<b>Time:</b> <%= cotime %> <br>
				<b>Status:</b> Awaiting Verdict <br>
				An email has been sent to: <%= email %> <br>
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
