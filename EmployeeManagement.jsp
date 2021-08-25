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
		text-align:center;
		font-family: 'Noto Sans JP', sans-serif;
			}
	button:hover {
			border-bottom-color:transparent;
			transform:translateY(0.1em);
			}
	table{
		height:20px;
		width:60%;
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

	.mail-form{
		width:200%;
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
<button onclick="location.href='BookHome.jsp'">閲覧用書籍一覧</button>
<button onclick="location.href='OkLogin.jsp'">書籍管理</button>

<%	String employee_id = request.getParameter("employee_id");
		if(employee_id == null){
			employee_id = "";
		}
	String name = request.getParameter("name");
		if(name == null){
			name = "";
		}
	String mail = request.getParameter("mail");
		if(mail == null){
			mail = "";
		}

	String param = request.getParameter("param");
		if(param == null){
			param = "1";
	}

	int offset=0; %>

	<form action="EmployeeManagement.jsp" method="POST">
		<div style="display:inline-flex">
			<p>社員番号<br><input type="text" name="employee_id" pattern="\d{6}" title="6桁の数字" required></p>
			<p>氏名<br><input type="text" name="name" required></p>
			<p>メールアドレス<br><input type="email" name="mail" class = "mail-form" value="@sakura-communication.co.jp" required></p>
			</div><br>
			<p><input type="submit" name ="btn" value="追加"></p>

	</form>


	<% if(param!=null){
	   int num=Integer.parseInt(param);
	   offset=30*(num-1); %>
	<br>
	<br>

	<table class="table" border="1">
	 <tr>
	      <th width="13%">社員番号</th>
	      <th width="30%">氏名</th>
	      <th width="60%">メールアドレス</th>
	      <th width="10%">削除</th>
	 </tr>

<%
String btn = request.getParameter("btn");
if(btn == null){
	btn = "";
}

List<Employee_InfoBean> list = obj.Employee_InfoDBtoList(request.getParameter("linkEmployee_id"),request.getParameter("employee_id"),request.getParameter("name"),request.getParameter("mail"),btn,offset);
for(int i = 0;i < list.size();i++){
obj = list.get(i);
%>
	  <tr>
		<td width="13%"><%= obj.getEmployee_id() %></td>
		<td width="30%"><%= obj.getName() %></td>
		<td width="60%"><%= obj.getMail() %></td>
		<td width="10%">
			<form method="POST" action="EmployeeManagement.jsp?linkEmployee_id=<%= obj.getEmployee_id() %>&btn=delete" onSubmit="return check()">
			<button type="submit" value="送信" >削除</button>
			</form>
	    </td>
	  </tr>
	   <%}%>
	</table>

			<%if(num==1){%>
				<nav class="cp_navi">
					<div class="cp_pagination">
						<span aria-current="page" class="cp_pagenum current">1</span>
						<a class="cp_pagenum" href="EmployeeManagement.jsp?param=2">2</a>
						<a class="cp_pagenum" href="EmployeeManagement.jsp?param=3">3</a>
						<a class="cp_pagenum" href="EmployeeManagement.jsp?param=4">4</a>
						<a class="cp_pagenum" href="EmployeeManagement.jsp?param=5">5</a>
					</div>
				</nav>
			<%}%>




			<%if(num==2){%>
				<nav class="cp_navi">
					<div class="cp_pagination">
						<a class="cp_pagenum" href="EmployeeManagement.jsp?param=1">1</a>
						<span aria-current="page" class="cp_pagenum current">2</span>
						<a class="cp_pagenum" href="EmployeeManagement.jsp?param=3">3</a>
						<a class="cp_pagenum" href="EmployeeManagement.jsp?param=4">4</a>
						<a class="cp_pagenum" href="EmployeeManagement.jsp?param=5">5</a>

					</div>
				</nav>
			<%}%>

			<%if(num==3){ %>
				<nav class="cp_navi">
					<div class="cp_pagination">
						<a class="cp_pagenum" href="EmployeeManagement.jsp?param=1">1</a>
						<a class="cp_pagenum" href="EmployeeManagement.jsp?param=2">2</a>
						<span aria-current="page" class="cp_pagenum current">3</span>
						<a class="cp_pagenum" href="EmployeeManagement.jsp?param=4">4</a>
						<a class="cp_pagenum" href="EmployeeManagement.jsp?param=5">5</a>

					</div>
				</nav>
			<%} %>

			<%if(num==4){ %>
				<nav class="cp_navi">
					<div class="cp_pagination">
						<a class="cp_pagenum" href="EmployeeManagement.jsp?param=1">1</a>
						<a class="cp_pagenum" href="EmployeeManagement.jsp?param=2">2</a>
						<a class="cp_pagenum" href="EmployeeManagement.jsp?param=3">3</a>
						<span aria-current="page" class="cp_pagenum current">4</span>
						<a class="cp_pagenum" href="EmployeeManagement.jsp?param=5">5</a>

					</div>
				</nav>
			<%} %>

			<%if(num==5){ %>
				<nav class="cp_navi">
					<div class="cp_pagination">
						<a class="cp_pagenum" href="EmployeeManagement.jsp?param=1">1</a>
						<a class="cp_pagenum" href="EmployeeManagement.jsp?param=2">2</a>
						<a class="cp_pagenum" href="EmployeeManagement.jsp?param=3">3</a>
						<a class="cp_pagenum" href="EmployeeManagement.jsp?param=4">4</a>
						<span aria-current="page" class="cp_pagenum current">5</span>

					</div>
				</nav>
			<%} %>

	<%} %>
</body>
</html>

