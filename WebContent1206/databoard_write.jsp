<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%
	request.setCharacterEncoding("utf-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<SCRIPT language="javascript">
	function check() {
		with (document.msgwrite) {
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
			document.msgwrite.submit();
		}
	}
</SCRIPT>
<link href="databoard.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY>
	<P>
	<FORM name="msgwrite" method=post enctype="multipart/form-data"
		action="databoard_save.jsp">
		<CENTER>
			<table width="600" cellspacing="0" cellpadding="2">
				<tr>
					<td colspan="2" bgcolor="#1F4F8F" height="1"></td>
				</tr>
				<tr>
					<td colspan="2" bgcolor="#DFEDFF" height="20" class="notice">&nbsp;&nbsp;<font
						size="2">자료 올리기</font></td>
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
						type=text name=subject size="60" maxlength="60"></td>
				</tr>
				<tr>
					<td width="124" height="162" bgcolor="#f4f4f4"
						style="padding: 7 0 0 14" valign="top">
						<div align="center">
							<font size="2">내 용</font>
						</div>
					</td>
					<td width="494" valign="top" style="padding: 5 0 5 10"><textarea
							cols="65" rows="10" name=content maxlength="2000"></textarea></td>
				</tr>
				<tr>
					<td width="124" bgcolor="#f4f4f4" style="padding: 0 0 0 14">
						<div align="center">첨부파일</div>
					</td>
					<td width="494" style="padding: 5 0 5 10" height="25"><input
						type="file" name="file" size=30></td>
				</tr>
				<tr>
					<td width="124" bgcolor="#f4f4f4" style="padding: 0 0 0 14">
						<div align="center">
							<font size="2">암 호</font>
						</div>
					</td>
					<td width="494" style="padding: 5 0 5 10" height="25"><input
						type=password name=password> <br> (비밀번호를 입력하면 수정 또는
						삭제가 가능합니다.)</td>
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
										src="image/cancle.gif" width="56" height="21" border="0"></a></td>
								<td width="9%"><a href="#" onClick="check();"><img
										src="image/ok.gif" width="56" height="21" border="0"></a></td>
							</tr>
						</table>
					</td>
				</tr>
			</table>
		</CENTER>
	</FORM>
</BODY>
</HTML>