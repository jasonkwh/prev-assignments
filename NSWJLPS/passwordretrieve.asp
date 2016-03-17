<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"[]>

<%
	If Session("LoginError") = 1 Then
		errorMessage  = "User does not exist or error filled data"
		Session("LoginError") = 0
	Else if Session("TimeoutMsg") = 1 Then
		errorMessage  = "Time's out, please fill again"
		Session("TimeoutMsg") = 0
	end if
	End if
%>

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
	
	var fn=document.forms["loginForm"]["fname"].value;
	if (fn==null || fn=="")
		{
		alert("First name must be filled out");
		return false;
		}		
	if (fn.length>30)
		{
		alert("First name is too long");
		return false;
		}	
		

	var ln=document.forms["loginForm"]["lname"].value;
	if (ln==null || ln=="")
		{
		alert("Last name must be filled out");
		return false;
		}
	if (ln.length>30)
		{
		alert("Last name is too long");
		return false;
		}	
	
	var filter=/^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i
	var em = document.forms["loginForm"]["email"].value;
	if (em==null || em=="" || !filter.test(em))
		{
		alert("Please Enter a valid Email");
		return false;
		}
	
	var opt = document.forms["loginForm"]["etype"].value;
	if (opt==null || opt=="")
		{
		alert("Please Select an Employee Type");
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
                                <h2 class="art-postheader">Forgot Password?</h2>
                <div class="cleared"></div>
                                <div class="art-postcontent">								
								
								<FORM NAME="loginForm" METHOD=POST ACTION="result.asp" onsubmit="return validateForm()">								
																
								<div class="row">
								<span class="label">Employee ID</span><span class="formw"><input type=text name="employeeID"></span>
								</div>
								
								<div class="row">
								<span class="label">First Name:</span><span class="formw"><input type=text name="fname"></span>
                                </div>
								
								<div class="row">
								<span class="label">Last Name:</span><span class="formw"><input type=text name="lname"></span>
                                </div>
								
                                <div class="row">
								<span class="label">DOB:</span>
								<SELECT name="FirstSelectDay">
								<OPTION selected="selected">1</option>
								<OPTION>2</option>
								<OPTION>3</option>
								<OPTION>4</option>
								<OPTION>5</option>
								<OPTION>6</option>
								<OPTION>7</option>
								<OPTION>8</option>
								<OPTION>9</option>
								<OPTION>10</option>
								<OPTION>11</option>
								<OPTION>12</option>
								<OPTION>13</option>
								<OPTION>14</option>
								<OPTION>15</option>
								<OPTION>16</option>
								<OPTION>17</option>
								<OPTION>18</option>
								<OPTION>19</option>
								<OPTION>20</option>
								<OPTION>21</option>
								<OPTION>22</option>
								<OPTION>23</option>
								<OPTION>24</option>
								<OPTION>25</option>
								<OPTION>26</option>
								<OPTION>27</option>
								<OPTION>28</option>
								<OPTION>29</option>
								<OPTION>30</option>
								<OPTION>31</option>
								</SELECT>
								<select name = "month">
								<option value = "01" selected="selected"> Jan </option>
								<option value = "02"> Feb </option>
								<option value = "03"> Mar </option>
								<option value = "04"> Apr </option>
								<option value = "05"> May </option>
								<option value = "06"> Jun </option>
								<option value = "07"> Jul </option>
								<option value = "08"> Aug </option>
								<option value = "09"> Sep </option>
								<option value = "10"> Oct </option>
								<option value = "11"> Nov </option>
								<option value = "12"> Dec </option>
								</select>
								<input name="FirstSelectYear" type=text value="2012">
                                </div>
                                
								<div class="row">
								<span class="label">Email:</span><span class="formw"><input type=text name="email"></span>
                                </div>
                                                         
                                <div class="row">
								<span class="label">You are a:</span>
								<span class="formw">
								<select name = "etype">
								<option value = "" >Select Employee Type</option>
								<option value = "POLICE"> police </option>
								<option value = "COURT"> court employee </option>
								</select>
								</div>
								
								<br><br>
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
								<span class="label">Answer:</span><span class="formw"><input type=text name="secans"><p>*skip this if you don't have any security question.</p></span>
                                </div>
														
								<br/>
                                <div class="row" style="color:red; padding-left:120px;"><%=errorMessage%></div>
                                <br/>
								
								<div class="row">
								<span class="label" style='padding-left:80px'><INPUT TYPE=SUBMIT value="Submit"></span>
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
