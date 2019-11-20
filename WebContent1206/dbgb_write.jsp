<%@ page contentType="text/html; charset=utf-8"%>
<%@ page language="java" import="java.sql.*,java.util.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<HTML>
<HEAD>
<SCRIPT>
	function check() {
		console.log("asdasd");
		with (document.filegbwrite) {
			if (subject.value.length == 0) {
				alert("제목을 입력하세요!");
				subject.focus();
				return false;
			}
			if (name.value.length == 0) {
				alert("이름을 입력하세요!");
				name.focus();
				return false;
			}
			if (content.value.length == 0) {
				alert("내용을 입력해주세요.");
				content.focus();
				return false;
			}
			document.filegbwrite.submit();
		}
	}
</SCRIPT>
<link href="filegb.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</HEAD>
<BODY>
	<FORM name=filegbwrite method=post action="dbgb_save.jsp">
		<CENTER>
			<table width="600" cellspacing="0" cellpadding="2">
				<tr>
					<td colspan="2" bgcolor="#1F4F8F" height="1"></td>
				</tr>
				<tr>
					<td colspan="2" bgcolor="#DFEDFF" height="20" class="style1">&nbsp;&nbsp;방명록 글작성</td>
				</tr>
				<tr>
					<td colspan="2" bgcolor="#1F4F8F" height="1"></td>
				</tr>
				<tr>
					<td width="124" bgcolor="#f4f4f4" class="style2">
						<div align="center">글쓴이</div>
					</td>
					<td width="494"><input type=text name=name
						class="input_style1"></td>
				</tr>
				<tr>
					<td colspan="2" bgcolor="#dddddd" height="1"></td>
				</tr>
				<tr>
					<td width="124" bgcolor="#f4f4f4" class="style2">
						<div align="center">E-mail</div>
					</td>
					<td width="494" height="25"><input type=text name=email
						class="input_style1"></td>
				</tr>
				<tr>
					<td colspan="2" bgcolor="#dddddd" height="1"></td>
				</tr>
				<tr>
					<td width="124" bgcolor="#f4f4f4" class="style2">
						<div align="center">제목</div>
					</td>
					<td width="494" height="25"><input type=text name=subject
						size="60" maxlength="60" class="input_style2"></td>
				</tr>
				<tr>
					<td colspan="2" bgcolor="#dddddd" height="1"></td>
				</tr>
				<tr>
					<td width="124" height="162" bgcolor="#f4f4f4"
						style="padding-top: 5px;" valign="top" class="style2">
						<div align="center">내용</div>
					</td>
					<td width="494" valign="top"><textarea cols="65" rows="10"
							name=content maxlength="2000" class="textarea_style1"></textarea>
					</td>
				</tr>
				<tr>
					<td colspan="2" height="1"></td>
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
								<td width="12%"><a href="javascript:location.href = 'MainForm.jsp?contentPage=dbgb_show.jsp'"><img
										src="images/cancle.gif" width="46" height="20" border="0"></td>
								<td width="9%"><a href="#" onClick="check(this.form);"><img
										src="images/ok.gif" width="46" height="20" border="0"></a></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
	</FORM>
</BODY>
</HTML>