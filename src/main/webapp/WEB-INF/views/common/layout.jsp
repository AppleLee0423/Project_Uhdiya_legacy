<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="${path}/resources/css/reset.css" />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title><tiles:insertAttribute name="title" /></title>
</head>
<body>
	<div id="container">
		<div id="set_header">
			<tiles:insertAttribute name="header" />
		</div>
		<div id="set_content">
			<tiles:insertAttribute name="body" />
		</div>
		<div id="set_footer">
			<tiles:insertAttribute name="footer" />
		</div>
	</div>
</body>
</html>