<%@ page contentType="text/html; charset=utf-8" %> 
<%@ page language="java" import="java.sql.*,java.util.*" %> 
<% request.setCharacterEncoding("utf-8"); %>
<HTML>
<head>
<link href="filegb.css" rel="stylesheet" type="text/css">
	<script>
		
	</script>
</head>
<BODY>
 <CENTER>
		<%
			Vector name = new Vector();
			Vector email = new Vector();
			Vector inputdate = new Vector();
			Vector subject = new Vector();
			Vector content = new Vector();

			int where = 1;
			int totalgroup = 0;
			int maxpages = 2;
			int startpage = 1;
			int endpage = startpage + maxpages - 1;
			int wheregroup = 1;
			if (request.getParameter("go") != null) {
				where = Integer.parseInt(request.getParameter("go"));
				wheregroup = (where - 1) / maxpages + 1;
				startpage = (wheregroup - 1) * maxpages + 1;
				endpage = startpage + maxpages - 1;
			} else if (request.getParameter("gogroup") != null) {
				wheregroup = Integer.parseInt(request.getParameter("gogroup"));
				startpage = (wheregroup - 1) * maxpages + 1;
				where = startpage;
				endpage = startpage + maxpages - 1;
			}
			int nextgroup = wheregroup + 1;
			int priorgroup = wheregroup - 1;

			int nextpage = where + 1;
			int priorpage = where - 1;
			int startrow = 0;
			int endrow = 0;
			int maxrows = 2;
			int totalrows = 0;
			int totalpages = 0;

			String em = null;
			Connection con = null;
			Statement st = null;
			ResultSet rs = null;

			try {
				Class.forName("org.gjt.mm.mysql.Driver");
			} catch (ClassNotFoundException e) {
				out.println(e);
			}

			try {
				con = DriverManager.getConnection(
						"jdbc:mysql://localhost:3306/member?useUnicode=true&characterEncoding=utf-8", "root", "1111");
				st = con.createStatement();
				rs = st.executeQuery("select * from guestboard order by inputdate desc");

				if (!(rs.next())) {
					out.println("블로그에 올린 글이 없습니다");
				} else {
					do {
						name.addElement(rs.getString("name"));
						email.addElement(rs.getString("email"));
						inputdate.addElement(rs.getString("inputdate"));
						subject.addElement(rs.getString("subject"));
						content.addElement(rs.getString("content"));
					} while (rs.next());
					totalrows = name.size();
					totalpages = (totalrows - 1) / maxrows + 1;
					startrow = (where - 1) * maxrows;
					endrow = startrow + maxrows - 1;
					if (endrow >= totalrows)
						endrow = totalrows - 1;
					totalgroup = (totalpages - 1) / maxpages + 1;
					if (endpage > totalpages)
						endpage = totalpages;
					for (int j = startrow; j <= endrow; j++) {
						out.println("<table border='0' width='600' cellspacing='0' cellpadding='2'>");
						out.println("<tr align='right'>");
						out.println("<td height='22'>&nbsp;</td></tr>");
						out.println("<tr align='center'>");
						out.println("<td height='1' bgcolor='#1F4F8F'></td>");
						out.println("</tr>");
						out.println("<tr align='center' bgcolor='#DFEDFF'>");
						out.println("<td class='button' bgcolor='#DFEDFF'>");
						out.println("<div align='left'><font size='2'>" + subject.elementAt(j));
						out.println("</div></td>");
						out.println("</tr>");
						out.println("<tr align='center' bgcolor='#FFFFFF'>");
						out.println("<td align='center' bgcolor='#F4F4F4'>");
						out.println("<table width='100%' border='0' cellpadding='0'cellspacing='4'>");
						out.println("<tr bgcolor='#F4F4F4'>");
						out.println("<td width='13%' height='7'></td>");
						out.println("<td width='38%' height='7'>글쓴이:" + name.elementAt(j) + "</td>");
						String temp = (String) email.elementAt(j);
						if ((temp != null) && (!(temp.equals(""))))
							em = "<A href=mailto:" + temp + ">" + temp + "</A>";
						out.println("<td width='38%' height='7'>E-mail: " + em + "</td>");
						out.println("<td width='11%' height='7'></td>");
						out.println("</tr>");
						out.println("<tr bgcolor='#F4F4F4'>");
						out.println("<td width='13%'></td>");
						out.println("<td colspan=2>작성일:" + inputdate.elementAt(j) + "</td>");
						out.println("<td width='11%'></td>");
						out.println("</tr></table>");
						out.println("</td></tr>");
						out.println("<tr align='center'>");
						out.println("<td bgcolor='#1F4F8F' height='1'></td>");
						out.println("</tr>");
						out.println("<tr align='center'>");
						out.println("<td style='padding:10 0 0 0'>");
						out.println("<div align='left'><br>");
						out.println("<font size='3' color='#333333'><PRE>" + content.elementAt(j));
						out.println("</PRE></div>");
						out.println("<br>");
						out.println("</td></tr>");
						out.println("<tr align='center'>");
						out.println("<td class='button' height='1'></td>");
						out.println("</tr>");
						out.println("<tr align='center'>");
						out.println("<td bgcolor='#1F4F8F' height='1'></td>");
						out.println("</tr>");
						out.println("</table><p>");
					}
				}
				rs.close();
				st.close();
				con.close();
			} catch (SQLException e) {
				out.println(e);
			}
			if (wheregroup > 1) {
				out.println("[<A href=\"MainForm.jsp?contentPage=dbgb_show.jsp?go=1\">처음</A>]");
				out.println("[<A href=\"MainForm.jsp?contentPage=dbgb_show.jsp?gogroup=" + priorgroup + "\">이전</A>]");
			} else {
				out.println("[처음]");
				out.println("[이전]");
			}
			for (int jj = startpage; jj <= endpage; jj++) {
				if (jj == where)
					out.println("[" + jj + "]");
				else
					out.println("[<A href=\"MainForm.jsp?contentPage=dbgb_show.jsp?go=" + jj + "\">" + jj + "</A>]");
			}
			if (wheregroup < totalgroup) {
				out.println("[<A href=\"MainForm.jsp?contentPage=dbgb_show.jsp?gogroup=" + nextgroup + "\">다음</A>]");
				out.println("[<A href=\"MainForm.jsp?contentPage=dbgb_show.jsp?gogroup=" + totalgroup + "\">마지막</A>]");
			} else {
				out.println("[다음]");
				out.println("[마지막]");
			}
			out.println(where + "/" + totalpages);
		%>
		<p>
 <A href="javascript:location.href = 'MainForm.jsp?contentPage=dbgb_write.jsp'">
 <img src="images/write.gif" width="54" height="19" border=0></A>
</center>
</BODY>
</HTML>