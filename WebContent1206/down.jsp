<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.io.*" %>
<%
 String filename = new String((request.getParameter("file")).getBytes("8859_1"),"utf-8"); 
 String  filePath = application.getRealPath("/upload");		// 파일이 있는곳
 InputStream in= null;
 OutputStream os = null;
 File file= null;
 File viewFile = null;
 boolean skip= false;
 String client= "";

 try {
  String fname1 = "";
  String fname2 = "";
  String fname  = "";
  fname  = filename;
  fname1 = new String(fname.getBytes("8859_1"),"utf-8");

  try {
   file = new File(filePath, fname);
   viewFile = new File(filePath, fname1);
   out.print("file : " + file);
   in= new FileInputStream(file);
  } catch(FileNotFoundException fe) {
   skip= true;
  }

  fname2   = new String(fname1.getBytes("utf-8"),"8859_1");

  response.reset();
  client = request.getHeader("User-Agent");
  response.setContentType("application/x-msdownload;");
  response.setHeader("Content-Description", "JSP Generated Data");

  if(!skip){
   if(client.indexOf("MSIE 5.5") != -1){
    response.setHeader("Content-Type", "doesn/matter; charset=utf-8");
    response.setHeader("Content-Disposition", "filename="+new String(fname.getBytes("utf-8"),"8859_1"));
   } else {
    response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
    response.setHeader("Content-Disposition", "attachment; filename="+new String(fname.getBytes("utf-8"),"8859_1"));
   }
   response.setHeader("Content-Transfer-Encoding", "binary;");
   response.setHeader ("Content-Length", ""+file.length());
   response.setHeader("Pragma", "no-cache;");
   response.setHeader("Expires", "-1;");

   os = response.getOutputStream();
   byte b[] = new byte[4096];
   int leng = 0;
   while( (leng = in.read(b)) > 0 ){
    os.write(b,0,leng);
   }
  } else{
   out.println("<script language='javascript'>");
   out.println("alert('File Downloading Fail !!');");
   out.println("</script>");
   return;
  }
 } catch(Exception e) {
 System.out.println(e);
} finally {
 if(in != null) in.close();
 if(os != null) os.close();
}
%>