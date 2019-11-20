<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java" import="java.sql.*, java.text.*,java.util.*,java.io.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<% request.setCharacterEncoding("euc-kr"); %>
<%
 String fileurl= "/jsp/chap11/upload/";
 String saveFolder="upload";
 String encType="euc-kr";
 int Maxsize = 5*1024*1024; 
 ServletContext context = getServletContext();

 try{
  MultipartRequest multi = null;
  DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
  multi = new MultipartRequest(request,fileurl,Maxsize,encType,policy);
  String na = multi.getParameter("name");
  String em = multi.getParameter("email");
  String sub= multi.getParameter("subject"); 
  String cont = multi.getParameter("content");
  String pw = multi.getParameter("password");
  int mid = Integer.parseInt(multi.getParameter("mid"));
  int rnum=Integer.parseInt(multi.getParameter("rnum"));
  int step = Integer.parseInt(multi.getParameter("step")) + 1;
  int id =1;
  int pos=0;
  if (cont.length()==1) {
   cont = cont+ " ";
  } else { 
   while ((pos=cont.indexOf("\'", pos)) != -1) {
    String left=cont.substring(0, pos);
    String right=cont.substring(pos, cont.length());
    cont = left + "\'" + right;
    pos += 2;
   }
  }
 
  java.util.Date yymmdd = new java.util.Date() ;
  SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:mm a");
  String ymd=myformat.format(yymmdd);

  String sql=null;
  Connection con=null;
  Statement st=null; 
  ResultSet rs=null;  
  int cnt=0; 
 
  try {
   Class.forName("org.gjt.mm.mysql.Driver");
  } catch (ClassNotFoundException e){
   out.println(e.getMessage());
  }
 
  try {
   con = DriverManager.getConnection("jdbc:mysql://localhost:3306/member?useUnicode=true&characterEncoding=euckr","root","1111");
 
   st = con.createStatement();
   sql = "select max(id) from databoard";
   rs = st.executeQuery(sql);
   if (!(rs.next())) 
    id=1;
   else {
    id= rs.getInt(1) + 1 ;
    rs.close();
   }       
   if (step == 1) {
    sql = "select max(replynum) from databoard where masterid="+mid;
    rs=st.executeQuery(sql);
    if (!(rs.next())) 
     rnum=1;
    else 
     rnum=rs.getInt(1)+1;
   } 

   Enumeration files = multi.getFileNames();
   String filename = "";
   String name = (String)files.nextElement();
   filename = (String)multi.getFilesystemName(name);
   File file = multi.getFile(name);
   if(filename!=null){
   String original = multi.getOriginalFileName(name);
   String type = multi.getContentType(name);
	
   sql = "insert into databoard(id,name,password,email,subject," +   
   "content,inputdate,masterid,readcount,replynum,step,filename,"+
   " filesize) values(" +id + ", '" +  na + "','" + pw + "','"+ em 
   + "','" + sub + "','" + cont + "','" + ymd + "'," +mid+","  
   + "0,"+rnum+ "," + step+",'"+filename+"',"+file.length()+")";
  } else
   sql = "insert into databoard(id,name,password,email,subject," +   
   "content,inputdate,masterid,readcount,replynum,step,filename,"+
   " filesize) values(" +id + ", '" +  na + "','" + pw + "','"+ em 
   + "','" + sub + "','" + cont + "','" + ymd + "'," +mid+","  
   + "0,"+rnum+ ","+  step+",'',0)";
 
  cnt = st.executeUpdate(sql); 
  if (cnt >0) {
   if(filename!=null) 
    out.println("데이터가 성공적으로 입력되었습니다.");
   else
    out.println("업로드된 파일은 없지만 글은 올렸습니다.");
  }else { 
   out.println("글을 올리지 못했습니다.");
  }  

  st.close();
  con.close();
   
 } catch (SQLException e) {
  out.println(e);  
 }
} catch (IOException ioe) {
 out.println(ioe);
}
response.sendRedirect("databoard_list.jsp?go="+request.getParameter("page"));
%>