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

<script type="text/javascript">
function check(){

	if(window.confirm('削除してよろしいですか？')){ // 確認ダイアログを表示
		return true; // 「OK」時は送信を実行
	}
	else{ // 「キャンセル」時の処理
		window.alert('キャンセルされました'); // 警告ダイアログを表示
		return false; // 送信を中止
	}

}
</script>

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
		height:20px;
		width:100%;
		table-layout:fixed;
		background:#FFF;
		border-radius:10px;
		margin-left: auto;
  	    margin-right: auto;/*中央揃え*/
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
		left: 340px;
		}


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

		.cp_navi .cp_pagenum.prev,
		.cp_navi .cp_pagenum.next {
			padding: 0 10px;
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

		.cp_navi .cp_pagenum.prev,
		.cp_navi .cp_pagenum.next {
			padding: 0 5px;
			}
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

		String param = request.getParameter("param");
		if(param == null){
			param = "1";
		}

		int offset=0; %>

<button onclick="location.href='BookHome.jsp'">閲覧用書籍一覧</button>
<button onclick="location.href='EmployeeManagement.jsp'">社員管理</button>
<button onclick="location.href='WaitingList.jsp'">承認待ちリスト</button>

<form action="OkRental.jsp" method="POST">
<div style="display:inline-flex">
    <p>書籍番号<br><input type="text" name="isbn" pattern="\d{13}" title="13桁の半角数字"  required></p>
	<p>書籍名<br><input type="text" name="title" required></p>
	<p>ふりがな<br><input type="text" name="yomi" pattern="[^一-龥]{2,}" title="2文字以上の英数字、平仮名" required></p>
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
		<option value="レンタル可">レンタル可</option>
	</select></p>
	</div>
	<br>
	<input type="submit" name ="btn" value="追 加">
<button onclick="location.href='OkLogin.jsp'" class="btn-rental">レンタル中書籍</button>
<button onclick="location.href='OkRental.jsp'" class="btn-rental">レンタル可能書籍</button>
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
      <th width="13%">出版社</th>
      <th width="12%">ステータス</th>
      <th width="10%">借用者</th>
      <th width="10%">レンタル日<br>返却日</th>
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
      <td width="13%"><%= obj.getPublisher() %></td>
      <td width="12%">
		<form action="OkLogin.jsp" method="POST">
			<select name="changes">
			  		<option value=<%= obj.getStatus() %>><%= obj.getStatus() %></option>
				<%String status2 = (obj.getStatus());%>
		        <%if(status2.contains("レンタル中")){%>
		       		<option value="レンタル可">レンタル可</option>
			        <%}else if(status2.contains("返却承認待ち")){%>
			        	<option value="レンタル可">レンタル可</option>
				        <%}else if(status2.contains("レンタル承認待ち")){%>
				       		<option value="レンタル中">レンタル中</option>
				   	    <%}%>
		   	</select>
		   	<input type="hidden" name ="title" value ="<%=obj.getTitle()%>">
			<input type="submit" name ="btn" value="更新">
		</form>
	  </td>
      <td width="10%"><%= obj.getRental() %></td>
      <td width="10%"><%= obj.getBorrow_date() %></td>
      <td width="5%">
          <%String encodeStr = URLEncoder.encode(obj.getTitle(), "utf-8");  %>
	      <form method="POST" action="OkLogin.jsp?LinkTitle=<%=encodeStr %>&btn=delete" onSubmit="return check()">
		  <button type="submit" value="送信">削除</button>
	      </form>
      </td>
<% } %>
   </tr>
 </table>
	<%} %>

		<% if(keyword == null){
			if(param!=null){
	  			 int num=Integer.parseInt(param);
	  			 offset=30*(num-1); %>

<table class="table" border="1">
 <tr>
      <th width="15%">ISBN</th>
      <th width="30%">書籍名</th>
      <th width="10%">ジャンル</th>
      <th width="13%">出版社</th>
      <th width="12%">ステータス</th>
      <th width="10%">借用者</th>
      <th width="10%">レンタル日<br>返却日</th>
      <th width="5%">削除</th>
 </tr>
 </table>
<%
List<BookBean> list = obj.BookBeanDBtoList3(btn,request.getParameter("linkTitle"),request.getParameter("isbn"),request.getParameter("title"),request.getParameter("genre"),request.getParameter("publisher"),request.getParameter("status"),request.getParameter("employee"),request.getParameter("borrow_date"),request.getParameter("yomi"),request.getParameter("changes"),offset);
for(int i = 0; i < list.size(); i++){
obj = list.get(i);
%>
<table class="table" border="1">
 <tr>
      <td width="15%"><%= obj.getIsbn() %></td>
      <td width="30%"><%= obj.getTitle() %></td>
      <td width="10%"><%= obj.getGenre() %></td>
      <td width="13%"><%= obj.getPublisher() %></td>
      <td width="12%">
		<form action="OkRental.jsp" method="POST">
			<select name="changes">
			  		<option value=<%= obj.getStatus() %>><%= obj.getStatus() %></option>
				<%String status2 = (obj.getStatus());%>
		        <%if(status2.contains("レンタル中")){%>
		       		<option value="レンタル可">レンタル可</option>
			        <%}else if(status2.contains("返却承認待ち")){%>
			        	<option value="レンタル可">レンタル可</option>
				        <%}else if(status2.contains("レンタル承認待ち")){%>
				       		<option value="レンタル中">レンタル中</option>
				   	    <%}%>
		   	</select>
		   	<input type="hidden" name ="title" value ="<%=obj.getTitle()%>">
			<input type="submit" name ="btn" value="更新">
		</form>
	  </td>
      <td width="10%"><%= obj.getRental() %></td>
      <td width="10%"><%= obj.getBorrow_date() %></td>
     <td width="5%">
          <%String encodeStr = URLEncoder.encode(obj.getTitle(), "utf-8");  %>
	      <form method="POST" action="OkLogin.jsp?LinkTitle=<%=encodeStr %>&btn=delete" onSubmit="return check()">
			<button type="submit" value="送信">削除</button>
	      </form>
      </td>
   </tr>
 </table>
<%}%>

			<%if(num==1){%>
							<nav class="cp_navi">
								<div class="cp_pagination">
									<span aria-current="page" class="cp_pagenum current">1</span>
									<a class="cp_pagenum" href="OkRental.jsp?param=2">2</a>
									<a class="cp_pagenum" href="OkRental.jsp?param=3">3</a>
									<a class="cp_pagenum" href="OkRental.jsp?param=4">4</a>
									<a class="cp_pagenum" href="OkRental.jsp?param=5">5</a>
								</div>
							</nav>
						<%}%>

			<%if(num==2){%>
				<nav class="cp_navi">
					<div class="cp_pagination">
						<a class="cp_pagenum" href="OkRental.jsp?param=1">1</a>
						<span aria-current="page" class="cp_pagenum current">2</span>
						<a class="cp_pagenum" href="OkRental.jsp?param=3">3</a>
						<a class="cp_pagenum" href="OkRental.jsp?param=4">4</a>
						<a class="cp_pagenum" href="OkRental.jsp?param=5">5</a>
					</div>
				</nav>
			<%}%>

			<%if(num==3){ %>
				<nav class="cp_navi">
					<div class="cp_pagination">
						<a class="cp_pagenum" href="OkRental.jsp?param=1">1</a>
						<a class="cp_pagenum" href="OkRental.jsp?param=2">2</a>
						<span aria-current="page" class="cp_pagenum current">3</span>
						<a class="cp_pagenum" href="OkRental.jsp?param=4">4</a>
						<a class="cp_pagenum" href="OkRental.jsp?param=5">5</a>
					</div>
				</nav>
			<%} %>

			<%if(num==4){ %>
				<nav class="cp_navi">
					<div class="cp_pagination">
						<a class="cp_pagenum" href="OkRental.jsp?param=1">1</a>
						<a class="cp_pagenum" href="OkRental.jsp?param=2">2</a>
						<a class="cp_pagenum" href="OkRental.jsp?param=3">3</a>
						<span aria-current="page" class="cp_pagenum current">4</span>
						<a class="cp_pagenum" href="OkRental.jsp?param=5">5</a>
					</div>
				</nav>
			<%} %>

			<%if(num==5){ %>
				<nav class="cp_navi">
					<div class="cp_pagination">
						<a class="cp_pagenum" href="OkRental.jsp?param=1">1</a>
						<a class="cp_pagenum" href="OkRental.jsp?param=2">2</a>
						<a class="cp_pagenum" href="OkRental.jsp?param=3">3</a>
						<a class="cp_pagenum" href="OkRental.jsp?param=4">4</a>
						<span aria-current="page" class="cp_pagenum current">5</span>
					</div>
				</nav>
			<%} %>
     <%} %>
 <%} %>
</body>
</html>




