<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"[]>

<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-US" xml:lang="en">
<head><LINK REL="SHORTCUT ICON" href="images/favicon.ico">
   <LINK REL="SHORTCUT ICON" href="images/favicon.ico">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Password Retrieve</title>
    <meta name="description" content="Description" />
    <meta name="keywords" content="Keywords" />


    <link rel="stylesheet" href="style.css" type="text/css" media="screen" />
	
	<script type="text/javascript" src="jquery.js"></script>
    <script type="text/javascript" src="script.js"></script>
 
</head>
<body>
<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="database.asp" -->
<!--#include file="md5.asp"-->
<!--#include file="functions.asp"-->

<!--
    METADATA
    TYPE="typelib"
    UUID="CD000000-8B95-11D1-82DB-00C04FB1625D" 
    NAME="CDO for Windows 2000 Library"
--> 

<%
Dim rstContent
Set rstContent = Server.CreateObject("ADODB.RecordSet")	

Dim eID
eID = Request.Form("employeeID")

Dim employeeFname
employeeFname = Request.Form("fname")

Dim employeeLname
employeeLname = Request.Form("lname")

Dim employeeMail
employeeMail = Request.Form("email")

Dim employeeT
employeeT = Request.Form("etype")

Dim dateob
dateob = Request.Form("FirstSelectDay") + "/" + Request.Form("month") + "/" + Request.Form("FirstSelectYear")

Dim securQuiz
securQuiz = Request.Form("secquiz")

Dim securAns
If securQuiz = 0 Then
checkSQL = "SELECT passwd FROM Employee where employeeID LIKE '" & eID & "' AND firstName LIKE '" & employeeFname & "' AND lastName LIKE '" & employeeLname & "' AND DOB LIKE '" & dateob & "' AND employeeType LIKE '" & employeeT & "' AND email LIKE '" & employeeMail & "' AND securityQuiz LIKE '" & securQuiz & "';"
Else
securAns = Request.Form("secans")
checkSQL = "SELECT passwd FROM Employee where employeeID LIKE '" & eID & "' AND firstName LIKE '" & employeeFname & "' AND lastName LIKE '" & employeeLname & "' AND DOB LIKE '" & dateob & "' AND employeeType LIKE '" & employeeT & "' AND email LIKE '" & employeeMail & "' AND securityQuiz LIKE '" & securQuiz & "' AND securityAns LIKE '" & securAns & "';"
End If

rstContent.Open checkSQL, nswjlps_STRING

If rstContent.EOF Then ' no recs
	Session.Timeout=5	
	Session("LoginError")=1	
	Response.Redirect ("passwordretrieve.asp")	
Else
	first = UCase(employeeFname)
	last = UCase(employeeLname)
	email = employeeMail
	randomPass = RandomString()
Dim md5pass
md5pass = md5(randomPass)	
	set conn=Server.CreateObject("ADODB.Connection")
	conn.Open nswjlps_STRING	
    
	sql="UPDATE employee SET passwd='" & md5pass & "' WHERE employeeID =" & Request.Form("employeeID")
  			
	conn.Execute sql
	
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
			
			myMail.Subject = "NSWJLPS - Reset Password"
			myMail.From = "jasonkwh@gmail.com"
			myMail.To = email
			myMail.TextBody = "Hi " + first + "," + Chr(13) +	Chr(13) + "Your password has been reset. Your new password is " + randomPass +  Chr(13) + Chr(13) + "Regards, " + Chr(13) + "NSWJLPS Administration"	
			myMail.Send
			
			set myMail=nothing

			'END OF EMAIL CODE
		
		End If
		
		rstContent.Close()
	Set rstContent = Nothing  
%>
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
    <a href="./index.asp"><span class="l"></span><span class="r"></span><span class="t">Home</span></a>
    </li>
		<li>
			<a href="./support.asp"><span class="l"></span><span class="r"></span><span class="t">Support</span></a>
		</li>
        <li>
        <a href="./login.asp"><span class="l"></span><span class="r"></span><span class="t">Log In</span></a>
        </li>
	</ul>
</div>
</div>
<div class="cleared reset-box"></div>
<div class="art-content-layout">
                <div class="art-content-layout-row">
                    <div class="art-layout-cell art-sidebar1">


                      <div class="cleared"></div>
                    </div>
                    <div class="art-layout-cell art-content">
<div class="art-post">
    <div class="art-post-body">
<div class="art-post-inner art-article">
                                <h2 class="art-postheader">
                Password has been reset
                                </h2>
                <div class="cleared"></div>
                                <div class="art-postcontent">								
								
                                <%=first%>&nbsp<%=last%>'s  password has been reset. 
								
								<%
								If (IsEmpty(email)) Then
								Else				
									Response.write"An email with the new password has been sent to " + email
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
			<p><a href="./index.asp">Home</a> | <a href="./support.asp">Support</a> | <a href="./login.asp">Login</a></p><p>(C) Super Brilliant Jason. All Rights Reserved.</p>
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
