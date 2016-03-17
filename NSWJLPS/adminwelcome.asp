<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"[]>

<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="database.asp" -->

<!--
    METADATA
    TYPE="typelib"
    UUID="CD000000-8B95-11D1-82DB-00C04FB1625D" 
    NAME="CDO for Windows 2000 Library"
--> 

<%
	
	If Session("Authenticated") = 0 or Session("access") <> 1 Then
		Session.Timeout=5	
		Session("TimeoutMsg")=1	
		Response.Redirect ("login.asp")	
	End if
	
	Dim rstContent
	Set rstContent = Server.CreateObject("ADODB.RecordSet")	
	
	checkSQL = "select * from employee where employeeID = " & Session("EmployeeLogID") & ""
	
	rstContent.Open checkSQL, nswjlps_STRING
	
	first = UCase(rstContent("firstName"))
	welProtect = rstContent("ActiveWelcome")
	email = rstContent("email")
	
	Dim welStatus, welStatusC
	
	If welProtect = -1 Then
		welStatus = "ACTIVATED"
		welStatusC = "DEACTIVATE"
		
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
			
		myMail.Subject = "NSWJLPS - Login Protection"
		myMail.From = "jasonkwh@gmail.com"
		myMail.To = email
		myMail.TextBody = "Hi " + first + "," + Chr(13) +	Chr(13) + "You were logged in to NSW Justice Link Police System at " & Day(now()) & "/" & Month(now()) & "/" & Year(now()) & " " & Time & ". Please contact us if you did not do this action." +  Chr(13) + Chr(13) + "Regards, " + Chr(13) + "NSWJLPS Administration"	
		myMail.Send
			
		set myMail=nothing

		'END OF EMAIL CODE
			
	Else
		welStatus = "DEACTIVATED"
		welStatusC = "ACTIVATE"
	End if
	
	
	rstContent.Close()
	Set rstContent = Nothing
%>

<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-US" xml:lang="en">
<head><LINK REL="SHORTCUT ICON" href="images/favicon.ico">
    <!--
    Created by Artisteer v3.0.0.39952
    Base template (without user's data) checked by http://validator.w3.org : "This page is valid XHTML 1.0 Transitional"
    -->
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Welcome</title>
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
<BODY onload="noBack();" onpageshow="if (event.persisted) noBack();" onunload="">
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
						<h1 class="art-logo-name"><a href=""></a></h1>
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
				<a href="./adminchangepassword.asp" class="active"><span class="l"></span><span class="r"></span><span class="t">Change Password</span></a>
			</li>
            	<li>
			<a href="./adminsupport.asp"><span class="l"></span><span class="r"></span><span class="t">Support</span></a>
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
                    <h3 class="t">Administrator</h3>
                </div>
                <div class="art-vmenublockcontent">
                    <div class="art-vmenublockcontent-body">
                <ul class="art-vmenu">
	<li>
		<a href="./adminregisteruser.asp"><span class="l"></span><span class="r"></span><span class="t">Add User</span></a>
	</li>
	<li>
		<a href="./adminsearchuser.asp"><span class="l"></span><span class="r"></span><span class="t">Manage Employees</span></a>
	</li>	
	<li>
		<a href="./adminaddoffence.asp"><span class="l"></span><span class="r"></span><span class="t">Add Offence Type</span></a>
	</li>
	<li>
		<a href="./adminsearchoffence.asp"><span class="l"></span><span class="r"></span><span class="t">Manage Offence Type</span></a>
	</li>
    	<li>
		<a href="./adminresetpassword.asp"><span class="l"></span><span class="r"></span><span class="t">Reset User Password</span></a>
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
                Welcome!
                                </h2>
                <div class="cleared"></div>
                                <div class="art-postcontent">
								
                                <p>Hi, <b><%=first%></b>! Welcome to NSW Justice Link Police System!</p>
                                <p>If you need any help, please click "Support" and contact us.</p>
								<br/>
								<br/>
								<p>Notice that you have <b style="color:red;"><%=welStatus%></b> login protection (we will send a email to prompt you for each login if activated). Of course you can just click the button below to activate or deactivate this feature.</p>
								<FORM NAME="resetPassword" METHOD=POST ACTION="adminwelcomeconfirm.asp">	
								<div class="row">
								<span class="label"></span><span class="formw"><INPUT TYPE=SUBMIT value=<%=welStatusC%>></span>
								</div>
								</FORM>
								
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
        <div class="cleared"></div>
        <div class="art-footer">
        <div class="art-footer-t"></div>
        <div class="art-footer-l"></div>
        <div class="art-footer-b"></div>
        <div class="art-footer-r"></div>
        <div class="art-footer-body">
        <div class="art-footer-text">
			<p><a href="./logout.asp">Logout</a> | <a href="./adminchangepassword.asp">Change Password</a> | <a href="./adminsupport.asp">Support</a></p><p>(C) Super Brilliant Jason. All Rights Reserved.</p>
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
