<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>

<%
    String admPwd = "1111";
 	String password = request.getParameter("password");
 	if (admPwd.equals(password))
 	{
 		%><script>location.replace("MainForm.jsp?contentPage=select_all.jsp");</script><%
 	}
 	else
 	{
 		%><script>alert("관리자 비밀번호가 틀렸습니다.");</script><%
 	}
%>