<%@ page language="java" contentType="text/html; charset=windows-1251"
    pageEncoding="windows-1251"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="vva.oracle.OracleConnect"%>
<%@page import="vva.oracle.RequestSQL"%>


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
	
	
	
	.row-head th{
		background-color: #FDF5E6;
		font-size: 1.1em;
	}
	.row-itog th{
		background-color: #DCDCDC;
	}
	.row-separator th{
		background-color: white;
		border-collapse: collapse;
		border-left: 0px;
		border-color: white;
	}
	
	
	.btnCard{
	color: black;
	display: block;
	text-decoration: none;
	}
	.btnCard:hover{
	color: black;
	background-color: #98FB98;
	display: block;
	text-decoration: none;
	}
	
	
	.btnEXCEL_report{
		background: url(images/excel.gif)  no-repeat 5px 5px; 	/*excel_report*/		
		margin: 3px; 
		padding:3px;
		outline: none; 
		border-width: 0px; 
		background-color: gray; 
		position: fixed; 
		top: 0px; 
		right:0px; 
		z-index: 100;
	    width: 37px; height: 37px;
	}
	
	.btnEXCEL_report:hover{
		background-color: yellow;
	}
	
	tr:hover{
		background-color: #E6E6FA;
	}
</style>
</head>
<body>  
<%
String action="";
if(request.getParameter("action")!=null){
	action = new String(request.getParameter("action").getBytes("ISO-8859-1"));
	action = URLDecoder.decode(action,"windows-1251");
	
	if(action.equals("excel")){
		response.setHeader("Cache-Control", "no-cache");
		response.setHeader("Content-disposition",  "attachment; filename=excel.xls" );
	}
}



%>

<%
String racorg=System.getProperty("user.name");
String fio = "";
if(request.getParameter("fio")!=null){
	fio = new String(request.getParameter("fio").getBytes("ISO-8859-1"));
	fio = URLDecoder.decode(fio, "windows-1251");
};

String countBEST = "";
if(request.getParameter("countBEST")!=null){
	countBEST = new String(request.getParameter("countBEST").getBytes("ISO-8859-1"));
	countBEST = URLDecoder.decode(countBEST, "windows-1251");
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

String program = "";
if(request.getParameter("program")!=null){
	program = new String(request.getParameter("program").getBytes("ISO-8859-1"));
	program = URLDecoder.decode(program, "windows-1251");
};
if(!program.equals("delphi")){
	fio="Мешкова Ирина Евгеньевна";
	date1="01.01.2012";
	date2="01.11.2014";
	countBEST="3";
	out.println(fio);
	out.println(date1);
	out.println(date2);
	out.println("countBEST: "+countBEST);
}

RequestSQL requestSQL = new RequestSQL();

%>
<%String  EXCEL_report = "\"mega_racik_333.jsp?fio="+fio+"&date1="+date1+"&date2="+date2+"&countBEST="+countBEST+"&action=excel\"";%>
	<div class="btnEXCEL_report" title="Вывести в Excel" onclick='window.location=<% out.print(EXCEL_report); %> ;'></div>


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



<% 
requestSQL.selectBestInnovator(date1,date2,countBEST);
if(!requestSQL.rs.next())
	out.print("lll");
else
{
	requestSQL.rs.previous();
%>
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
	while(requestSQL.rs.next()){ 
	%>
	
		<tr>
			
			<th><%=RequestSQL.notNULL(requestSQL.rs.getString(1),"")%></th>		
			<th><a class='btnCard'  href='cartochka.jsp?fio=<%=RequestSQL.notNULL(requestSQL.rs.getString(2),"")%>'> <%=RequestSQL.notNULL(requestSQL.rs.getString(2),"")%></a></th>
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
<%
}
%>






<br><br><br>



	<h3>
		Данные по рационализации
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
	
			<%		         
			reqUser.selectAll(date1, date2, reqDep.rs.getString("ID"));
			//reqUser.getRacikUserByDepartment(reqDep.rs.getString("department"));
			boolean kount=true;
			int introInDep=0;
			int introSugInDep=0;
			int podanoSugInDep=0;
			double ED_SugInDep=0;
			
			
			while(reqUser.rs.next()){ 
				if	(kount==true){
				%>
					<tr class="row-head">			
						<th colspan=5 class="field-dep-nach"><%=reqDep.rs.getString("department")%> (<%=reqDep.rs.getString("department_chief")%>) </th>			
					</tr>		
				<%
				}
				kount=false;
				%>
					<tr>			
							<th><%=RequestSQL.notNULL(reqUser.rs.getString(1),"")%></th>		
							<th><a class='btnCard' href='cartochka.jsp?fio=<%=RequestSQL.notNULL(reqUser.rs.getString(2),"")%>'> <%=RequestSQL.notNULL(reqUser.rs.getString(2),"")%></a></th>
							<th><%=RequestSQL.notNULL(reqUser.rs.getString(3),"")%></th>
							<th><%=RequestSQL.notNULL(reqUser.rs.getString(4),"")%></th>
							<th><%=RequestSQL.notNULL(reqUser.rs.getString(5),"")%></th>
					</tr>					
				<%
				introInDep++;
				introSugInDep  +=  Integer.parseInt(RequestSQL.notNULL(reqUser.rs.getString(3),"0"));
				podanoSugInDep += Integer.parseInt(RequestSQL.notNULL(reqUser.rs.getString(4),"0"));
				ED_SugInDep    += Double.parseDouble(RequestSQL.notNULL(reqUser.rs.getString(5),"0"));
				
			}
			if	(kount!=true){
				%>
					<tr class="row-itog">			
							<th> </th>		
							<th>ИТОГО:</th>
							<th><%=introSugInDep%> *** <%=introInDep%></th>
							<th><%=podanoSugInDep%></th>
							<th><%=ED_SugInDep%></th>
					</tr>		
					<tr class="row-separator">			
							<th colspan=5>&nbsp; </th>		
							
					</tr>		
				<%
			}
			
	}
	%>
</tbody>
</table>

<br><br>
Рац.орг. ОАО «НТЦК»____________________________________<%=reqUser.getRacorgNameByLogin(racorg)%>
<br><br>






</body>
</html>