<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"[]>

<!--#include file="database.asp" -->
<!--#include file="md5.asp"-->

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
	
	
	If Session("Authenticated") = 0 Then
		Session.Timeout=5	
		Session("TimeoutMsg")=1	
		Response.Redirect ("login.asp")	
	End if

		
	Dim rstContent
	Set rstContent = Server.CreateObject("ADODB.RecordSet")	
	
	Dim md5old
	md5old = md5(Request.form("oldpassword"))
	
	checkSQL = "select * from employee where employeeID = " & Session("EmployeeLogID") & " and passwd = '" & md5old & "'"
	
	rstContent.Open checkSQL, nswjlps_STRING
	
	If (rstContent.EOF <> true) Then ' no recs	
		
			Dim md5pass
			md5pass = md5(Request.form("password1"))	
			
			set conn=Server.CreateObject("ADODB.Connection")
			conn.Open nswjlps_STRING
			
			sql="UPDATE employee SET passwd='" & md5pass & "' WHERE employeeID = " & Session("EmployeeLogID")
  						
			'Response.Write sql			
			
			conn.Execute sql		
	
		If (IsNull(rstContent("email"))) Then
			
			'Session.Timeout=5
			'Session("WrongPassword") = 1
			'Response.Redirect("courtchangepassword.asp")
		
		Else
			
			email = rstContent("email")
			
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
			
			myMail.Subject = "NSWJLPS - Changed Password"
			myMail.From = "jasonkwh@gmail.com"
			myMail.To = rstContent("email")
			myMail.TextBody = "Hi " + rstContent("firstName") + "," + Chr(13) +	Chr(13) + "Your password has been changed. Your new password is " + Request.form("password1") +  Chr(13) + Chr(13) + "Regards, " + Chr(13) + "NSWJLPS Administration"
			myMail.Send
			
			set myMail=nothing

			'END OF EMAIL CODE
		
		End If
	
	Else
			Session.Timeout=5	
			Session("WrongPassword") = 1
			Response.Redirect("courtchangepassword.asp")
		
	End If
 
	rstContent.Close()
	Set rstContent = Nothing  
   
   
%>

<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-US" xml:lang="en">
	<head><LINK REL="SHORTCUT ICON" href="images/favicon.ico">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Change Password</title>
    <meta name="description" content="Description" />
    <meta name="keywords" content="Keywords" />
    <link rel="stylesheet" href="style.css" type="text/css" media="screen" />
	
    <script type="text/javascript" src="jquery.js"></script>
    <script type="text/javascript" src="script.js"></script>
	<script type="text/javascript">
    window.history.forward();
    function noBack() { window.history.forward(); }   
	</SCRIPT>
	
	</head>
		<body onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
		<div id="art-page-background-glare">
		<div id="art-page-background-glare-image"> </div>
		</div>
		<div id="art-main">
		<div class="art-sheet">
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
				<a href="./logout.asp" class="active"><span class="l"></span><span class="r"></span><span class="t">Log Out</span></a>
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
			<h2 class="art-postheader">Change Password</h2>
        <div class="cleared"></div>
        <div class="art-postcontent">								
			Your password has been changed. <br>
			<%
				If (IsEmpty(email)) Then
					
				Else				
					Response.write"A confirmation email has been sent to " + email
				End If
			%>
			<br><br>
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
			<p><a href="./logout.asp">Logout</a> | <a href="./courtsupport.asp">Support</a></p><p>(C) Super Brilliant Jason. All Rights Reserved.</p>
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
