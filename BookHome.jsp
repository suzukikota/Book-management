<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.*"%>
<%@ page import="bean.*"%>
<%@ page import="java.net.URLEncoder"%>
<jsp:useBean id="obj" class="bean.BookBean" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,user-scalable=no,maximum-scale=1" />
<title>書籍管理ホーム</title>
<style>
header {
	width: 100%;
	padding: 10px 10px;
	background-color: rgba(220, 220, 220, 0.9);
	color: #000000;
	font-family: 'Noto Sans JP', sans-serif;
}
body {
	margin: 0;
	padding: 0;
	font-size: 17px;
	text-align: center;
	background-image: url(images/library-1082309.jpg);
	background-size: cover;
	background-attachment: fixed;
	font-family: 'Noto Sans JP', sans-serif;
}
button:hover {
	border-bottom-color: transparent;
	transform: translateY(0.1em);
}
p {
	color: red;
	font-size: 16px;
	font-weight: 600;
	font-family: 'Noto Sans JP', sans-serif;
}
.search {
	font-family: 'Noto Sans JP', sans-serif;
}
.search2 {
	height: 23px;
	background: #668ad8;
	color: #000000;
	border-bottom: solid 2px #627295;
	font-family: 'Noto Sans JP', sans-serif;
}
.search2:hover {
	border-bottom-color: transparent;
	transform: translateY(0.1em);
}
table {
	height: 40px;
	table-layout: fixed;
	width: 80%;
	margin-left: auto;
	margin-right: auto;
	background-color: #FFF;
	border-radius: 5px;
	border: solid 3px #6091d3;
}
/* 	申請ボタンの装飾 */
.btn-square {
	display: inline-block;
	padding: 0.5em 1em;
	text-decoration: none;
	background-color: #668ad8;
	color: #000000;
	border-bottom: solid 4px #627295;
	border-radius: 10px;
	font-family: 'Noto Sans JP', sans-serif;
}
/* 	返却ボタンの装飾 */
.btn-square2 {
	display: inline-block;
	padding: 0.5em 1em;
	text-decoration: none;
	background-color: #668ad8;
	color: #000000;
	border-bottom: solid 4px #627295;
	border-radius: 10px;
	padding: 0.5em 1em;
	margin: 1em 0.5em;
	font-family: 'Noto Sans JP', sans-serif;
}
/* 	管理者ログインの装飾 */
.btn-square3 {
	display: inline-block;
	padding: 0.5em 1em;
	text-decoration: none;
	background-color: #FFA07A;
	color: #000000;
	border-bottom: solid 4px #627295;
	border-radius: 3px;
	position: absolute;
	right: 150px;
	top: 34px;
	font-family: 'Noto Sans JP', sans-serif;
}
/* 	ページング装飾 */
 nav.cp_navi *, nav.cp_navi *:after, nav.cp_navi *:before {
	-webkit-box-sizing: border-box;
	        box-sizing: border-box;
}
nav.cp_navi a {
	text-decoration: none;
}
nav.cp_navi {
	margin: 2em 0;
	text-align: center;
}
.cp_navi .cp_pagination {
	display: inline-block;
	height: 70px;
	margin-top: 2em;
	padding: 0 25px;
	border-radius: 35px;
	background-color: #eeeeee;
}
.cp_navi .cp_pagenum {
	font-size: 1.2em;
	line-height: 70px;
	display: block;
	float: left;
	padding: 0 25px;
	transition: 400ms ease;
	letter-spacing: 0.1em;
	color: #595959;
}
.cp_navi .cp_pagenum:hover,
.cp_navi .cp_pagenum.current {
	color: #ffffff;
	background-color: #00BCD4;
}
.cp_navi .cp_pagenum.prev:hover,
.cp_navi .cp_pagenum.next:hover {
	color: #00BCD4;
	background-color: transparent;
}
@media only screen and (max-width: 960px) {
	.cp_navi .cp_pagination {
		height: 50px;
		margin-top: 50px;
		padding: 0 10px;
		border-radius: 25px;
	}
	.cp_navi .cp_pagenum {
	font-size: 0.8em;
	line-height: 50px;
	padding: 0 15px;
	}
}
@media only screen and (min-width: 120px) and (max-width: 767px) {
	.cp_navi .cp_pagenum {
	display: none;
	padding: 0 14px;
	}
	.cp_navi .cp_pagenum:nth-of-type(2) {
	position: relative;
	padding-right: 50px;
	}
	.cp_navi .cp_pagenum:nth-of-type(2)::after {
	font-size: 1.2em;
	position: absolute;
	top: 0;
	left: 45px;
	content: '...';
	}
	.cp_navi .cp_pagenum:nth-child(-n+3),
	.cp_navi .cp_pagenum:nth-last-child(-n+3) {
		display: block;
	}
	.cp_navi .cp_pagenum:nth-last-child(-n+4) {
		padding-right: 14px;
	}
	.cp_navi .cp_pagenum:nth-last-child(-n+4)::after {
		content: none;
	}
}
</style>
</head>

<body>
	<header>
		<h1><a href='BookHome.jsp'>さくら書籍管理</a></h1>
		<button class="btn-square3" onclick="location.href='Login.jsp'">管理者ログイン</button>


		<p>※会社経費による書籍購入には会社の決済承認が必要です
		<p>
			※経費での書籍購入者は、書籍名等を正確に総務部へ報告してください<br>
	</header>

	<button class="btn-square2" onclick="location.href='ReturnForm.jsp'">返却ボタン</button>

