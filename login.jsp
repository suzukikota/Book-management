<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>管理者ログイン</title>
<style>
	body {
		background-color:rgba(220,220,220,0.9);
		text-align:center;
		font-size:20px;
		font-weight:600;
		font-family: 'Noto Sans JP', sans-serif;
					}
	button:hover {
			border-bottom-color:transparent;
			transform:translateY(0.1em);
					}
	button{
		display:inline-block;
		padding:0.5em 1em;
		text-decoration:none;
		font-size:15px;
		font-weight:570;
		background:#668ad8;
		color:#000000;
		border-bottom:solid 4px #627295;
		border-radius:3px;
		right:150px;
		top:40px;
		font-family: 'Noto Sans JP', sans-serif;
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