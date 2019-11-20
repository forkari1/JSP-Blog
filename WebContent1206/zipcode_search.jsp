<%@ page info="zipcode search" errorPage="error.jsp" %>
<%@ page contentType="text/html; charset=utf-8" %> 
<%@ page language="java" import="java.sql.*,java.io.*,java.net.*" %>
<% request.setCharacterEncoding("utf-8"); %>
<%
 Connection conn = null;
 Statement  stmt = null;
 ResultSet  rs   = null;

 String searchaddr = request.getParameter("addr");
 String query      = new String();
 String zipcode    = new String();
 String sido       = new String();
 String gugun      = new String();
 String dong       = new String();
 String bunji      = new String();
 String address    = new String();
 String address1   = new String();

 try {
  Class.forName("org.gjt.mm.mysql.Driver");
 } catch (ClassNotFoundException e ) {
  out.println(e);
 }
    
 try {
  conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/member?useUnicode=true&characterEncoding=utf-8","root","1111");
  stmt = conn.createStatement();
 } catch(SQLException e) {
 }
%>

<html>
<head>
<title>우편번호 검색</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<link rel="StyleSheet" href="style.css" type="text/css">
<script language="javascript">

 function choiceZipcode(zipcodeno, address1){
  opener.join.zipcode1.value = zipcodeno.substring(0,3);
  opener.join.zipcode2.value = zipcodeno.substring(4,7);
  opener.join.address1.value = address1;
  opener.join.address2.focus()
  self.close();
 }
-->
</script>
</head>
<body text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#FFFFFF">
<form name="zipcode" method="post" action="zipcode_search.jsp">
 <table align="center" width="95%" height="62" border="0" cellspacing="0" cellpadding="3" class="style2">
  <tr> 
   <td height="30">
    <font color="#405893">
    찾고자하는 주소의 동/읍/면 이름을 입력하세요.<br>
    검색한 후 주소를 클릭하세요.
    </font>
   </td>
  </tr>
 </table>
 <table align="center" width="95%" border="0" bgcolor="#B6C1D6">
  <tr> 
   <td bgcolor="#FFFFFF" align="center">
    <input type="text" name="addr" maxlength="15" size="15" class="style2">
    <input type="submit" value="검색">
   </td>
  </tr>
 </table>
</form>
<br/>
<%
 if(searchaddr != null){
%>
 <table align="center" width="95%" border="0" cellspacing="0" cellpadding="3" bordercolor="#999999" class="style2">
  <tr align="center"> 
   <td width="27%" bgcolor="#B4B4DA"><font color="#FFFFFF">우편번호</font></td>
   <td width="73%" bgcolor="#F7EDFE"><font color="#999999">주소</font></td>
  </tr>
 </table>
 <table align="center" width="95%" height="20" border="0" bordercolor="#0033CC" cellspacing="1" cellpadding="1" bgcolor="#9999CC" class="style2">
 <%
  try {
   query = "select * from zipcode where dong like '%"+searchaddr+"%'";
   rs = stmt.executeQuery(query);
   while(rs.next()){
    zipcode  = rs.getString("zipcode");
    sido     = rs.getString("sido");
    gugun    = rs.getString("gugun");
    dong     = rs.getString("dong");
    bunji    = rs.getString("bungi");
    address  = sido+" "+gugun+" "+dong+" "+bunji;
    address1 = sido+" "+gugun+" "+dong;
 %>
  <tr bgcolor="#9999CC"> 
   <td width="27%" bordercolor="#CCCCCC" bgcolor="#FFFFFF" align="center"><a href="javascript:choiceZipcode('<%=zipcode%>','<%=address1%>')"><%=zipcode%></a></td>
   <td width="73%" bordercolor="#999999" bgcolor="#FFFFFF"><a href="javascript:choiceZipcode('<%=zipcode%>','<%=address1%>')"><%=address%></a></td>
  </tr>
 <%
   }
   rs.close();
  } catch(SQLException e) {
	  out.println(e);
  }catch(Exception e){
	  out.println(e);
  }finally {
   conn.close();
  }
 %>
 </table>
 <%
 }
 %>
</body>
</html>