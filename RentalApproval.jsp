<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="java.util.*" %>
<%@ page import="bean.*" %>
<%@ page import="java.net.URLEncoder" %>
 <jsp:useBean id="obj" class="bean.BookBean"/>
 <jsp:useBean id="obj2" class="bean.Employee_InfoBean"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width,user-scalable=no,maximum-scale=1" />
<title>レンタルの承認</title>
<style>
/* 	body全体の装飾 */
	body{
		font-size: 20px;
		text-align: center;
		background-color:#ADD8E6;

	}
	/* 	レンタルフォームの装飾 */
	.rental{
		padding: 0.5em 1em;
		margin:2em;
		font-weight:bold;
		background:#FFF;
		border:solid 3px #6091d3;
		border-radius:10px;

/* 		位置を中心にする */
		position:fixed;
		left:50%;
		top:50%;
		transform:translateX(-50%)
				  translateY(-50%);
		}

	/* 	申請ボタンの装飾 */
	.btn-square{
		display:inline-block;
		padding:0.5em 1em;
		text-decoration:none;
		background:#668ad8;
		color:#FFF;
		border^bottom:solid 4px #627295;
		border-radius:3px;
		}

</style>
</head>
<body>

<div class="rental">
<h2>書籍レンタル承認画面</h2><br>

<form action="SendRentalApproval" method="post">
<p>申請者名:<select name="employee">
	<option value=<%=obj2.getName()%>>承認する申請者名を選択してください</option>
	<%List<Employee_InfoBean> list2 = obj2.Employee_InfoDBtoList2();
		for(int i=0;i<list2.size();i++){
			obj2=list2.get(i);%>
			<%=obj2.getName() %>
				<option value=<%=obj2.getName()%>><%=obj2.getName()%></option>
				<%} %>
			</select></p>
<input type="submit" value="承認ボタン" class="btn-square">
</form>
</div>

</body>
</html>