<div class="searchform">
	<form class="search" action="BookHome2.jsp" method="post">
		<!-- 	書籍名の検索<br> -->
		<br> <input type="search" name="keyword" placeholder="キーワードから検索" style="width: 300px; height: 23px;">
			<select name="genre" style="width: 150px; height: 23px;">
				<option value="すべてのジャンル">すべてのジャンル</option>
				<option value="エクセル">エクセル</option>
				<option value="経営">経営</option>
				<option value="資格・検定">資格・検定</option>
				<option value="人工知能">人工知能</option>
				<option value="テクノロジー・工学">テクノロジー・工学</option>
				<option value="データベース">データベース</option>
				<option value="ネットワーク">ネットワーク</option>
				<option value="ビジネス">ビジネス</option>
				<option value="プログラミング">プログラミング</option>
				<option value="OS">OS</option>
			</select>
			<input class="search2" type="submit" value="🔍 検索">
	</form>
</div>

	<%String keyword = request.getParameter("keyword");%>
	<%String Genre = request.getParameter("genre");%>
	<%String param=request.getParameter("param"); %>
	<%int offset; %>

	<%if(keyword==null){%>
	<%if(param==null){ %>
	<%offset=0; %>
	<br>

	<table class="table" border="1">
		<tr>
			<th>書籍番号</th>
			<th width=32%>書籍名</th>
			<th>ジャンル</th>
			<th>出版社</th>
			<th width=10%>ステータス</th>
			<th width=8%>申請</th>
		</tr>
	</table>

	<%List<BookBean> list = obj.BookBeanDBtoList(offset);
			for(int i=0;i<list.size();i++){
				obj = list.get(i);%>
	<table class="table" border="1">
		<tr>
			<td><%=obj.getIsbn() %></td>
			<td width=32%><%=obj.getTitle() %></td>
			<td><%=obj.getGenre() %></td>
			<td><%=obj.getPublisher() %></td>
			<td width=10%><%=obj.getStatus() %></td>
			<%String status=obj.getStatus(); %>
			<%if(status.contains("レンタル可")){ %>
			<td width=8%><button
					onclick="location.href='RentalForm.jsp?isbn=<%=obj.getIsbn() %>'"
					class="btn-square">申請</button> <%}else{ %>
			<td width=8%>申請不可</td>
			<%} %>
		</tr>
		<br>
	</table>
	<%}%>
	<nav class="cp_navi">
	<div class="cp_pagination">
		<span aria-current="page" class="cp_pagenum current">1</span>
		<a class="cp_pagenum" href="BookHome.jsp?param=2">2</a>
		<a class="cp_pagenum" href="BookHome.jsp?param=3">3</a>
		<a class="cp_pagenum" href="BookHome.jsp?param=4">4</a>
	</div>
	</nav>
	<%}else if(param!=null){%>
	<%int num=Integer.parseInt(param); %>
	<%offset=10*(num-1); %>
				<br>

	<table class="table" border="1">
		<tr>
			<th>書籍番号</th>
			<th width=32%>書籍名</th>
			<th>ジャンル</th>
			<th>出版社</th>
			<th width=10%>ステータス</th>
			<th width=8%>申請</th>
		</tr>
	</table>

	<%List<BookBean> list = obj.BookBeanDBtoList(offset);
			for(int i=0;i<list.size();i++){
				obj = list.get(i);%>
	<table class="table" border="1">
		<tr>
			<td><%=obj.getIsbn() %></td>
			<td width=32%><%=obj.getTitle() %></td>
			<td><%=obj.getGenre() %></td>
			<td><%=obj.getPublisher() %></td>
			<td width=10%><%=obj.getStatus() %></td>
			<%String status=obj.getStatus(); %>
			<%if(status.contains("レンタル可")){ %>
			<td width=8%><button
					onclick="location.href='RentalForm.jsp?isbn=<%=obj.getIsbn() %>'"
					class="btn-square">申請</button> <%}else{ %>
			<td width=8%>申請不可</td>
			<%} %>
		</tr>
		<br>
	</table>

	<%}%>
			<%if(num==1){%>
				<nav class="cp_navi">
					<div class="cp_pagination">
						<span aria-current="page" class="cp_pagenum current">1</span>
						<a class="cp_pagenum" href="BookHome.jsp?param=2">2</a>
						<a class="cp_pagenum" href="BookHome.jsp?param=3">3</a>
						<a class="cp_pagenum" href="BookHome.jsp?param=4">4</a>
					</div>
				</nav>
			<%}%>

			<%if(num==2){%>
				<nav class="cp_navi">
					<div class="cp_pagination">
						<a class="cp_pagenum" href="BookHome.jsp?param=1">1</a>
						<span aria-current="page" class="cp_pagenum current">2</span>
						<a class="cp_pagenum" href="BookHome.jsp?param=3">3</a>
						<a class="cp_pagenum" href="BookHome.jsp?param=4">4</a>
					</div>
				</nav>
			<%}%>

			<%if(num==3){ %>
				<nav class="cp_navi">
					<div class="cp_pagination">
						<a class="cp_pagenum" href="BookHome.jsp?param=1">1</a>
						<a class="cp_pagenum" href="BookHome.jsp?param=2">2</a>
						<span aria-current="page" class="cp_pagenum current">3</span>
						<a class="cp_pagenum" href="BookHome.jsp?param=4">4</a>
					</div>
				</nav>
			<%} %>

			<%if(num==4){ %>
				<nav class="cp_navi">
					<div class="cp_pagination">
						<a class="cp_pagenum" href="BookHome.jsp?param=1">1</a>
						<a class="cp_pagenum" href="BookHome.jsp?param=2">2</a>
						<a class="cp_pagenum" href="BookHome.jsp?param=3">3</a>
						<span aria-current="page" class="cp_pagenum current">4</span>
					</div>
				</nav>
			<%} %>
	<%} %>
	<%}%>
</body>
</html>