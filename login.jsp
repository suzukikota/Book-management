<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理者ログイン</title>
<style>
	body {
		background-color:#ADD8E6;
					}
	a:hover {
			font-weight: bold;
					}
</style>
</head>

<body>
<h1>ログイン画面</h1>
<form action="ManagerLogin" method="post">
	<p>ID<br><input type="text" name="id"></p>
	<p>パスワード<br><input type="text" name="password"></p>
	<p><input type="submit" value="送信"></p>
</form>

<a href="BookHome.jsp" >書籍一覧</a>

</body>
</html>