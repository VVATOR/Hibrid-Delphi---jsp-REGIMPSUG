<%@page import="java.net.URLDecoder"%>
<%@page import="vva.oracle.OracleConnect"%>
<%@page import="vva.oracle.RequestSQL"%>
<%@ page language="java" contentType="text/html; charset=windows-1251"
    pageEncoding="windows-1251"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
<title>Insert title here</title>


<script>
function getCaret(el) { 
	  if (el.selectionStart) { 
	    return el.selectionStart; 
	  } else if (document.selection) { 
	    el.focus(); 
	 
	    var r = document.selection.createRange(); 
	    if (r == null) { 
	      return 0; 
	    } 
	 
	    var re = el.createTextRange(), 
	        rc = re.duplicate(); 
	    re.moveToBookmark(r.getBookmark()); 
	    rc.setEndPoint('EndToStart', re); 
	 
	    return rc.text.length; 
	  }  
	  return 0; 
	}
</script>


</head>
<body>


<input id="myElement" type="button" value="Нажми меня"/>

<%

RequestSQL ds = new RequestSQL();






String action="";
if(request.getParameter("action")!=null){
action = new String(request.getParameter("action").getBytes("ISO-8859-1"));	
action = URLDecoder.decode(action,"windows-1251");



	if(action.equals("addMemoSug")){
		String addMemoSug=null;
		if((request.getParameter("addMemoSug")!=null)||(request.getParameter("addMemoSug")!="")){
			addMemoSug = new String(request.getParameter("addMemoSug").getBytes("ISO-8859-1"));
			addMemoSug = URLDecoder.decode(addMemoSug, "windows-1251");
			ds.insertSimbolicText(addMemoSug);
			out.print("=== insert ==="+addMemoSug);
		}
	}

	if(action.equals("deleteAllSimbolic")){
		ds.deleteAllSimbolic();
		out.print("=== delete ===");
	}






}
%>


<script>
	function setAction(action){
		document.frm.action.value=action;
		frm.submit();
	}

	function addSimbol(simbol,nameElement){
		document.getElementById(nameElement).value+=simbol;
	} 
</script>


<form name=frm>
<input type="hidden" name="action">
<textarea rows="5" cols="20" name="addMemoSug" id="addMemoSug" ondblclick="alert(getCaret(document.getElementById('addMemoSug')));"></textarea>

		<table>
		<%
		int a=200;
		for(int j=0;j<100;j++)
		{
		%>
			<tr>
				<%
				for(int i=0;i<10;i++)
				{
				%>
				<td>
					<input type="button" onclick="addSimbol('&<%=a%>;','addMemoSug');" value="&#<%=a%>;">					
				</td>
				<%
				a++;
				} 
				%>
			</tr>
		<%
		} 
		%>
		</table>

<input type="button" onclick="setAction('addMemoSug')" value="addSimbolic"> 
<input type="button" onclick="setAction('deleteAllSimbolic')" value="deleteAllSimbolic">
</form>






<table>
<tbody>
<%
ds.selectSimbolicText("sds");
while(ds.rs.next()){ 
%>
	<tr>			
			<th><%=RequestSQL.notNULL(ds.rs.getString(1),"")%></th>		
			<th><%=RequestSQL.notNULL(ds.rs.getString(2),"")%></th>	
	</tr>
<%
}
%>		

</tbody>
</table>



<script>


//document.getElementById('myElement').onclick 
/*
var ButName = window.event.srcElement.name
 alert(ButName);
 
 
document.getElementsByName(oSource).onclick 
= function() {
    alert(document.getElementById('myElement').getAttribute('value'));
}*/
/*
function getEventType(e) {  

	     if (!e) e = window.event;  

	     alert(e.type);  

} 


window.onload = function(){
	document.body.onclick = function(event) {
	//alert(window.target);
	alert(window.event.type);
	
	//alert(event.type);
	}
}
*/

/*window.onload = function() {
    document.body.onclick = function(event) {
         //t=event.target; srcElement
         t=event.srcElement;
         alert(t);
    }
}*/
</script>
</body>
</html>