<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" import="java.io.*,java.sql.*,java.util.*"%>
<HTML>
<HEAD>
<SCRIPT language="javascript">
	function check() {
		with (document.msgrewrite) {
			if (subject.value.length == 0) {
				alert("제목을 입력해 주세요!!");
				subject.focus();
				return false;
			}
			if (name.value.length == 0) {
				alert("이름을 입력해 주세요!!");
				name.focus();
				return false;
			}
			if (password.value.length == 0) {
				alert("비밀번호를 입력해 주세요!!");
				password.focus();
				return false;
			}
			if (content.value.length == 0) {
				alert("내용을 입력해주세요!!");
				content.focus();
				return false;
			}
			document.msgrewrite.submit();
		}
	}
</SCRIPT>
<meta charset="utf-8">
<link href="databoard.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
	<P>
		<%
			String sqltext = null;
			Connection conn = null;
			Statement st = null;
			ResultSet rs = null;
			int pos = 0;
			String sub = null;
			String cont = null;
			int step = 0;
			int rnum = 0;
			int mid = 0;
			int id = Integer.parseInt(request.getParameter("id"));

			try {
				Class.forName("org.gjt.mm.mysql.Driver");
			} catch (ClassNotFoundException e) {
				out.println(e);
			}

			try {
				conn = java.sql.DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/member?useUnicode=true&characterEncoding=utf-8", "root", "1111");
			} catch (java.sql.SQLException e) {
				out.println(e);
			}

			try {
				sqltext = "select * from databoard where id=" + id;
				st = conn.createStatement();
				rs = st.executeQuery(sqltext);
				if (!(rs.next())) {
					out.println("해당 내용이 없습니다");
				} else {
					cont = ">" + rs.getString("content");
					while ((pos = cont.indexOf("\n", pos)) != -1) {
						String left = cont.substring(0, pos + 1);
						String right = cont.substring(pos + 1, cont.length());
						cont = left + "> " + right;
						pos += 2;
					}
					mid = rs.getInt("masterid");
					rnum = rs.getInt("replynum");
					step = rs.getInt("step");
		%>
	
	<FORM name="msgrewrite" method=post
		action="databoard_rsave.jsp?id=<%=id%>&page=<%=request.getParameter("page")%>"
		enctype="multipart/form-data">
		<CENTER>
			<table width="600" cellspacing="0" cellpadding="2">
				<tr>
					<td colspan="2" bgcolor="#1F4F8F" height="1"></td>
				</tr>
				<tr>
					<td colspan="2" bgcolor="#DFEDFF" height="20" class="notice">&nbsp;&nbsp;<font
						size="2">다시 쓰기</font></td>
				</tr>
				<tr>
					<td colspan="2" bgcolor="#1F4F8F" height="1"></td>
				</tr>
				<tr>
					<td width="124" height="30" bgcolor="#f4f4f4"
						style="padding: 0 0 0 14">
						<div align="center">
							<font size="2">이 름</font>
						</div>
					</td>
					<td width="494" style="padding: 0 0 0 10"><input type=text
						name=name></td>
				</tr>
				<tr>
					<td width="124" bgcolor="#f4f4f4" style="padding: 0 0 0 14">
						<div align="center">
							<font size="2">E-mail</font>
						</div>
					</td>
					<td width="494" style="padding: 0 0 0 10" height="25"><input
						type=text name=email></td>
				</tr>
				<tr>
					<td width="124" bgcolor="#f4f4f4" style="padding: 0 0 0 14">
						<div align="center">
							<font size="2">제 목</font>
						</div>
					</td>
					<td width="494" style="padding: 0 0 0 10" height="25"><input
						type=text name=subject size="60"
						value="Re :<%=rs.getString("subject")%>"></td>
				</tr>
				<tr>
					<td width="124" height="162" bgcolor="#f4f4f4"
						style="padding: 7 0 0 14" valign="top">
						<div align="center">
							<font size="2">내 용</font>
						</div>
					</td>
					<td width="494" valign="top" style="padding: 5 0 5 10"><textarea
							cols="65" rows="10" name=content>
          
-----------------------------------------------------------------
   <%=cont%></textarea></td>
				</tr>
				<tr>
					<td width="124" bgcolor="#f4f4f4" style="padding: 0 0 0 14">
						<div align="center">첨부파일</div>
					</td>
					<td width="494" style="padding: 0 0 0 10" height="25"><input
						type="file" name="file" size=30></td>
				</tr>
				<tr>
					<td width="124" bgcolor="#f4f4f4" style="padding: 0 0 0 14">
						<div align="center">
							<font size="2">암 호</font>
						</div>
					</td>
					<td width="494" style="padding: 0 0 0 10" height="25"><input
						type=password name=password><br>(정확한 비밀번호를 입력해야만 수정이
						됩니다.)</td>
				</tr>
				<tr>
					<td colspan="2" height="1" class='button'></td>
				</tr>
				<tr>
					<td colspan="2" height="1" bgcolor="#1F4F8F"></td>
				</tr>
				<tr>
					<td colspan="2" height="10"></td>
				</tr>
				<tr>
					<td colspan="2" align="right">
						<table width="100%" border="0" cellpadding="0" cellspacing="0">
							<tr>
								<td width="28%">&nbsp;</td>
								<td width="51%">&nbsp;</td>
								<td width="12%"><a href="#" onClick="history.go(-1)"><img
										src="image/cancle.gif" width="56" height="21" border="0"></td>
								<td width="9%"><a href="#" onClick="check();"><img
										src="image/ok.gif" width="56" height="21" border="0"></a></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</CENTER>
		<input type="hidden" name="page"
			value="<%=request.getParameter("page")%>"> <input
			type="hidden" name="step" value="<%=step%>"> <input
			type="hidden" name="mid" value="<%=mid%>"> <input
			type="hidden" name="rnum" value="<%=rnum%>">
	</FORM>
	<%
  }
  rs.close();
  st.close();
  conn.close();
 } catch (java.sql.SQLException e) {
  out.println(e);
 } 
%>
</BODY>
</HTML>