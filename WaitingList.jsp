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
<title>申請承認待ちリスト</title>
<style>
body{
	font-size:17px;
	text-align:center;
	background-color:rgba(220, 220, 220, 0.9);
	font-family: 'Noto Sans JP', sans-serif;
}
button:hover {
	border-bottom-color: transparent;
	transform: translateY(0.1em);
}
table {
	height: 40px;
	table-layout: fixed;
	width: 90%;
	margin-left: auto;
	margin-right: auto;
	background-color: #FFF;
	border-radius: 5px;
	border: solid 3px #6091d3;
}
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
.btn{
	text-align:left;
	left:300px;
	top:25px;
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
<%String param= request.getParameter("param"); %>
<%int offset; %>

<div class="btn">
	<button onclick="location.href='BookHome.jsp'">閲覧用書籍一覧</button>
	<button onclick="location.href='OkLogin.jsp'">管理用書籍一覧</button>
	<button onclick="location.href='EmployeeManagement.jsp'">社員管理</button>
</div>

<h2>書籍のレンタル・返却申請承認待ちリスト</h2>

<table class="table" border="1">
	<tr>
		<th>書籍番号</th>
		<th width=32%>書籍名</th>
		<th>申請者名</th>
		<th width=15%>ステータス</th>
		<th>レンタル・返却日</th>
		<th width=15%>承認ボタン</th>
	</tr>
</table>
	<%if(param==null){%>
	<%offset=0; %>
	<%List<BookBean> list=obj.Wating2();
		int total=list.size();%>
		<%session.setAttribute("total", total); %>
	<%List<BookBean> list2=obj.Wating(offset);
		for(int i=0;i<list2.size();i++){
			obj=list2.get(i);%>

	<table class="table" border="1">
		<tr>
			<td><%=obj.getIsbn() %></td>
			<td width=32%><%=obj.getTitle() %></td>
			<td><%=obj.getRental() %></td>
			<td width=15%><%=obj.getStatus() %></td>
			<td><%=obj.getBorrow_date() %></td>
			<%String encodeStr = URLEncoder.encode(obj.getTitle(), "utf-8");  %>
			<%if(obj.getStatus().equals("レンタル承認待ち")){%>
			<td width=15%><button onclick="location.href='SendRentalApproval?title=<%=encodeStr %>&btn=approval'" class="btn-square">承認</button>
				<button onclick="location.href='SendRentalApproval?title=<%=encodeStr %>&btn=rejection'" class="btn-square">否認</button>
			</td><%}else{%>
			<td width=15%><button onclick="location.href='SendReturnApproval?title=<%=encodeStr %>&btn=approval'" class="btn-square">承認</button>
				<button onclick="location.href='SendReturnApproval?title=<%=encodeStr %>&btn=rejection'" class="btn-square">否認</button>
			<%} %></td>
		</tr>
	</table>
	<%}%>
			<%if(total<11){%>
				<nav class="cp_navi">
				<div class="cp_pagination">
					<span aria-current="page" class="cp_pagenum current">1</span>
				</div>
				</nav>

			<%} %>

			<%if(total>=11 && total<21){%>
				<nav class="cp_navi">
				<div class="cp_pagination">
					<span aria-current="page" class="cp_pagenum current">1</span>
					<a class="cp_pagenum" href="WaitingList.jsp?param=2">2</a>
				</div>
				</nav>
			<%} %>

			<%if(total>=21 && total<31){%>
				<nav class="cp_navi">
				<div class="cp_pagination">
					<span aria-current="page" class="cp_pagenum current">1</span>
					<a class="cp_pagenum" href="WaitingList.jsp?param=2">2</a>
					<a class="cp_pagenum" href="WaitingList.jsp?param=3">3</a>
				</div>
				</nav>
			<%} %>

			<%if(total>=31 && total<41){%>
				<nav class="cp_navi">
				<div class="cp_pagination">
					<span aria-current="page" class="cp_pagenum current">1</span>
					<a class="cp_pagenum" href="WaitingList.jsp?param=2">2</a>
					<a class="cp_pagenum" href="WaitingList.jsp?param=3">3</a>
					<a class="cp_pagenum" href="WaitingList.jsp?param=4">4</a>
				</div>
				</nav>
			<%} %>
	<%}else if(param!=null){%>
		<%int num=Integer.parseInt(param); %>
		<%offset=10*(num-1); %>

		<%List<BookBean> list=obj.Wating(offset);
			for(int i=0;i<list.size();i++){
				obj=list.get(i);%>
	<table class="table" border="1">
		<tr>
			<td><%=obj.getIsbn() %></td>
			<td width=32%><%=obj.getTitle() %></td>
			<td><%=obj.getRental() %></td>
			<td width=15%><%=obj.getStatus() %></td>
			<td><%=obj.getBorrow_date() %></td>
			<%String encodeStr = URLEncoder.encode(obj.getTitle(), "utf-8");  %>
			<%if(obj.getStatus().equals("レンタル承認待ち")){%>
			<td width=15%><button onclick="location.href='SendRentalApproval?title=<%=encodeStr %>&btn=approval'" class="btn-square">承認</button>
				<button onclick="location.href='SendRentalApproval?title=<%=encodeStr %>&btn=rejection'" class="btn-square">否認</button>
			</td><%}else{%>
			<td width=15%><button onclick="location.href='SendReturnApproval?title=<%=encodeStr %>&btn=approval'" class="btn-square">承認</button>
				<button onclick="location.href='SendReturnApproval?title=<%=encodeStr %>&btn=rejection'" class="btn-square">否認</button>
			<%} %></td>
		</tr>
	</table>
			<%}%>
			<%int total=(int)session.getAttribute("total");%>
			<%if(num==1){%>
				<%if(total<11){%>
					<nav class="cp_navi">
						<div class="cp_pagination">
							<span aria-current="page" class="cp_pagenum current">1</span>
						</div>
					</nav>
				<%}%>
				<%if(total>=11 && total<21){%>
					<nav class="cp_navi">
						<div class="cp_pagination">
							<span aria-current="page" class="cp_pagenum current">1</span>
							<a class="cp_pagenum" href="WaitingList.jsp?param=2">2</a>
						</div>
					</nav>
				<%}%>
				<%if(total>=21 && total<31){%>
					<nav class="cp_navi">
						<div class="cp_pagination">
							<span aria-current="page" class="cp_pagenum current">1</span>
							<a class="cp_pagenum" href="WaitingList.jsp?param=2">2</a>
							<a class="cp_pagenum" href="WaitingList.jsp?param=3">3</a>
						</div>
					</nav>
				<%}%>
				<%if(total>=31 && total<41){%>
					<nav class="cp_navi">
						<div class="cp_pagination">
							<span aria-current="page" class="cp_pagenum current">1</span>
							<a class="cp_pagenum" href="WaitingList.jsp?param=2">2</a>
							<a class="cp_pagenum" href="WaitingList.jsp?param=3">3</a>
							<a class="cp_pagenum" href="WaitingList.jsp?param=4">4</a>
						</div>
					</nav>
				<%}%>
			<%}%>




			<%if(num==2){%>
				<%if(total>=11 && total<21){%>
					<nav class="cp_navi">
						<div class="cp_pagination">
							<a class="cp_pagenum" href="WaitingList.jsp?param=1">1</a>
							<span aria-current="page" class="cp_pagenum current">2</span>
						</div>
					</nav>
				<%}%>
				<%if(total>=21 && total<31){%>
					<nav class="cp_navi">
						<div class="cp_pagination">
							<a class="cp_pagenum" href="WaitingList.jsp?param=1">1</a>
						<span aria-current="page" class="cp_pagenum current">2</span>
							<a class="cp_pagenum" href="WaitingList.jsp?param=3">3</a>
						</div>
					</nav>
				<%}%>
				<%if(total>=31 && total<41){%>
					<nav class="cp_navi">
						<div class="cp_pagination">
							<a class="cp_pagenum" href="WaitingList.jsp?param=1">1</a>
						<span aria-current="page" class="cp_pagenum current">2</span>
							<a class="cp_pagenum" href="WaitingList.jsp?param=3">3</a>
							<a class="cp_pagenum" href="WaitingList.jsp?param=4">4</a>
						</div>
					</nav>
				<%}%>
			<%}%>

			<%if(num==3){ %>
				<%if(total>=21 && total<31){%>
					<nav class="cp_navi">
						<div class="cp_pagination">
							<a class="cp_pagenum" href="WaitingList.jsp?param=1">1</a>
							<a class="cp_pagenum" href="WaitingList.jsp?param=2">2</a>
							<span aria-current="page" class="cp_pagenum current">3</span>
						</div>
					</nav>
				<%}%>
				<%if(total>=31 && total<41){%>s
					<nav class="cp_navi">
						<div class="cp_pagination">
							<a class="cp_pagenum" href="WaitingList.jsp?param=1">1</a>
							<a class="cp_pagenum" href="WaitingList.jsp?param=2">2</a>
							<span aria-current="page" class="cp_pagenum current">3</span>
							<a class="cp_pagenum" href="WaitingList.jsp?param=4">4</a>
						</div>
					</nav>
				<%}%>
			<%}%>
	<%}%>
</body>
</html>