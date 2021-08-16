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
	width: 80%;
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


</style>
</head>
<body>
<h2>(仮)書籍のレンタル・返却申請承認待ちリスト</h2>

<table class="table" border="1">
	<tr>
		<th>書籍番号</th>
		<th width=32%>書籍名</th>
		<th>申請者名</th>
		<th width=10%>ステータス</th>
		<th>レンタル・返却日</th>
		<th width=10%>承認ボタン</th>
	</tr>
</table>

	<%List<BookBean> list=obj.Wating();
		for(int i=0;i<list.size();i++){
			obj=list.get(i);%>
	<table class="table" border="1">
		<tr>
			<td><%=obj.getIsbn() %></td>
			<td width=32%><%=obj.getTitle() %></td>
			<td><%=obj.getRental() %></td>
			<td width=10%><%=obj.getStatus() %></td>
			<td><%=obj.getBorrow_date() %></td>
			<td width=10%><button onclick="location.href='SendRentalApproval?isbn=<%=obj.getIsbn() %>&btn=approval'" class="btn-square">承認</button>
				<button onclick="location.href='SendRentalApproval?isbn=<%=obj.getIsbn() %>&btn=rejection'" class="btn-square">拒否</button>
			</td>
			<%}%>
	</table>

</body>
</html>