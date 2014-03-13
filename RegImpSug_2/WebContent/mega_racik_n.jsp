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



String date1 = "";
if(request.getParameter("date1")!=null){
	date1 = new String(request.getParameter("date1").getBytes("ISO-8859-1"));
	date1 = URLDecoder.decode(date1, "windows-1251");
};
String date2 = "";
if(request.getParameter("date2")!=null){
	date2 = new String(request.getParameter("date2").getBytes("ISO-8859-1"));
	date2 = URLDecoder.decode(date2, "windows-1251");
};



fio="Мешкова Ирина Евгеньевна";
date1="01.01.2013";
date2="01.01.2014";



System.out.println(fio);
System.out.println(date1);
System.out.println(date2);

RequestSQL requestSQL = new RequestSQL();

%>


<center>
	<h3>
		Данные по рационализации
		<br>
		работников ГСКБ за период (<%=date1 %>-<%=date2%>)
		
	</h3>
</center>





Подано -  <%=RequestSQL.notNULL(requestSQL.getSuggestionCount(date1,date2),"")%> рац. предложений
<br>
Внедрено – <%=RequestSQL.notNULL(requestSQL.getSuggestionIntoCount(date1,date2),"")%> рац. предложений
<br>
Экономический эффект –  <%=RequestSQL.notNULL(requestSQL.getSuggestionSumEconomy(date1,date2),"")%> тыс. руб.
<br>
<br>


bestInnovator
<table class='t-rp'>
<thead>
	<tr>
		<th>№</th>
		<th>Ф.И.О.</th>
		<th>Подано р/пр.</th>
		<th>Внедрено р/пр.</th>
		<th>Экономический эффект, тыс. руб.</th>
	</tr>
</thead>
<tbody>


<% 
requestSQL.selectBestInnovator(date1,date2);
while(requestSQL.rs.next()){ 
%>

	<tr>
		
		<th><%=RequestSQL.notNULL(requestSQL.rs.getString(1),"")%></th>		
		<th><%=RequestSQL.notNULL(requestSQL.rs.getString(2),"")%></th>
		<th><%=RequestSQL.notNULL(requestSQL.rs.getString(3),"")%></th>
		<th><%=RequestSQL.notNULL(requestSQL.rs.getString(4),"")%></th>
		<th><%=RequestSQL.notNULL(requestSQL.rs.getString(5),"")%></th>
	</tr>


<%
}
%>
</tbody>
</table>

<br><br>
Рац.орг. ОАО «НТЦК»____________________________________<%=requestSQL.getRacorgNameByLogin(racorg)%>







<br><br><br>






kolichestvo

<center>
	<h3>
		Данные по рационализации
		<br>
		работников ГСКБ за период (июнь 2012-май 2013гг.)
		<br>
		работников ГСКБ за период (<%=date1 %>-<%=date2%>)
	</h3>
</center>

<table class='t-rp'>
<thead>
	<tr>
		<th>№</th>
		<th>Ф.И.О.</th>
		<th>Поданные р/пр.(по людям)</th>
		<th>Внедрено р/пр. (по людям)</th>
		<th>Экономический эффект, тыс. руб.</th>
	</tr>
</thead>
<tbody>
	<% 
	requestSQL.selectAll(fio);
	while(requestSQL.rs.next()){ 
	%>
		<tr>			
			<th><%=RequestSQL.notNULL(requestSQL.rs.getString(1),"")%></th>		
			<th><%=RequestSQL.notNULL(requestSQL.rs.getString(2),"")%></th>
			<th><%=RequestSQL.notNULL(requestSQL.rs.getString(3),"")%></th>
			<th><%=RequestSQL.notNULL(requestSQL.rs.getString(4),"")%></th>
			<th><%=RequestSQL.notNULL(requestSQL.rs.getString(5),"")%></th>
		</tr>
	<%
	}
	%>
</tbody>
</table>

<br><br>
Рац.орг. ОАО «НТЦК»____________________________________<%=requestSQL.getRacorgNameByLogin(racorg)%>
<br><br>

 






	<h3>
		Данные по рационализации
		<br>
		работников ГСКБ за период (июнь 2012-май 2013гг.)
		<br>
		работников ГСКБ за период (<%=date1 %>-<%=date2%>)
	</h3>


