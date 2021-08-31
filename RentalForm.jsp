<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%@ page import="java.util.*"%>
<%@ page import="bean.*"%>
<%@ page import="java.net.URLEncoder"%>

<jsp:useBean id="obj" class="bean.BookBean" />
<jsp:useBean id="obj2" class="bean.Employee_InfoBean" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width,user-scalable=no,maximum-scale=1" />
<title>レンタル申請ページ</title>

<script type="text/javascript">
function check(){
	if(window.confirm('レンタルの申請をしてもよろしいですか？'+'\r\n'+'申請内容に誤りがないかご確認下さい。')){ // 確認ダイアログを表示
		return true; // 「OK」時は送信を実行
	}
	else{ // 「キャンセル」時の処理
		window.alert('キャンセルされました'); // 警告ダイアログを表示
		return false; // 送信を中止
	}
}
</script>

<style>
/* 	body全体の装飾 */
body {
	font-size: 17px;
	text-align: center;
	background-color: rgba(220, 220, 220, 0.9);
	font-family: 'Noto Sans JP', sans-serif;
}
/* 	レンタルフォームの装飾 */
.rental {
	padding: 0.5em 1em;
	margin: 2em;
	font-weight: bold;
	background: #FFF;
	border: solid 3px #6091d3;
	border-radius: 10px;
	/* 		フォームの位置を中心にする */
	position: fixed;
	left: 50%;
	top: 50%;
	transform: translateX(-50%) translateY(-50%);
}
/* 	申請ボタンの装飾 */
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
</style>
</head>
<body>
	<button class="btn-square" onclick="location.href='BookHome.jsp'">閲覧用書籍一覧</button>
	<!-- 	選択された書籍のISBNを取得 -->
	<%
		String isbn = request.getParameter("isbn");
		session.setAttribute("isbn", isbn);
	%>

	<!--	取得した書籍のISBNを引数として、ISBNと一致する書籍名を取得する。 -->
	<div class="rental">

		<!-- 	今日の日付を取得 -->
		<%
			Date dateObj = new Date();
			SimpleDateFormat sdf = new SimpleDateFormat();
			sdf.applyPattern("yyyy-MM-dd");
			String display = sdf.format(dateObj);
		%>

		<%
			List<BookBean> list = obj.Rental(isbn);
			for (int i = 0; i < list.size(); i++) {
				obj = list.get(i);
		%>
		<%
			}
		%>
		<h2>書籍レンタル申請画面</h2>
		<br>

		<form action="SendRentalMail" method="post" onSubmit="return check()">
			<p>
				申請者名:<select name="employee">
					<%
						List<Employee_InfoBean> list2 = obj2.Employee_InfoDBtoList2();
						for (int j = 0; j < list2.size(); j++) {
							obj2 = list2.get(j);
					%>
					<option value="<%=obj2.getName()%>"><%=obj2.getName()%></option>
					<%
						}
					%>
				</select>
			</p>

			<p>
				書籍番号:
				<%=obj.getIsbn()%></p>
			<p>
				書籍名:<%=obj.getTitle()%></p>
			<%
				session.setAttribute("Title", obj.getTitle());
			%>
			<p>レンタル予定日</p>
			<input required type="date" name="rental" min=<%=display%>> <input
				type="submit" value="申請ボタン" class="btn-square">
		</form>
		申請後に数日経っても承認又は否認のメールが届かない場合は、<br>
		お手数ですが、総務までご連絡をお願いいたします。
	</div>
</body>
</html>