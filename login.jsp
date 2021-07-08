<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
ログイン画面
<form action="ManagerLogin" method="post">
	<p>ID<input type="text" name="id"></p>
	<p>パスワード<input type="text" name="password"></p>
	<p><input type="submit" value="送信"></p>
</form>
<a href="BookHome.html" >書籍管理ホームに戻る</a>
</body>
</html>