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
<title>返却の承認</title>
<style>
	body{
		font-size: 17px;
		text-align: center;
		background-color:rgba(220,220,220,0.9);
		font-family: 'Noto Sans JP', sans-serif;
		}
	.return{
		padding: 0.5em 1em;
@@ -32,15 +33,15 @@
				  translateY(-50%);
	}

	.btn-square2{
		display:inline-block;
		padding:0.5em 1em;
		text-decoration:none;
		background:#668ad8;
		color:#000000;
		border-bottom:solid 4px #627295;
		border-radius:10px;
		font-family: 'Noto Sans JP', sans-serif;
		}
	.btn-square2:hover{
		border-bottom-color:transparent;
		transform: translateY(0.1em);
		}
</style>
</head>

<body>
<div class="return">
<h2>書籍返却承認画面</h2><br>

<form action="SendReturnApproval" method="post">
	<p>申請者名:<select name="employee">

		<option value=<%=obj2.getName()%>>承認する申請者名を選択してください</option>
			<%List<Employee_InfoBean> list2 = obj2.Employee_InfoDBtoList2();
				for(int i=0;i<list2.size();i++){
					obj2=list2.get(i);%>
					<%=obj2.getName() %>
						<option value=<%=obj2.getName()%>><%=obj2.getName()%></option>
							<%} %>
								</select></p>
<input type="submit" value="承認ボタン" class="btn-square2">
</form>
</div>
</body>
</html>