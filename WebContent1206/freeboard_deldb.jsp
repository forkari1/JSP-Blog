<%@ page contentType="text/html; charset=utf-8" %> 
<%@ page language="java" import="java.sql.*" %> 
<% request.setCharacterEncoding("utf-8"); %>
<HTML>
<HEAD><TITLE>글 삭제하기</TITLE>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</HEAD>
<BODY>
[<a href="freeboard_list.jsp?go=<%=request.getParameter("page")%>">게시판 목록으로 </a>]
<%
 String sql=null;
 Connection con= null;
 PreparedStatement st =null;
 ResultSet rs =null;
 int cnt=0;

 int id = Integer.parseInt(request.getParameter("id"));
 
 try {
  Class.forName("com.mysql.jdbc.Driver");
 } catch (ClassNotFoundException e ) {
  out.println(e);
 }
 
 try{
  con = DriverManager.getConnection("jdbc:mysql://localhost:3306/member?useUnicode=true&characterEncoding=utf-8","root","1111");
 } catch (SQLException e) {
  out.println(e);
 }
 
 try {
  sql = "select * from freeboard where id=? ";
  st = con.prepareStatement(sql);
  st.setInt(1, id);
  rs = st.executeQuery();
  if (!(rs.next()))  {
   out.println("해당 내용이 없습니다");
  } else {
   String pwd= rs.getString("password"); 
   if (pwd.equals(request.getParameter("password"))) {
    sql = "delete from freeboard where id=?";
    st = con.prepareStatement(sql);
    st.setInt(1, id);
    cnt = st.executeUpdate(); 
    if (cnt >0) 
     out.println("정상적으로 삭제되었습니다.");
    else 
     out.println("삭제되지 않았습니다.");
   } else {
    out.println("비밀번호가 틀립니다.");
   }
  } 
  rs.close();
  st.close();
  con.close();
 } catch (SQLException e) {
  out.println(e);
 } 
%>
</BODY>
</HTML>