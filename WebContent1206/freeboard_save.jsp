<%@ page contentType="text/html; charset=utf-8" %>  
<%@ page language="java" import="java.sql.*,java.util.Date,java.text.*" %> 
<% request.setCharacterEncoding("utf-8"); %>
<%
	String na = request.getParameter("name");
 String em = request.getParameter("email");
 String sub = request.getParameter("subject"); 
 String cont = request.getParameter("content");
 String pw = request.getParameter("password");
 int id =1;
 int pos=0;
 if (cont.length()==1) 
  cont = cont+" " ;

 Date yymmdd = new java.util.Date() ;
 SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:mm a");
 String ymd=myformat.format(yymmdd);

 String sql=null;
 Connection con=null;
 PreparedStatement ps=null;
 Statement st = null;
 ResultSet rs=null;  
 int cnt=0; 

 try {
  Class.forName("com.mysql.jdbc.Driver");
 } catch (ClassNotFoundException e){
  out.println(e.getMessage());
 }

 try {
  	con = DriverManager.getConnection("jdbc:mysql://localhost:3306/member?useUnicode=true&characterEncoding=utf-8","root","1111");

	  st = con.createStatement();
	  sql = "select max(id) from  freeboard";		// id값 중 제일 큰값 가져와라 +1이 최신글이 되기 때문에
 	rs = st.executeQuery(sql);
	if (!(rs.next()))
		id = 1; // 첫번째 글
	else {
		id = rs.getInt(1) + 1;
		rs.close();
	}
	sql = "insert into freeboard(id,name,password,email,subject,content,inputdate,masterid,readcount,replynum,step) values(?,?,?,?,?,?,?,?,?,?,?)";
	ps = con.prepareStatement(sql);
	ps.setInt(1, id);
	ps.setString(2, na);
	ps.setString(3, pw);
	ps.setString(4, em);
	ps.setString(5, sub);
	ps.setString(6, cont);
	ps.setString(7, ymd);
	ps.setInt(8, id);
	ps.setInt(9, 0);
	ps.setInt(10, 0);
	ps.setInt(11, 0);
	cnt = ps.executeUpdate();
	 if (cnt >0) 
	  out.println("데이터가 성공적으로 입력되었습니다.");
	 else  
	  out.println("데이터가 입력되지 않았습니다. ");
	System.out.println( cnt );
	ps.close();
	con.close();
	st. close();
	} catch (SQLException e) {
		out.println(e);
	}
%>
<jsp:forward page="freeboard_list.jsp" />