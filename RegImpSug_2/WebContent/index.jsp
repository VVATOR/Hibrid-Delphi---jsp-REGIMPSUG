<%@ page language="java"   contentType="text/html; charset=windows-1251"
    pageEncoding="windows-1251"%>
<%@page import="vva.oracle.OracleConnect"%>
<%@page import="vva.oracle.RequestSQL"%>
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1251">
<title>Insert title here</title>

<style>
body{
	padding: 0px;
	margin: 0px;
}

.fix_head{
	width: 100%;
	position: fixed;
}
	.caption{
		padding: 0px;
		margin: 0px;
		color: white;
		background-color: gray;
		background: url(images/bg_caption.png); 				
		background-repeat: top repeat-x;
		vertical-align: middle;
		overflow: hidden;
		width: 100%;
		height: 2em;
	}
	.main_menu{
		padding: 0px;
		margin: 0px;
		color: white;
		background-color: #FFFAF0;		
		width: 100%;
		height: 2em;
	}

		.main_menu ul{
			padding: 0px;
			margin: 0px;
			display:block;
			list-style: none;
			color: green;
			float: left;
			
		}
			.main_menu li{
				padding: 5px;
				margin: 0px;
				display:block;
				list-style: none;
				color: green;
				float: left;
				
			}
			.main_menu li:hover{
				display:block;
				background-color: #FFEBCD;
				list-style: none;
				color: blue;			
			}
		
			.main_menu li[class!="separator"]{
				padding: 0px 5px 0px 5px;
				margin: 0px;
				list-style: none;			
				color: pink;
				float: left;			
			}
	
.btn_caption{
	padding: 5px;
	margin: 2px;
	display: block;
	height: 1em;
	width: 1em;
	background-color: red;
	color white;
	float:left;
	text-align: center;	 
}

</style>

</head>
<body>
<div class="fix_head">
<div class="caption">
 Журнал регистрации рационализаторских предложений <%out.println(System.getProperty("user.name")); %>
	<div class="btn_caption" style="right: 0px; top: 0px ; width: 1em;">
		x
	</div>
</div>
<div class="main_menu">
	<ul>
	 <li>Файл</li>
	 <li>Вид</li>
	 <li class="separator">|</li>
	 <li>Справка</li>
	 <li></li>
	</ul>
</div>
</div>
<div style="width: 100%;">
http://localhost:8080/RegImpSug_2/index.jsp
<%@ include file="table.jsp" %>
</div>
</body>
</html>