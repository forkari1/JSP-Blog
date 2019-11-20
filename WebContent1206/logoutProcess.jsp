<%@ page info="logout" errorPage="subForm/error.jsp" %>
<%@ page contentType="text/html; charset=utf-8" %> 
<%@ page language="java" import="java.io.*,java.text.*" %>
<%
	session.invalidate();
%>

<script>
	parent.location.href="MainForm.jsp";

</script>