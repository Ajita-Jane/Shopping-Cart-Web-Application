<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form name="f1" action="DoLoad" enctype='multipart/form-data' method="post">
<table>
<tr>
<td><input type="file" name="txtimage" accept="image/*" required></td>

</tr>

<tr>
<td>category </td>
<td><input type="text" name="txtcat" ></td>
<td><input type="submit" value="Save">
</tr>
</table>
</form>
</body>
</html>