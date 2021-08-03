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
		text-align:center;
					}
	a:hover {
			font-weight: bold;
					}
	button{
		display:inline-block;
		padding:0.5em 1em;
		text-decoration:none;
		background:#668ad8;
		color:#FFF;
		border-bottom:solid 4px #627295;
		border-radius:3px;
		right:150px;
		top:40px;
		}
</style>
</head>

<body>
<h1>ログイン画面</h1>
<form action="ManagerLogin" method="post">
	<p>ID<br><input type="text" name="id" required></p>
	<p>パスワード<br><input type="text" name="password" required></p>
	<p><input type="submit" value="送信"></p>
</form>

<br>
<button  onclick="location.href='BookHome.jsp'">閲覧用書籍一覧</button>

</body>
</html>