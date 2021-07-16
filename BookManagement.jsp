<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="bean.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.URLEncoder" %>
<jsp:useBean id="obj" class="bean.BookBean"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>書籍管理</title>
</head>
<body>

<form action="#" method="POST">
<div style="display:inline-flex">
    <p>図書番号<br><input type="text" name="isbn"></p>
	<p>書籍名<br><input type="text" name="title"></p>
	<p>ジャンル<br><input type="text" name="genre"></p>
	<p>出版社<br><input type="text" name="publisher"></p>
	<p>ステータス<br><select name="status">
		<option value="レンタル中">レンタル中</option>
		<option value="レンタル可">レンタル可</option>
	</select></p>
	</div>
	<div style="display:inline-flex">
	<p>借用者<br><input type="text" name="rental"></p>
	<p>レンタル日<br><input type="text" name="borrow_date"></p>
		</div>
			<br>
	<input type="submit" name ="btn" value="追加">

	<br>
	<br>
	<!-- <input type="submit" name="btn" value="ステータス">
	<input type="submit" name="btn" value="ジャンル">
	<input type="submit" name="btn" value="書籍名"> -->
</form>

<%	String isbn = request.getParameter("isbn");
		if(isbn == null){
			isbn = "";
		}
		out.println(isbn);

	String title = request.getParameter("title");
		if(title == null){
			title = "";
		}
				out.println(title);
	String genre = request.getParameter("genre");
		if(genre == null){
			genre = "";
		}
				out.println(genre);
	String publisher = request.getParameter("publisher");
		if(publisher == null){
			publisher = "";
		}
				out.println(publisher);
	String status = request.getParameter("status");
		if(status == null){
			status = "";
		}
				out.println(status);
	String rental = request.getParameter("rental");
		if(rental == null){
			rental = "";
		}
				out.println(rental);
	String borrow_date = request.getParameter("borrow_date");
		if(borrow_date == null){
			borrow_date = "";
		}
		out.println(borrow_date);


%>

<br>

<%
String btn = request.getParameter("btn");
if(btn == null){
	btn = "";
}%>
<table border="1" width="100%">
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
List<BookBean> list = obj.BookBeanDBtoList3(btn,request.getParameter("linkId"),request.getParameter("isbn"),request.getParameter("title"),request.getParameter("genre"),request.getParameter("publisher"),request.getParameter("status"),request.getParameter("rental"),request.getParameter("borrow_date"));
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
      <td><button onclick="location.href='BookManagement.jsp?linkId=<%= obj.getIsbn() %>&btn=delete'">削除</button></td>

<% } %>
   </tr>
 </table>
 <br>
<a href="BookHome.html" >書籍一覧</a>
<a href="EmployeeManagement.jsp" >社員管理</a>

</body>
</html>