<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン失敗</title>
<style>
	h1{
	color: red;
	font-size: 20px;
	}
	body {

		background-color:#ADD8E6;
			}
	a:hover {
			font-weight: bold;
			}
</style>
</head>
<body>
<h1>入力内容に誤りがあります。</h1>
<h1>もう一度入力してください。</h1>
<form action="ManagerLogin" method="post">
	<p>ID<br><input type="text" name="id"></p>
	<p>パスワード<br><input type="text" name="password"></p>
	<p><input type="submit" value="送信"></p>
</form>

<a href="BookHome.jsp" >書籍一覧</a>
<br>
</body>
</html>