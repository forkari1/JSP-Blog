<%@ page contentType="text/html;charset=utf-8"%>
<%@ page language="java"
	import="java.sql.*, java.text.*,java.util.*,java.io.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<%
	String fileurl = application.getRealPath("/upload");
	String saveFolder = "upload";
	String encType = "utf-8";
	int Maxsize = 5 * 1024 * 1024;
	ServletContext context = getServletContext();
	try {
		MultipartRequest multi = null;

		DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
		multi = new MultipartRequest(request, fileurl, Maxsize, encType, policy);
		String na = multi.getParameter("name");
		String em = multi.getParameter("email");
		String sub = multi.getParameter("subject");
		String cont = multi.getParameter("content");
		String pw = multi.getParameter("password");

		int id = 1;
		int pos = 0;
		if (cont.length() == 1) {
			cont = cont + " ";
		} else {
			while ((pos = cont.indexOf("\'", pos)) != -1) {
				String left = cont.substring(0, pos);
				String right = cont.substring(pos, cont.length());
				cont = left + "\'" + right;
				pos += 2;
			}
		}

		java.util.Date yymmdd = new java.util.Date();
		SimpleDateFormat myformat = new SimpleDateFormat("yy-MM-d h:mm a");

		String ymd = myformat.format(yymmdd);
		String sql = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		int cnt = 0;

		try {
			Class.forName("com.mysql.jdbc.Driver");
		} catch (java.lang.ClassNotFoundException e) {
			out.println(e.getMessage());
		}

		try {
			conn = DriverManager.getConnection(
					"jdbc:mysql://localhost:3306/member?useUnicode=true&characterEncoding=utf-8", "root",
					"1111");

			sql = "select max(id) from databoard";
			ps = conn.prepareStatement(sql);
			
			rs = ps.executeQuery();
			if (!(rs.next())) {
				id = 1;
			} else {
				id = rs.getInt(1) + 1;
				rs.close();
			}

			Enumeration files = multi.getFileNames();
			String filename = "";
			String name = (String) files.nextElement();
			filename = (String) multi.getFilesystemName(name);

			File file = multi.getFile(name);
			if (filename != null) {		// 자료실에 파일은 업로드 안하고 글만 썼을경우
				String original = multi.getOriginalFileName(name);
				String type = multi.getContentType(name);

				sql = "insert into databoard(id,name,password,email,subject,"
						+ "content,inputdate,masterid,readcount,replynum,step,filename, filesize) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
								
				ps = conn.prepareStatement(sql);
				ps.setInt(1, id);
				ps.setString(2, na);
				ps.setString(3,pw);
				ps.setString(4,em);
				ps.setString(5,sub);
				ps.setString(6,cont);
				ps.setString(7,ymd);
				ps.setInt(8,id);
				ps.setInt(9,0);
				ps.setInt(10,0);
				ps.setInt(11,0);
				ps.setString(12,filename);
				ps.setInt(13, (int)file.length());
				
			} else{
				sql = "insert into databoard(id,name,password,email,subject,"
						+ "content,inputdate,masterid,readcount,replynum,step,filename, filesize) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
					
				ps = conn.prepareStatement(sql);
				ps.setInt(1, id);
				ps.setString(2, na);
				ps.setString(3,pw);
				ps.setString(4,em);
				ps.setString(5,sub);
				ps.setString(6,cont);
				ps.setString(7,ymd);
				ps.setInt(8,id);
				ps.setInt(9,0);
				ps.setInt(10,0);
				ps.setInt(11,0);
				ps.setString(12,"");
				ps.setInt(13, 0);
			}
			
			cnt = ps.executeUpdate();
			if (cnt > 0) {
				if (filename != null)
					out.println("데이터가 성공적으로 입력되었습니다.");
				else
					out.println("업로드된 파일은 없지만 글은 올렸습니다.");
			} else {
				out.println("글을 올리지 못했습니다.");
			}

			conn.close();

		} catch (SQLException e) {
			out.println(e);
		}
	} catch (IOException ioe) {
		out.println(ioe);
	}
%>
<A href="databoard_list.jsp">[게시판 목록으로]</A>
&nbsp;
<A href="databoard_write.htm">[글 올리는 곳으로]</A>