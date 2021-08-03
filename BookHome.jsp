<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.net.URLEncoder" %>
 <jsp:useBean id="obj" class="bean.BookBean"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,user-scalable=no,maximum-scale=1" />
<title>書籍管理ホーム</title>
<style>
	header{
		width:100%;
		padding:10px 10px;
 		background-color:#ADD8E6;
		color:#fff;
		font-family: 'Noto Sans JP', sans-serif;
	}
	body {
		margin:0;
		padding:0;
		font-size: 17px;
		text-align: center;
  		background-color:#ADD8E6;
  		background-image:url(images/library-1082309.jpg);
  		background-size:contain;
  		background-attachment: fixed;
		font-family: 'Noto Sans JP', sans-serif;
			}
	button:hover {
			border-bottom-color:transparent;
			transform:translateY(0.1em);
				}
	p {
		color: red;
		font-family: 'Noto Sans JP', sans-serif;
		}
	.search{
		font-family: 'Noto Sans JP', sans-serif;
		}
	.search2{
		height:28px;
		background:#668ad8;
		color:#FFF;
		border-bottom:solid 2px #627295;
		font-family: 'Noto Sans JP', sans-serif;
		}
	.search2:hover{
		border-bottom-color:transparent;
		transform: translateY(0.1em);
		}
	table{
		height:40px;
		table-layout:fixed;
		width:1100px;
		background-color:#FFF;
		border-radius:5px;
		border:solid 3px #6091d3;
		}
/* 	申請ボタンの装飾 */
	.btn-square{
		display:inline-block;
		padding:0.5em 1em;
		text-decoration:none;
		background-color:#668ad8;
		color:#FFF;
		border-bottom:solid 4px #627295;
		border-radius:3px;
		font-family: 'Noto Sans JP', sans-serif;
		}
/* 	返却ボタンの装飾 */
	.btn-square2{
 		display:inline-block;
 		padding:0.5em 1em;
 		text-decoration:none;
 		background-color:#FFA07A;
 		color:#FFF;
 		border-bottom:solid 4px #627295;
 		border-radius:3px;
		padding:0.5em 1em;
 		margin:1em 0.5em;
		font-family: 'Noto Sans JP', sans-serif;
 		}
/* 	管理者ログインの装飾 */
	.btn-square3{
		display:inline-block;
		padding:0.5em 1em;
		text-decoration:none;
		background-color:#FFA07A;
		color:#FFF;
		border-bottom:solid 4px #627295;
		border-radius:3px;
		position:absolute;
		right:150px;
 		top:34px;
 		font-family: 'Noto Sans JP', sans-serif;
		}
</style>
</head>

<body>
<header>
	<h1>さくら書籍管理</h1>
	<button class="btn-square3" onclick="location.href='login.jsp'" >管理者ログイン</button>


	<p>※会社経費による書籍購入には会社の決済承認が必要です
	<p>※経費での書籍購入者は、書籍名等を正確に総務部へ報告してください<br>
</header>

	<button class="btn-square2" onclick="location.href='ReturnForm.jsp'">返却ボタン</button>

<form class="search" action="#" method="post">
<!-- 	書籍名の検索<br> -->
	<br>
	<input type="text" name="keyword" placeholder="書籍名の検索" style="width:300px; height:23px;">
	<input class="search2" type="submit" value="🔍 検索">
</form>

	<%String keyword = request.getParameter("keyword");%>
	<%if(keyword!=null){%>

		<br>
<!-- 		<br>検索結果一覧 -->

		<table border="1" align="center" >
			<tr>
				<th>書籍番号</th>
				<th>書籍名</th>
				<th>ジャンル</th>
				<th>出版社</th>
				<th>ステータス</th>
				<th>申請</th>
			</tr>
		</table>

		<%List<BookBean> list = obj.BookBeanDBtoList2(keyword);
		for(int i=0;i<list.size();i++){
			obj = list.get(i);%>
			<table border="1" align="center" >

				<tr>
					<td><%=obj.getIsbn() %></td>
					<td ><%=obj.getTitle() %></td>
					<td><%=obj.getGenre() %></td>
					<td><%=obj.getPublisher() %></td>
					<td><%=obj.getStatus() %></td>
					<%String status=obj.getStatus(); %>
					<%if(status.contains("レンタル可")){ %>
					<td><button onclick="location.href='RentalForm.jsp?isbn=<%=obj.getIsbn() %>'" class="btn-square">申請</button>
					<%}else{ %>
				<td>申請不可</td>
				<%} %>
				</tr>
				<br>
			</table>
			<%} %>
		<%}else if(keyword==null){%>
			<br>

		<table class="table" border="1" align="center" >
			<tr>
				<th>書籍番号</th>
				<th>書籍名</th>
				<th>ジャンル</th>
				<th>出版社</th>
				<th>ステータス</th>
				<th>申請</th>
			</tr>
		</table>

		<%List<BookBean> list = obj.BookBeanDBtoList();
			for(int i=0;i<list.size();i++){
				obj = list.get(i);%>
			<table class="table" border="1" align="center" >
			<tr>
				<td><%=obj.getIsbn() %></td>
				<td><%=obj.getTitle() %></td>
				<td><%=obj.getGenre() %></td>
				<td><%=obj.getPublisher() %></td>
				<td><%=obj.getStatus() %></td>
				<%String status=obj.getStatus(); %>
				<%if(status.contains("レンタル可")){ %>
				<td><button onclick="location.href='RentalForm.jsp?isbn=<%=obj.getIsbn() %>'" class="btn-square">申請</button>
				<%}else{ %>
				<td>申請不可</td>
				<%} %>
			</tr>
			<br>
			<%}%>
			</table>
		<%}%>

</body>
</html>