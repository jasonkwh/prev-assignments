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
    <title> Assign Court Order </title>
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

	function showOffence(str)
	{
		var xmlhttp;
		xmlhttp=new XMLHttpRequest();
		if (str=="")
		{
			document.getElementById("txtHint").innerHTML="";
			return;
		}
		
		xmlhttp.onreadystatechange=function()
		{
			if (xmlhttp.readyState==4 && xmlhttp.status==200)
			{
				document.getElementById("txtHint").innerHTML=xmlhttp.responseText;
			}
		}

		xmlhttp.open("GET","courtgetoffence.asp?q="+str,true);
		xmlhttp.send();
	}
	
	function validateForm()
	{
		var offenceid = document.forms["addcodate"]["offenceid"].value;
		if (offenceid == null || offenceid == "")
		{
			alert("You must select an Offender");
			return false;
		}
		var cotime = document.forms["addcodate"]["time"].value;
		if (cotime == null || cotime == "")
		{
			alert("You must enter a time");
			return false;
		}
		
		var oday=document.forms["addcodate"]["FirstSelectDay"].value;
		var omonth=document.forms["addcodate"]["FirstSelectMonth"].value;
		var oyear=document.forms["addcodate"]["FirstSelectYear"].value;
	
		var odate = oday+" "+ omonth+ " " + oyear;
		var dt = Date.parse(odate);
		
		var currentDate = new Date();
		var ct = Date.parse(currentDate);
	
		if (dt < ct)
		{
		alert("The offence date cannot be in the past.");
		return false;
		}	
	}
	
	//set todays date
	Now = new Date();
	NowDay = Now.getDate();
	NowMonth = Now.getMonth();
	NowYear = Now.getYear();
	if (NowYear < 2000) NowYear += 1900; //for Netscape

	//function for returning how many days there are in a month including leap years
	function DaysInMonth(WhichMonth, WhichYear)
	{
		var DaysInMonth = 31;
		if (WhichMonth == "Apr" || WhichMonth == "Jun" || WhichMonth == "Sep" || WhichMonth == "Nov") DaysInMonth = 30;
		if (WhichMonth == "Feb" && (WhichYear/4) != Math.floor(WhichYear/4))	DaysInMonth = 28;
		if (WhichMonth == "Feb" && (WhichYear/4) == Math.floor(WhichYear/4))	DaysInMonth = 29;
		return DaysInMonth;
	}

	//function to change the available days in a months
	function ChangeOptionDays(Which)
	{
		DaysObject = eval("document.addcodate." + Which + "Day");
		MonthObject = eval("document.addcodate." + Which + "Month");
		YearObject = eval("document.addcodate." + Which + "Year");

		Month = MonthObject[MonthObject.selectedIndex].text;
		Year = YearObject[YearObject.selectedIndex].text;

		DaysForThisSelection = DaysInMonth(Month, Year);
		CurrentDaysInSelection = DaysObject.length;
		if (CurrentDaysInSelection > DaysForThisSelection)
		{
			for (i=0; i<(CurrentDaysInSelection-DaysForThisSelection); i++)
			{
				DaysObject.options[DaysObject.options.length - 1] = null
			}
		}
		if (DaysForThisSelection > CurrentDaysInSelection)
		{
			for (i=0; i<(DaysForThisSelection-CurrentDaysInSelection); i++)
			{
				NewOption = new Option(DaysObject.options.length + 1);
				DaysObject.add(NewOption);
			}
		}
		if (DaysObject.selectedIndex < 0) DaysObject.selectedIndex == 0;
	}

	//function to set options to today
	function SetToToday(Which)
	{
		DaysObject = eval("document.addcodate." + Which + "Day");
		MonthObject = eval("document.addcodate." + Which + "Month");
		YearObject = eval("document.addcodate." + Which + "Year");

		YearObject[0].selected = true;
		MonthObject[NowMonth].selected = true;

		ChangeOptionDays(Which);

		DaysObject[NowDay-1].selected = true;
	}

	//function to write option years plus x
	function WriteYearOptions(YearsAhead)
	{
		line = "";
		for (i=0; i<YearsAhead; i++)
		{
			line += "<OPTION>";
			line += NowYear + i;
		}
		return line;
	}
	//  End -->
	</script>
	
	</script>
	</head>
		<body onLoad="SetToToday('FirstSelect');" onload = "noBack();" onpageshow = "if (event.persisted)noBack();" onunload="">
		<div id="art-page-background-glare">
		<div id="art-page-background-glare-image"> 
		</div>
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
        <div class="art-header-jpeg">
		</div>
        </div>
        </div>
        <div class="art-logo">
            <h1 class="art-logo-name"></h1>
            <h2 class="art-logo-text"></h2>
        </div>
        </div>
        <div class="cleared reset-box">
		</div>
		<div class="art-nav">
		<div class="art-nav-l">
		</div>
		<div class="art-nav-r">
		</div>
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
			<h2 class="art-postheader"> Assign Court Order </h2>
        <div class="cleared"></div>
        <div class="art-postcontent">
		
		<p><b> The following offences need a court date and time: </b></p>
				
		<FORM NAME="addcodate" METHOD=POST ACTION="courtupdateco.asp" onsubmit="return validateForm()">

			<select name="offenceid" onchange="showOffence(this.value)">
			<option value = "" >Select Offender</option>
		
			<% 
		
				Dim rstContent
				Set rstContent = Server.CreateObject("ADODB.RecordSet")	
	
				checkSQL = "SELECT id, firstname, lastname, offencename FROM offence INNER JOIN courtorder ON offence.id=courtorder.offenceid WHERE courtorder.courtdate IS NULL OR courtorder.courttime IS NULL"
	
				rstContent.Open checkSQL, nswjlps_STRING
	
				Do Until rstContent.EOF	
					fname = rstContent("firstname")
					lname = rstContent("lastname")
					id = rstContent("id")
					oname = rstContent("offencename")
					Response.write "<option value = '" &  id & "'>" & fname & " " & lname & " - " & oname & " </option>"
					rstContent.movenext
				Loop
			%>
		
			</select>
		
			<div id = "txtHint"></div>
			
			<p> Court Date: 
			<SELECT name="FirstSelectDay">
				<OPTION>1</option>
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
			<SELECT name="FirstSelectMonth" onchange="ChangeOptionDays('FirstSelect')">
				<option value = "01"> Jan </option>
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
			</SELECT>
			<SELECT name="FirstSelectYear" onchange="ChangeOptionDays('FirstSelect')">
				<SCRIPT language="JavaScript">
					document.write(WriteYearOptions(3));
				</SCRIPT>
			</SELECT></p>
			
			<p> Time: <select name="time">
			<option value = "" >Select Time</option>
			<option>8:30 AM</option>
			<option>9:00 AM</option>
			<option>9:30 AM</option>
			<option>10:00 AM</option>
			<option>10:30 AM</option>
			<option>11:00 AM</option>
			<option>11:30 AM</option>
			<option>12:00 PM</option>
			<option>12:30 PM</option>
			<option>1:00 PM</option>
			<option>1:30 PM</option>
			<option>2:00 PM</option>
			<option>2:30 PM</option>
			<option>3:00 PM</option>
			<option>3:30 PM</option>
			<option>4:00 PM</option>
			<option>4:30 PM</option>
			<option>5:00 PM</option>
			<option>5:30 PM</option>
		
			</select></p>
			
			<div class="row">
			<span class="label"></span><span class="formw"><INPUT TYPE=SUBMIT value="Save"></span>
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
