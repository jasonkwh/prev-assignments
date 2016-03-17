<!-- COMP344 Assignment 1, 2011 Paul Carswell 41494792 -->


<%@LANGUAGE="VBSCRIPT" CODEPAGE="1252"%>
<!--#include file="database.asp" -->
<!--#include file="md5.asp" -->
<!--#include file="functions.asp" -->


<%
Dim rstContent
Set rstContent = Server.CreateObject("ADODB.RecordSet")	

Dim md5pass
md5pass = md5(Request.Form("password1"))
		
checkLogin = "select * from Employee where employeeID = " & Request.Form("employeeID") & " AND passwd = '" & md5pass & "';"
	
rstContent.Open checkLogin, nswjlps_STRING
	
If rstContent.EOF Then ' no recs
	Session.Timeout=5	
	Session("Authenticated") = 0	
	Session("LoginError")=1	
	Response.Redirect ("login.asp")	
Else
	If rstContent("activeService") <> true Then
		Session.Timeout=5	
		Session("Authenticated") = 0
		Session("ActiveService") = 1					
		Response.Redirect ("login.asp")	
	End if
End IF
	
			
	Session("Authenticated") = 1
	Session("EmployeeLogID") = rstContent("employeeID")
	
	Dim sessionid, usern
	sessionid = RandomString()
	usern = Request.Form("employeeID")
	
	Session("username") = usern
	Session("sessionid") = sessionid
	
	
	If rstContent("employeeType") = "ADMIN" Then
		Session("access") = 1
		Response.Redirect ("adminwelcome.asp")	
		
	End if
	
	If rstContent("employeeType") = "POLICE" Then
		Session("access") = 2
		Response.Redirect ("policewelcome.asp")	
	End if
	
	If rstContent("employeeType") = "COURT" Then
		Session("access") = 3
		Response.Redirect ("courtwelcome.asp")	
	End If  
	
%>