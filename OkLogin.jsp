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
		font-family: 'Noto Sans JP', sans-serif;
		text-align: center;
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

/* 	ステータス変更ボタンの装飾 */
	.btn-change{
	 	display:inline-block;
		padding:0.5em 1em;
		text-decoration:none;
		background:#668ad8;
		color:#000000;
		border-bottom:solid 4px #627295;
		border-radius:3px;
		font-family: 'Noto Sans JP', sans-serif;
		}

	.search{
		font-family: 'Noto Sans JP', sans-serif;
		}

	.search2{
		text-align: center;
		height:28px;
		background:#668ad8;
		color:#000000;
		border-bottom:solid 2px #627295;
		font-family: 'Noto Sans JP', sans-serif;
		}

	.search2:hover{
		border-bottom-color:transparent;
		transform: translateY(0.1em);
		}
	.btn-rental{
	background:#C0C0C0;
	position: relative;
	left: 200px;
	}
</style>
</head>

<body>
<%	String isbn = request.getParameter("isbn");
		if(isbn == null){
			isbn = "";
		}
	String title = request.getParameter("title");
		if(title == null){
			title = "";
		}
	String yomi = request.getParameter("yomi");
		if(yomi == null){
			yomi = "";
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
			status = "";
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
		}
		String changes = request.getParameter("changes");
		if(changes == null){
			changes = "";
		}
		%>

<button onclick="location.href='BookHome.jsp'">閲覧用書籍一覧</button>
<button onclick="location.href='EmployeeManagement.jsp'">社員管理</button>

<form action="OkLogin.jsp" method="POST">
<div style="display:inline-flex">
    <p>書籍番号<br><input type="text" name="isbn" pattern="\d{13}" title="13桁の数字"  required></p>
	<p>書籍名<br><input type="text" name="title" required></p>
	<p>読み仮名<br><input type="text" name="yomi" pattern="[^一-龥]{2,}" title="2文字以上の英数字、平仮名" required></p>
	<p>ジャンル<br><select name="genre">
		<option value="資格・検定">資格・検定</option>
		<option value="人工知能">人工知能</option>
		<option value="経営">経営</option>
		<option value="プログラミング">プログラミング</option>
		<option value="ビジネス">ビジネス</option>
		<option value="ネットワーク">ネットワーク</option>
		<option value="データベース">データベース</option>
		<option value="テクノロジー・工学">テクノロジー・工学</option>
		<option value="エクセル">エクセル</option>
		<option value="OS">OS</option>
		</select></p>
	<p>出版社<br><input type="text" name="publisher" required></p>
	<p>ステータス<br><select name="status">
		<option value="レンタル中">レンタル中</option>
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

	<p>レンタル日<br><input type="date" name="borrow_date" required></p>
	</div>
	<br>
	<input type="submit" name ="btn" value="追加">
	<button onclick="location.href='OkRental.jsp'" class="btn-rental">レンタル可</button>
	<br>
</form>

<form action="OkLogin.jsp" method="post" class="search">
<!-- 	借用者の検索<br> -->
	<br>
	<input type="text" name="keyword" placeholder="借用者の検索" style="width:300px; height:23px;">
	<input class="search2" type="submit" value="🔍 検索">
</form>
<br>

<br>
<br>

	<%String keyword = request.getParameter("keyword");%>
	<%if(keyword != null){%>

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
 </table>

 <%
List<BookBean> list4 = obj.BookBeanDBtoList4(keyword);
for(int i = 0; i < list4.size(); i++){
obj = list4.get(i);	//get()メソッドでArrayListから1件データを取出し、BookBeanクラスのオブジェクトに入れる
%>
<table class="table" border="1">
 <tr>
      <td width="15%"><%= obj.getIsbn() %></td>
      <td width="30%"><%= obj.getTitle() %></td>
      <td width="10%"><%= obj.getGenre() %></td>
      <td width="10%"><%= obj.getPublisher() %></td>
      <td width="10%">
		<form action="OkLogin.jsp" method="POST">
			<p><br><select name="changes">
			  		<option value=<%= obj.getStatus() %>><%= obj.getStatus() %></option>
				<%String status2 = (obj.getStatus());%>
		        <%if(status2.contains("レンタル中")){%>
		       		<option value="レンタル可">レンタル可</option>
		        <%} else{%>
		       		<option value="レンタル中">レンタル中</option>
		   	    <%} %>	</select></p>

		   	<input type="hidden" name ="isbn" value ="<%=obj.getIsbn()%>">
			<input type="submit" name ="btn" value="更新">
		</form>
	　　</td>
      <td width="10%"><%= obj.getRental() %></td>
      <td width="10%"><%= obj.getBorrow_date() %></td>
      <td width="5%"><button onclick="location.href='OkLogin.jsp?linkId=<%= obj.getIsbn() %>&btn=delete'">削除</button></td>
<% } %>
   </tr>
 </table>
	<%} %>
		<%if(keyword == null){%>

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
 </table>
<%
List<BookBean> list = obj.BookBeanDBtoList3(btn,request.getParameter("linkId"),request.getParameter("isbn"),request.getParameter("title"),request.getParameter("genre"),request.getParameter("publisher"),request.getParameter("status"),request.getParameter("employee"),request.getParameter("borrow_date"),request.getParameter("yomi"),request.getParameter("changes"));
for(int i = 0; i < list.size(); i++){
obj = list.get(i);	// get()メソッドでArrayListから1件データを取出し、BookBeanクラスのオブジェクトに入れる
%>
<table class="table" border="1">
 <tr>
      <td width="15%"><%= obj.getIsbn() %></td>
      <td width="30%"><%= obj.getTitle() %></td>
      <td width="10%"><%= obj.getGenre() %></td>
      <td width="10%"><%= obj.getPublisher() %></td>
      <td width="10%">
		<form action="OkLogin.jsp" method="POST">
			<p><br><select name="changes">
			  		<option value=<%= obj.getStatus() %>><%= obj.getStatus() %></option>
				<%String status2 = (obj.getStatus());%>
		        <%if(status2.contains("レンタル中")){%>
		       		<option value="レンタル可">レンタル可</option>
		        <%} else{%>
		       		<option value="レンタル中">レンタル中</option>
		   	    <%} %>	</select></p>

		   	<input type="hidden" name ="isbn" value ="<%=obj.getIsbn()%>">
			<input type="submit" name ="btn" value="更新">
		</form>
	　　</td>
      <td width="10%"><%= obj.getRental() %></td>
      <td width="10%"><%= obj.getBorrow_date() %></td>
      <td width="5%"><button onclick="location.href='OkLogin.jsp?linkId=<%= obj.getIsbn() %>&btn=delete'">削除</button></td>
   </tr>
 </table>
 <%} %>
 <%} %>

</body>
</html>


