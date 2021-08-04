<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="bean.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<jsp:useBean id="obj" class="bean.BookBean"/>
<jsp:useBean id="obj2" class="bean.Employee_InfoBean"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>書籍管理</title>

<style>
	body {
		background-color:rgba(220,220,220,0.9);
			}
	button:hover {
			border-bottom-color:transparent;
			transform:translateY(0.1em);
			}
	table{
		height:50px;
		width:100%;
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
		}

</style>
</head>

<body>
<button onclick="location.href='BookHome.jsp'">閲覧用書籍一覧</button>
<button onclick="location.href='EmployeeManagement.jsp'">社員管理</button>

<form action="#" method="POST">
<div style="display:inline-flex">
    <p>図書番号<br><input type="text" name="isbn" required></p>
	<p>書籍名<br><input type="text" name="title" required></p>
	<p>ジャンル<br><input type="text" name="genre" required></p>
	<p>出版社<br><input type="text" name="publisher" required></p>
	<p>ステータス<br><select name="status">
		<option value="レンタル中">レンタル中</option>
		<option value="レンタル可">レンタル可</option>
	</select></p>
	</div>

	<div style="display:inline-flex">
	<p>借用者<br><select name="employee">
		<%List<Employee_InfoBean> list2 = obj2.Employee_InfoDBtoList2();
			for(int j=0;j<list2.size();j++){
				obj2=list2.get(j);%>
				<%=obj2.getName() %>

			<option value=<%=obj2.getName()%>><%=obj2.getName()%></option>
			<%} %>
		</select></p>

<!-- 	<p>借用者<br><input type="text" name="rental" required></p> -->
	<p>レンタル日<br><input type="text" name="borrow_date" required></p>
		</div>
			<br>
	<input type="submit" name ="btn" value="追加">

	<br>
	<br>
</form>

<%	String isbn = request.getParameter("isbn");
		if(isbn == null){
			isbn = "";
		}
	String title = request.getParameter("title");
		if(title == null){
			title = "";
		}
	String genre = request.getParameter("genre");
		if(genre == null){
			genre = "";
		}
	String publisher = request.getParameter("publisher");
		if(publisher == null){
		}
	String status = request.getParameter("status");
		if(status == null){
		}
	String employee = request.getParameter("employee");
		if(employee == null){
			employee = "";
		}
	String borrow_date = request.getParameter("borrow_date");
		if(borrow_date == null){
			borrow_date = "";
		}
	String btn = request.getParameter("btn");
		if(btn == null){
			btn = "";
		}%>

<table class="table" border="1">
 <tr>
      <th width="15%">ISBN</th>
      <th width="30%">書籍名</th>
      <th width="10%">ジャンル</th>
      <th width="10%">出版社</th>
      <th width="10%">ステータス</th>
      <th width="10%">借用者</th>
      <th width="10%">レンタル日</th>
      <th width="5%">削除</th>
 </tr>
<%
List<BookBean> list = obj.BookBeanDBtoList3(btn,request.getParameter("linkId"),request.getParameter("isbn"),request.getParameter("title"),request.getParameter("genre"),request.getParameter("publisher"),request.getParameter("status"),request.getParameter("employee"),request.getParameter("borrow_date"));
for(int i = 0; i < list.size(); i++){
obj = list.get(i);	// get()メソッドでArrayListから1件データを取出し、BeanAccessDBクラスのオブジェクトに入れる
%>
 <tr>
      <td><%= obj.getIsbn() %></td>
      <td><%= obj.getTitle() %></td>
      <td><%= obj.getGenre() %></td>
      <td><%= obj.getPublisher() %></td>
      <td><%= obj.getStatus() %></td>
      <td><%= obj.getRental() %></td>
      <td><%= obj.getBorrow_date() %></td>
      <td><button onclick="location.href='oklogin.jsp?linkId=<%= obj.getIsbn() %>&btn=delete'">削除</button></td>
<% } %>
   </tr>
 </table>
 <br>


