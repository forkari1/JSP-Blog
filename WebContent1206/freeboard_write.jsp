<%@ page contentType="text/html; charset=utf-8" %> 
<%@ page language="java" import="java.sql.*" %> 
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<HTML>
<HEAD>
<SCRIPT>                              

function check() {
	with (document.msgwrite) {
		if (subject.value.length == 0) {
			alert("제목을 입력하세요.");
			subject.focus();
			return false;
		}
		if (name.value.length == 0) {
			alert("이름을 입력하세요.");
			name.focus();
			return false;
		}
		if (password.value.length == 0) {
			alert("비밀번호를 입력하세요.");
			password.focus();
			return false;
		}
		if (content.value.length == 0) {
			alert("내용을 입력해주세요.");
			content.focus();
			return false;
		}
		document.msgwrite.submit();
	}
}
</SCRIPT>
<link href="filegb.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
</HEAD>
<BODY>
	<P>
	<FORM name="msgwrite" method="post" action="freeboard_save.jsp">
		<CENTER>
			<table width="600" cellspacing="0" cellpadding="2">
				<tr>
					<td colspan="2" bgcolor="#1F4F8F" height="1"></td>
				</tr>
				<tr>
					<td colspan="2" bgcolor="#DFEDFF" height="20" class="notice">&nbsp;&nbsp;<font
						size="2">게시판 글작성</font></td>
				</tr>
				<tr>
					<td colspan="2" bgcolor="#1F4F8F" height="1"></td>
				</tr>
				<tr>
					<td width="124" height="30" align="center" bgcolor="#f4f4f4">이름</td>
					<td width="494" style="padding: 0 0 0 10"><input type=text
						name=name class="input_style1"></td>
				</tr>
				<tr>
					<td width="124" align="center" bgcolor="#f4f4f4">E-mail</td>
					<td width="494" style="padding: 0 0 0 10" height="25"><input
						type=text name=email class="input_style1"></td>
				</tr>
				<tr>
					<td width="124" align="center" bgcolor="#f4f4f4">제목</td>
					<td width="494" style="padding: 0 0 0 10" height="25"><input
						type=text name=subject size="60" maxlength="60"
						class="input_style2"></td>
				</tr>
				<tr>
					<td width="124" height="162" align="center" valign="top"
						bgcolor="#f4f4f4" style="padding-top: 7px;">내용</td>
					<td width="494" valign="top" style="padding: 5 0 5 10"><textarea
							cols="65" rows="10" name=content maxlength="2000"
							class="textarea_style1"></textarea></td>
				</tr>
				<tr>
					<td width="124" align="center" bgcolor="#f4f4f4">비밀번호</td>
					<td width="494" style="padding: 0 0 0 10" height="25"><input
						type=password name=password class="style1"><br>(비밀번호를
						입력하셔야 수정이 가능합니다.)</td>
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
										src="image/cancle.gif" width="46" height="20" border="0"></td>
								<td width="9%"><a href="#" onClick="check();"><img
										src="image/ok.gif" width="46" height="20" border="0"></a></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</CENTER>
	</FORM>
</BODY>
</HTML>
