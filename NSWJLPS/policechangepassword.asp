<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"[]>

<!--#include file="database.asp" -->

<%
	If Session("Authenticated") = 0 or Session("access") <> 2 Then
		Session.Timeout=5	
		Session("TimeoutMsg")=1	
		Response.Redirect ("login.asp")	
	End if	
	
	If Session("WrongPassword") = 1	 Then
		errorMessage  = "You entered the wrong current password"
		Session("WrongPassword") = 0
	End if
	
	'check security question
	Dim rstContent
	Set rstContent = Server.CreateObject("ADODB.RecordSet")
	
	selectSQL = "select * from employee where employeeID = " & Session("EmployeeLogID") & ""
	rstContent.Open selectSQL, nswjlps_STRING
	
	Dim checkSecQuiz
	checkSecQuiz = rstContent("SecurityQuiz")
	
	Dim secQuizStatus
	if checkSecQuiz = 0 Then
	secQuizStatus = "*You didn't set up a security question, we strongly RECOMMEND you to set one in order to protect your NSWJLPS account."
	Else
	secQuizStatus = "*You already set up a security question, leave this away if you don't want to make any changes."
	End if
	
%>

<html xmlns="http://www.w3.org/1999/xhtml" dir="ltr" lang="en-US" xml:lang="en">
<head><LINK REL="SHORTCUT ICON" href="images/favicon.ico">
   
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Settings</title>
    <meta name="description" content="Description" />
    <meta name="keywords" content="Keywords" />


    <link rel="stylesheet" href="style.css" type="text/css" media="screen" />

    <script type="text/javascript" src="jquery.js"></script>
    <script type="text/javascript" src="script.js"></script>
	<script type="text/javascript">
function validateForm()
{	
		
	let = /[a-z]/;	
	num = /[0-9]/;
	var illegalChars = /[\W_]/;
	
	var ps1=document.forms["changePassword"]["password1"].value;
	var ps2=document.forms["changePassword"]["password2"].value;
	
	if (ps1 != ps2) 
		{
		alert("Passwords do not match.");
		return false;
		}	
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

window.history.forward();
    function noBack() { window.history.forward(); }  
		
	</script>
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
			<a href="./policesupport.asp"><span class="l"></span><span class="r"></span><span class="t">Support</span></a>
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
                    <h3 class="t">Police</h3>
                </div>
                <div class="art-vmenublockcontent">
                    <div class="art-vmenublockcontent-body">
                <ul class="art-vmenu">
		<li>
		<a href="./policeaddoffence.asp"><span class="l"></span><span class="r"></span><span class="t">Add Offence</span></a>
	</li>	
	<li>
		<a href="./policesearchoffence.asp"><span class="l"></span><span class="r"></span><span class="t">Search/Edit Offence</span></a>
	</li>	
	<li>
		<a href="./policesearchcriminal.asp"><span class="l"></span><span class="r"></span><span class="t">Search/Edit Criminal</span></a>
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
                Change Password
                                </h2>
                <div class="cleared"></div>
                                <div class="art-postcontent">								
								<br>
								
								<FORM NAME="changePassword" METHOD=POST ACTION="policechangepasswordconfirm.asp" onsubmit="return validateForm()">								
										
								<div class="row">
								<span class="label">Current Password:</span><span class="formw"><input type=password name="oldpassword"></span>
								</div>
								
								<div class="row">
								<span class="label">New Password:</span><span class="formw"><input type=password name="password1"></span>
								</div>
								
								<div class="row">
								<span class="label">Confirm New Password:</span><span class="formw"><input type=password name="password2"></span>
								</div>																	
								
								<br><br>
								
								<div class="row" style="color:red"><%=errorMessage%></div>
								
								<br>								
								
								<div class="row">
								<span class="label" style='padding-left:100px'><INPUT TYPE=SUBMIT value="Submit"></span>
								</div>							 								
																
								</form>
                </div>
				<br><br>
				<h2 class="art-postheader">
                Change Security Question
                                </h2>
								<div class="cleared"></div>
                                <div class="art-postcontent">
								<br>
								<FORM NAME="changeSecurity" METHOD=POST ACTION="policechangesecconfirm.asp">
								<div class="row">
								<span class="label">Security Question:</span>
								<span class="formw">
								<select name = "secquiz">
								<option value = "0" >Select Questions</option>
								<option value = "1">Who was your childhood hero?</option>
								<option value = "2">To what city did you go on your honeymoon?</option>
								<option value = "3">What was the name of your first stuffed animal?</option>
								<option value = "4">In what city or town did your mother and father meet?</option>
								<option value = "5">What year did you graduate from High School?</option>
								<option value = "6">What is the name of your favorite childhood friend?</option>
								<option value = "7">What was the name of your elementary / primary school?</option>
								<option value = "8">What was the make and model of your first car?</option>
								<option value = "9">In what city or town was your first job?</option>
								</select>
								</div>
								
								<div class="row">
								<span class="label">Answer:</span><span class="formw"><input type=text name="secans"><p><%=secQuizStatus%></p></span>
                                </div>
								
								<br><br>
								<div class="row">
								<span class="label" style='padding-left:100px'><INPUT TYPE=SUBMIT value="Submit"></span>
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
			<p><a href="./logout.asp">Logout</a> | <a href="./policesupport.asp">Support</a></p><p>(C) Super Brilliant Jason. All Rights Reserved.</p>
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
