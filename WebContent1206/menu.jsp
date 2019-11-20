<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<script>
		
		function switchMenuPage( index )
		{
			switch( index )
			{
			case 0:
				location.href = "MainForm.jsp";
				break;
			case 1:
				location.href = "MainForm.jsp?contentPage=dbgb_show.jsp";
				break;
			case 2:
				location.href = "freeboardForm.jsp?contentPage=freeboard_list.jsp";
				break;
			case 3:
				{
					<%
						String session_id = (String)session.getAttribute("member_id");
						if( session_id != null ){
					%>
						location.href = "freeboardForm.jsp?contentPage=databoard_list.jsp";
					<% }else{%>
						alert("로그인을 하세요!");
						location.href = "MainForm.jsp";
					<% }%>
				}
				break;
			case 4:
				location.href = "freeboardForm.jsp?contentPage=index.jsp";
				break;
			}			
		}
		
		</script>
	</head>
	
	<body>
	<div id="menu">
		<ul>
			<li><a href="javascript:switchMenuPage(0)">Home</a></li>
			<li><a href="javascript:switchMenuPage(1);">방명록</a></li>
			<li><a href="javascript:switchMenuPage(2);">게시판</a></li>
			<li><a href="javascript:switchMenuPage(3);">자료실</a></li>
			<li><a href="javascript:switchMenuPage(4);">MiniGame</a></li>
		</ul>
	</div>
		
	
	</body>
</html>