<table class='t-rp'>
<thead>
	<tr>
		<th>№</th>
		<th>Ф.И.О.</th>
		<th>Поданные р/пр.(по людям)</th>
		<th>Внедрено р/пр. (по людям)</th>
		<th>Экономический эффект, тыс. руб.</th>
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
				<th><%=RequestSQL.notNULL(reqUser.rs.getString(3),"")%></th>
				<th><%=RequestSQL.notNULL(reqUser.rs.getString(4),"")%></th>
				<th><%=RequestSQL.notNULL(reqUser.rs.getString(5),"")%></th>
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
Рац.орг. ОАО «НТЦК»____________________________________<%=reqUser.getRacorgNameByLogin(racorg)%>
<br><br>













eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee

	<h3>
		Данные по рационализации
		<br>
		работников ГСКБ за период (июнь 2012-май 2013гг.)
		<br>
		работников ГСКБ за период (<%=date1 %>-<%=date2%>)
	</h3>


<table class='t-rp'>
<thead>
	<tr>
		<th>№</th>
		<th>Ф.И.О.</th>
		<th>Поданные р/пр.(по людям)</th>
		<th>Внедрено р/пр. (по людям)</th>
		<th>Экономический эффект, тыс. руб.</th>
		<th>6</th>
		<th>7</th>
		<th>8</th>
		<th>9</th>
		<th>10</th>
		
	</tr>
</thead> 
<tbody>
	<% 
	RequestSQL stat = new RequestSQL();
    stat.selStat(date1, date2);
	while(stat.rs.next()){ 
	%>
		<tr>					
				<th><%=RequestSQL.notNULL(stat.rs.getString(1),"")%></th>		
				<th><%=RequestSQL.notNULL(stat.rs.getString(2),"")%></th>
				<th><%=RequestSQL.notNULL(stat.rs.getString(3),"")%></th>
				<th><%=RequestSQL.notNULL(stat.rs.getString(4),"")%></th>
				<th><%=RequestSQL.notNULL(stat.rs.getString(5),"")%></th>
				<th><%=RequestSQL.notNULL(stat.rs.getString(6),"")%></th>
				<th><%=RequestSQL.notNULL(stat.rs.getString(7),"")%></th>
				<th><%=RequestSQL.notNULL(stat.rs.getString(8),"")%></th>
				<th><%=RequestSQL.notNULL(stat.rs.getString(9),"")%></th>
				<th><%=RequestSQL.notNULL(stat.rs.getString(10),"")%></th>
				
		</tr>
				
	<%
	}
	%>
</tbody>
</table>

<br><br>
Рац.орг. ОАО «НТЦК»____________________________________<%=stat.getRacorgNameByLogin(racorg)%>
<br><br>



//////////////////////////////////////////////////////////
<h3>
		Данные по рационализации
		<br>
		работников ГСКБ за период (июнь 2012-май 2013гг.)
		<br>
		работников ГСКБ за период (<%=date1 %>-<%=date2%>)
	</h3>

0000000
<table class='t-rp'>
<thead>
	<tr>
		<th>№</th>
		<th>Ф.И.О.</th>
		<th>Поданные р/пр.(по людям)</th>
		<th>Внедрено р/пр. (по людям)</th>
		<th>Экономический эффект, тыс. руб.</th>
	</tr>
</thead>
<tbody>
	<% 

	RequestSQL reD = new RequestSQL();
	RequestSQL reqU = new RequestSQL();
	reD.getAllDepartment();
 
	while(reD.rs.next()){ 
	%>
		<tr>			
			<th colspan=5 class="field-dep-nach"><%=reD.rs.getString("department")%> (<%=reD.rs.getString("department_chief")%>) </th>			
		</tr>	
			<%		
			
			reqU.getRacikUserByDepartment1(reD.rs.getString("DEPARTMENT_CODE"));
			while(reqU.rs.next()){ 
			%>
		<tr>			
				<th><%=RequestSQL.notNULL(reqU.rs.getString(1),"")%></th>		
				<th><%=RequestSQL.notNULL(reqU.rs.getString(2),"")%></th>
				<th><%=RequestSQL.notNULL(reqU.rs.getString(3),"")%></th>
				<th><%=RequestSQL.notNULL(reqU.rs.getString(4),"")%></th>
				<th><%=RequestSQL.notNULL(reqU.rs.getString(5),"")%></th>
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
Рац.орг. ОАО «НТЦК»____________________________________<%=reqU.getRacorgNameByLogin(racorg)%>
<br><br>






















</body>
</html>