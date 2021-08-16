<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="java.util.*"%>
<%@ page import="bean.*"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.text.SimpleDateFormat"%>
<jsp:useBean id="obj" class="bean.BookBean" />
<jsp:useBean id="obj2" class="bean.Employee_InfoBean" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,user-scalable=no,maximum-scale=1" />
<title>返却申請ページ</title>
<style>
body {
	font-size: 17px;
	text-align: center;
	background-color: rgba(220, 220, 220, 0.9);
}

.return {
	padding: 0.5em 1em;
	margin: 2em;
	font-weight: bold;
	background: #FFF;
	border: solid 3px #6091d3;
	border-radius: 10px;
	position: fixed;
	left: 50%;
	top: 50%;
	transform: translateX(-50%) translateY(-50%);
}

.btn-square {
	display: inline-block;
	padding: 0.5em 1em;
	text-decoration: none;
	background: #668ad8;
	color: #000000;
	border-bottom: solid 4px #627295;
	border-radius: 10px;
	font-family: 'Noto Sans JP', sans-serif;
}

.btn-square:hover {
	border-bottom-color: transparent;
	transform: translateY(0.1em);
}

.btn-square2 {
	display: inline-block;
	padding: 0.5em 1em;
	text-decoration: none;
	background: #668ad8;
	color: #000000;
	border-bottom: solid 4px #627295;
	border-radius: 10px;
	font-family: 'Noto Sans JP', sans-serif;
}

.btn-square2:hover {
	border-bottom-color: transparent;
	transform: translateY(0.1em);
}
</style>
</head>

<body>
<!-- 	今日の日付を取得 -->
		<%
			Date dateObj = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat();
			sdf.applyPattern("yyyy-MM-dd");
			String display = sdf.format(dateObj);
		%>
	<div class="return">
		<h2>書籍返却申請画面</h2>
		<form action="#" method="post">
			<!-- 		フォームの送り先は一旦#で保留 -->
			<p>
				書籍番号:<input type="text" name="isbn" placeholder="例1234567891234"
					pattern="\d{13}" title="13桁の数字で入力してください">
				<!-- 	入力しされたisbn(書籍番号)を取得し、そのisbnを基に書籍名の取得 -->
				<%
					String isbn = request.getParameter("isbn");
				%>
				<%
					session.setAttribute("isbn", isbn);
				%>
				<button name="auto"
					onclick="location.href='ReturnForm.jsp?isbn=<%=isbn%>'"
					class="btn-square2">書籍名の取得</button>
			</p>
		</form>

		<form action="SendReturnMail" method="post">
			<%
				List<BookBean> list = obj.Rental(isbn);
				for (int i = 0; i < list.size(); i++) {
					obj = list.get(i);
			%>
			<p>
				申請者名:<select name="employee">

					<%
						List<Employee_InfoBean> list2 = obj2.Employee_InfoDBtoList2();
							for (int j = 0; j < list2.size(); j++) {
								obj2 = list2.get(j);
					%>
					<%=obj2.getName()%>
					<option value=<%=obj2.getName()%>><%=obj2.getName()%></option>
					<%
						}
					%>
				</select>
			</p>
			<p>
				書籍番号:<%=obj.getIsbn()%></p>
			<p>
				書籍名:<%=obj.getTitle()%></p>
			<%
				session.setAttribute("Title", obj.getTitle());
			%>
			<p>返却予定日</p>
			<input required type="date" name="return" min=<%=display%>><br>
			<br> <input type="submit" value="申請ボタン" class="btn-square">
		</form>
		<%} %>
	</div>
</body>
</html>