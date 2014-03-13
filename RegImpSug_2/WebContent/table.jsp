<%@page import="vva.oracle.RequestSQL"%>
<%@ page language="java" contentType="text/html; charset=windows-1251"
    pageEncoding="windows-1251"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
<title>Insert title here</title>
<style>
	table thead tr th{
		background-color: #E6E6FA;
	}

	tr:hover{
		background-color: #FAFAD2; 
	}
span {
color:red;
}

</style>

</head>
<body>


<table>
<thead>
	<tr>
		<th>№</th>		
		<th>Номер рац. предложения</th>		
		<th>Дата регистрации на заводе</th>		
		<th>Дата регистрации в ГСКБ</th>		
		<th>Краткое содержание</th>		
		<th>Предприятие</th>		
		<th>Авторы</th>		
		<th>Узел</th>		
		<th>Статус</th>
		<th>ид</th>		
		<th>p_status</th>		
		<th>Ном. извещения</th>						
	</tr>
</thead>
<tbody>

<%
RequestSQL req = new RequestSQL();
req.getMainTableSuggestion();
while(req.rs.next()){
%>	
<tr>
	<th><%=RequestSQL.notNULL(req.rs.getString(1),"") %></th>
	<th><%=RequestSQL.notNULL(req.rs.getString(2),"") %></th>
	<th><%=RequestSQL.notNULL(req.rs.getString(3),"") %></th>
	<th><%=RequestSQL.notNULL(req.rs.getString(4),"") %></th>
	<th><%=RequestSQL.notNULL(req.rs.getString(5),"") %></th>
	<th><%=RequestSQL.replaceOldSimbol(
										RequestSQL.notNULL(req.rs.getString(6),"")
										,
										" <span>&#216;</span>"
									  )%></th>
	<th><%=RequestSQL.notNULL(req.rs.getString(7),"") %></th>
	<th><%=RequestSQL.notNULL(req.rs.getString(8),"") %></th>
	<th><%=RequestSQL.notNULL(req.rs.getString(9),"") %></th>
	<th><%=RequestSQL.notNULL(req.rs.getString(10),"")%></th>
	<th><%=RequestSQL.notNULL(req.rs.getString(11),"")%></th>
	<th>&nbsp; </th>
	
</tr>
<%	
}
%>
</tbody>
</table>

</body>
</html>