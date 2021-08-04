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
	font-size: 25px;
		}
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
	/* 	リンクボタンの装飾 */
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
</style>

</head>

<body>
<h1>入力内容に誤りがあります。</h1>
<h1>もう一度入力してください。</h1>

<form action="ManagerLogin" method="post">
	<p>ID<br><input type="text" name="id" required></p>
	<p>パスワード<br><input type="text" name="password" required></p>
	<p><input type="submit" value="送信"></p>
</form>

<button onclick="location.href='BookHome.jsp'">閲覧用書籍一覧</button>
<br>
</body>
</html>