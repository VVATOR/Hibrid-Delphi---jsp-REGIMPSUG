<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="vva.oracle.OracleConnect"%>
<%@page import="vva.oracle.RequestSQL"%>
<%@ page language="java" contentType="text/html; charset=windows-1251"
    pageEncoding="windows-1251"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
<title>Карточка рацианализатора</title>

<style>
	.t-rp thead tr th{
		border-collapse: collapse;
		border: 1px solid black; 	
	}
	.t-rp tbody tr th{
		border-collapse: collapse;
		border: 1px solid black; 	
	}
	
	
	
	
	
span {
color:red;
font: bold seryf;
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
</style>
	

</head>


<%
/*	String date1 = "";
	if(request.getParameter("date1")!=null){
		date1 = new String(request.getParameter("date1").getBytes("ISO-8859-1"));
		date1 = URLDecoder.decode(date1, "windows-1251");
	};
	
	String date2 = "";
	if(request.getParameter("date2")!=null){
		date2 = new String(request.getParameter("date2").getBytes("ISO-8859-1"));
		date2 = URLDecoder.decode(date2, "windows-1251");
	};

*/

String tn = "";
String firstname = "";
String otchestvo = "";
String lastname = "";



String fio = "";
if(request.getParameter("fio")!=null){
	fio = new String(request.getParameter("fio").getBytes("ISO-8859-1"));
	fio = URLDecoder.decode(fio, "windows-1251");
};





//fio="Мешкова Ирина Евгеньевна";

RequestSQL requestSQL = new RequestSQL();

tn = RequestSQL.notNULL(requestSQL.getTN(fio),"");
firstname = requestSQL.parse_F_I_O(fio,'i');
otchestvo = requestSQL.parse_F_I_O(fio,'o');
lastname = requestSQL.parse_F_I_O(fio,'f');
/*
	tn = "ss";
	firstname = "sds";
	otchestvo = "scsc";
	lastname = "cccc";
*/
	
	
	
	
%>
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



<%String  EXCEL_report = "\"cartochka.jsp?fio="+fio+"&action=excel\"";%>
	<div class="btnEXCEL_report" title="Вывести в Excel" onclick='window.location=<% out.print(EXCEL_report); %> ;'></div>
  






    <table width="871" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <th width="871" scope="col">
    
    <table width="100%" cellpadding="0" cellspacing="0">
      <col width="13" span="2" />
      <col width="12" span="28" />
      <col width="24" />
      <col width="12" span="25" />
      <col width="31" />
      <col width="12" />
      <tr>
        <td colspan="30" rowspan="2" align="center" valign="middle">ОАО &quot;НТЦК&quot;</td>
        <td width="24"></td>
        <td width="18"></td>
        <td width="16"></td>
        <td width="7"></td>
        <td width="7"></td>
        <td width="7"></td>
        <td width="7"></td>
        <td width="7"></td>
        <td width="7"></td>
        <td width="7"></td>
        <td width="7"></td>
        <td width="7"></td>
        <td width="7"></td>
        <td width="7"></td>
        <td width="7"></td>
        <td width="7"></td>
        <td width="7"></td>
        <td width="7"></td>
        <td width="7"></td>
        <td width="7"></td>
        <td width="7"></td>
        <td width="7"></td>
        <td width="7"></td>
        <td width="7"></td>
        <td width="7"></td>
        <td width="7"></td>
        <td width="18"></td>
        <td width="196"></td>
      </tr>
      <tr>
        <td></td>
        <td></td>
        <td></td>
        <td colspan="25" rowspan="2" align="center" valign="bottom">Типовая    междуведомственная форма № Р-5</td>
      </tr>
      <tr>
        <td colspan="30" align="center" valign="top">предприятие,    организация</td>
        <td></td>
        <td></td>
        <td></td>
      </tr>
      <tr>
        <td colspan="30" rowspan="2"></td>
        <td></td>
        <td></td>
        <td></td>
        <td colspan="25" align="center" valign="top">Утверждена приказом ЦСУ СССР от 18.08.76 № 681</td>
      </tr>
      <tr>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
        <td></td>
      </tr>
    </table>
    
    </th>
  </tr>
  <tr>
    <th scope="row"></th>
  </tr>

  <tr>
  		<th>&nbsp;</th>   		
  </tr>
  <tr>
    <th align="center" valign="bottom" scope="row">КАРТОЧКА РАЦИОНАЛИЗАТОРА (ИЗОБРЕТАТЕЛЯ)</th>
  </tr>
    <tr>
  		<th>&nbsp;</th>   		
  </tr>
  <tr>
    <th scope="row">
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr>

         <th width="14%" align="left" valign="top" scope="col">Фамилия</th>
        <th width="21%" align="left" valign="top" scope="col"><input type="text" name="fam" value="<%=lastname%>"></th>
        <th width="13%" align="left" valign="top" scope="col">Имя</th>
        <th width="21%" align="left" valign="top" scope="col"><input type="text" name="name" value="<%=firstname%>"></th>
        <th width="11%" align="left" valign="top" scope="col">Отчество</th>
        <th width="20%" scope="col"><input type="text" name="otchestvo" value="<%=otchestvo%>"></th>
       
      </tr>
      <tr>
        <th align="left" valign="top" scope="row">Год рождения</th>
        <td align="left" valign="top"><input type="text" name="birthday"></td>
        <td align="left" valign="top">Партийность</td>
        <td align="left" valign="top"><input type="text" name="partiya"></td>
        <td align="left" valign="top">Образование</td>
        <td><input type="text" name="education"></td>
      </tr>
      <tr>
        <th align="left" valign="top" scope="row">Профессия</th>
        <td align="left" valign="top"><input type="text" name="profession"></td>
        <td align="left" valign="top">Табельный №</td>
        <td align="left" valign="top"><input type="text" name="tn" value="<%=tn%>"></td>
        <td align="left" valign="top"></td> 
        <td></td>
      </tr>
      <tr>
        <th align="left" valign="top" scope="row">Должность</th>
        <td align="left" valign="top"><input type="text" name="dolzhnost"></td>
        <td align="left" valign="top"></td>
        <td align="left" valign="top"></td>
        <td align="left" valign="top"></td>
        <td></td>
      </tr>
    </table>
    </th>
  </tr>
  <tr>
    <th scope="row"></th>
  </tr>
  <tr>
    <th align="left" scope="row">Служащий, рабочий, инженерно-технический работник (подчеркнуть)</th>
  </tr>
  <tr>
    <th scope="row"></th>
  </tr>
  <tr>
    <th scope="row"></th>
  </tr>
  <tr>
    <th scope="row"></th>
  </tr>
  <tr>
    <th scope="row"></th>
  </tr>
  <tr>
    <th scope="row"></th>
  </tr>
</table>
<br>
<br>
<br>
<br>


<table class='t-rp'>
<thead>
	<tr>
		<th>Порядковый номер записи</th>
		<th>Дата подачи предложения</th>
		<th>Регистрационный номер предложения</th>
		<th>Наименование предложения</th>
		<th>Дата использования предложения</th>
		<th>Годовая экономия, тыс. руб.</th>
		<th>Сумма вознаграждения, руб.</th>
		<th>Номер и дата приказа</th>
	</tr>

</thead>
<tbody>
<% 
requestSQL.selectCartochka(fio);

int kolRP=0;
try{
while(requestSQL.rs.next()){ 	

%>
	<tr>		
		<th><%=requestSQL.rs.getInt(1)%></th>		
		<th>
		<%= new SimpleDateFormat("dd.MM.yyyy").format(requestSQL.rs.getDate("DATE_CREATE"))%>	
		
		</th>
		<th><%=RequestSQL.notNULL(requestSQL.rs.getString("INT_NUMBER"),"")%></th>
		<th><%//=RequestSQL.notNULL(requestSQL.rs.getString("SUMMARY"),"")%>
			<%=RequestSQL.replaceOldSimbol(
											RequestSQL.notNULL(requestSQL.rs.getString("SUMMARY"),"")
											,
											" <span>&#216;</span>"
										  )%>
		
		</th>
		<th><%=RequestSQL.notNULL(requestSQL.rs.getString(4),"")%></th>
		<th>
			<%=RequestSQL.notNULL(requestSQL.rs.getString("INTRO_ECONOMY"),"")%>
		</th>
		<th><%=RequestSQL.notNULL(requestSQL.rs.getString("INTRO_BONUS"),"")%></th>
		<th>	
			<%
			try{
			
			%>	
			 <%="№ "+RequestSQL.notNULL(requestSQL.rs.getString("INTRO_NUMBER"),"")+" от "+new SimpleDateFormat("dd.MM.yyyy").format(requestSQL.rs.getDate("INTRO_DATE"))%>
		   <%  
			}catch(Exception e){}			
		   %>	  
		</th>
	</tr>


<%
kolRP++;
}
}catch(Exception e){

}
%>
</tbody>
<tfoot>
<tr>		
		<th></th>		

	</tr>
</tfoot>
</table>

Итого: <%=kolRP%>
<br>

Подпись   ___________
</body>
</html>