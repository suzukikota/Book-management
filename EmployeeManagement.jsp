<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="bean.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<jsp:useBean id="obj" class="bean.Employee_InfoBean"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,user-scalable=no,maximum-scale=1" />
<title>社員管理</title>
<style>
	body {
		background-color:rgba(220,220,220,0.9);
		text-align:center;
		font-family: 'Noto Sans JP', sans-serif;
			}
	table{
		margin-left: auto;
  	    margin-right: auto;/*中央揃え*/
			}
	button:hover {
			border-bottom-color:transparent;
			transform:translateY(0.1em);
			}
	table{
		height:50px;
		width:30%;
		table-layout:fixed;
		background:#FFF;
		border-radius:10px;
		border:solid 3px #6091d3;
		}
/* 	ボタンの装飾 */
	button{
		display:inline-block;
		padding:0.5em 1em;
		text-decoration:none;
		background:#668ad8;
		color:#000000;
		border-bottom:solid 4px #627295;
		border-radius:3px;
		font-family: 'Noto Sans JP', sans-serif;
		}

</style>
</head>

<body>
<button onclick="location.href='BookHome.jsp'">閲覧用書籍一覧</button>
<button onclick="location.href='OkLogin.jsp'">書籍管理</button>

<%	String employee_id = request.getParameter("employee_id");
		if(employee_id == null){
			employee_id = "";
		}
	String name = request.getParameter("name");
		if(name ==null){
			name = "";
		}
%>
<form action="#" method="POST">
	<p>社員番号<br><input type="text" name="employee_id" pattern="\d{6}" title="6桁の数字" required></p>
	<p>氏名<br><input type="text" name="name" required></p>
	<p><input type="submit" name ="btn" value="追加"></p>
</form>

<br>

<br>
<table class="table" border="1">
 <tr>
      <th width="5%">社員番号</th>
      <th width="20%">氏名</th>
      <th width="5%">削除</th>
 </tr>

<%
String btn = request.getParameter("btn");
if(btn == null){
	btn = "";
}

List<Employee_InfoBean> list = obj.Employee_InfoDBtoList(request.getParameter("linkEmployee_id"),request.getParameter("employee_id"), request.getParameter("name"), btn);
for(int i = 0; i < list.size(); i++){
obj = list.get(i);	// get()メソッドでArrayListから1件データを取出し、BeanAccessDBクラスのオブジェクトに入れる
%>

<tr>
<td><%= obj.getEmployee_id() %></td>
<td><%= obj.getName() %></td>
<td><button onclick="location.href='EmployeeManagement.jsp?linkEmployee_id=<%= obj.getEmployee_id() %>&btn=delete'">削除</button></td>
<% } %>
 </tr>
 </table>
 <br>
</body>
