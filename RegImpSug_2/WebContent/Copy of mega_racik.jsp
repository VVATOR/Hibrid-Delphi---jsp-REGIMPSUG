<%@page import="java.net.URLDecoder"%>
<%@page import="vva.oracle.OracleConnect"%>
<%@page import="vva.oracle.RequestSQL"%>
<%@ page language="java" contentType="text/html; charset=windows-1251"
    pageEncoding="windows-1251"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
<title>Отчет</title>

<style> 
	.t-rp thead tr th{
		border-collapse: collapse;
		border: 1px solid black; 	
	}
	.t-rp tbody tr th{
		border-collapse: collapse;
		border: 1px solid black; 	
	}
</style>
	
<style>
table{
border-collapse: collapse;}


	.field-dep-nach{
		color:green
	}
	
	
	
	
	
	
	
</style>
</head>
<body>  
<%

String racorg=System.getProperty("user.name");
String fio = "";
if(request.getParameter("fio")!=null){
	fio = new String(request.getParameter("fio").getBytes("ISO-8859-1"));
	fio = URLDecoder.decode(fio, "windows-1251");
};



String Date1 = "";
if(request.getParameter("Date1")!=null){
	Date1 = new String(request.getParameter("Date1").getBytes("ISO-8859-1"));
	Date1 = URLDecoder.decode(Date1, "windows-1251");
};
String Date2 = "";
if(request.getParameter("Date2")!=null){
	Date2 = new String(request.getParameter("Date2").getBytes("ISO-8859-1"));
	Date2 = URLDecoder.decode(Date2, "windows-1251");
};



fio="Мешкова Ирина Евгеньевна";
Date1="01.01.2013";
Date2="01.01.2014";


System.out.println(fio);
System.out.println(Date1);
System.out.println(Date2);





RequestSQL requestSQL = new RequestSQL();
requestSQL.selectCartochka(fio);
 
%>

<center>
	<h3>
		Список работников по отделам		
	</h3>
</center>

<div  style="width: 24px; height: 24px; background-color: green; float:left;"></div> - отдел (начальник)

<br><br><br>
<table class='t-rp'>
<thead>
	<tr>
		<th>login</th>
		<th>Ф.И.О.</th>
		<th>Фамилия</th>
		<th>Имя</th>
		<th>отчество.</th>
	</tr>
</thead>
<tbody>
	<% 

	RequestSQL reqDep = new RequestSQL();
	RequestSQL reqUser = new RequestSQL();
	reqDep.getAllDepartment();
 
	while(reqDep.rs.next()){ 
	%>
		<tr>			
			<th colspan=5 class="field-dep-nach"><%=reqDep.rs.getString("department")%> (<%=reqDep.rs.getString("department_chief")%>) </th>			
		</tr>	
			<%		
			
			reqUser.getRacikUserByDepartment(reqDep.rs.getString("department"));
			while(reqUser.rs.next()){ 
			%>
		<tr>			
				<th><%=RequestSQL.notNULL(reqUser.rs.getString(1),"")%></th>		
				<th><%=RequestSQL.notNULL(reqUser.rs.getString(2),"")%></th>
				<th><%=RequestSQL.notNULL(reqUser.rs.getString(5),"")%></th>
				<th><%=RequestSQL.notNULL(reqUser.rs.getString(3),"")%></th>
				<th><%=RequestSQL.notNULL(reqUser.rs.getString(4),"")%></th>
		</tr>
			<%
			}
			%>		
	<%
	}
	%>
</tbody>
</table>

<br><br>






</body>
</html>