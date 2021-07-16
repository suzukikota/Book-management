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
<title>社員管理</title>
</head>
<body>
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
	<p>社員番号<br><input type="text" name="employee_id"></p>
	<p>氏名<br><input type="text" name="name"></p>
	<p><input type="submit" name ="btn" value="追加"></p>
</form>
<br>
<br>
<table border="1" width="30%">
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
<a href="BookHome.html" >書籍一覧</a>
<a href="BookManagement.jsp" >書籍管理</a>

</body>
</html>