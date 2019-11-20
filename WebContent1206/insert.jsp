<%@ page info="insert" errorPage="subForm/error.jsp" %>
<%@ page contentType="text/html; charset=utf-8" %> 
<%@ page language="java" import="java.sql.*,java.text.*,java.util.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
	String userid	= request.getParameter("userid");
	String username	= request.getParameter("username");
	String password	= request.getParameter("password");
	String email	= request.getParameter("email");
	String zipcode1	= request.getParameter("zipcode1");
	String zipcode2	= request.getParameter("zipcode2");
	String zipcode	= zipcode1+"-"+zipcode2;
	String address1	= request.getParameter("address1");
	String address2	= request.getParameter("address2");
	String phone1 	= request.getParameter("phone1");
	String phone2 	= request.getParameter("phone2");
	String phone3 	= request.getParameter("phone3");
	String phone	= phone1+"-"+phone2+"-"+phone3;
	String query	= new String();
	Connection conn = null;
	ResultSet  rs	= null;
	PreparedStatement pstmt = null;
	
	java.util.Date yymmdd = new java.util.Date();
	SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:mm a");
	String regdate=myformat.format(yymmdd);

	try {
		Class.forName("com.mysql.jdbc.Driver");
	} catch (ClassNotFoundException e) {
		out.println(e);
	}

	try {
		conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/member?useUnicode=true&characterEncoding=utf-8", "root", "1111");
		query = "insert into member values ( ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		pstmt = conn.prepareStatement(query);
		pstmt.setString(1, userid);
		pstmt.setString(2, username);
		pstmt.setString(3, password);
		pstmt.setString(4, email);
		pstmt.setString(5, zipcode1 + "-" + zipcode2);
		pstmt.setString(6, address1);
		pstmt.setString(7, address2);
		pstmt.setString(8, phone1 + "-" + phone2 + "-" + phone3);
		pstmt.setString(9, regdate);
		pstmt.executeUpdate();
	} catch (SQLException e) {
		out.println("<script>alert('가입처리가 되지 않았습니다. 다시 시도해 주세요.'); history.back();</script>");
	} finally {
		conn.close();
	}
%>

<html>
	<head>
	<title>가입 완료</title>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="StyleSheet" href="style.css" type="text/css">
	<script>
	
	function doSubmit() {
		form = document.join;
		if (!form.userid.value) {
			alert('아이디를 입력하지 않았습니다.');
			form.userid.focus();
			return;
		}
		location.href = "MainForm.jsp?contentPage=select_modfiy.jsp";
	}
	
	</script>
	</head>

<body>
	<br>
	<br>
	<form name="join" method="post" action="modify.jsp">
		<input type=hidden name="userid" value="<%=userid%>"> 
		<input type=hidden name="mode" value="modify">
		<p>	가입을 축하드립니다. 입력하신	내용을 확인하세요. </p>
		
		아이디 	: <%=userid %>	</br></br>
		이름 	: <%=username %> </br></br>
		비밀번호 	: 보안상 기재하지 않습니다. </br></br>
		E-MAIL 	: <%=email %> </br></br>
		우편번호 	: <%=zipcode1 + "-" + zipcode2%> </br></br>
		주소1 	: <%=address1%>
		주소2 	: <%=address2%> </br></br>
		휴대폰 	: 
				<%
					if (phone.equals("--")) {
						out.println("선택하지 않았습니다.");
					} else {
						out.println(phone);
					}
				%>
				
		<input type="button" value="확   인" onClick="location='MainForm.jsp'"> 
		<input type="button" value="수   정" onClick="doSubmit()">
	</form>
</body>
</html>