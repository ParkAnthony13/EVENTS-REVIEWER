<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isErrorPage="true" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
		<link rel="stylesheet" type="text/css" href="css/style.css">
		<title>Login Registration</title>
	</head>
	<body>
		<div class="container d-flex justify-content-end m-3"><a href="/logout" class="btn btn-warning">Log Out</a></div>
		<div class="d-flex justify-content-center">
			<h1>WELCOME</h1>
		</div>
		<div class="container d-flex justify-content-center" style="margin: auto;">
			<div class="leftside container">
			    <h1>Register!</h1>


			    <form:form method="post" action="/" modelAttribute="user">
			        <p>
			            <form:label path="firstName">First Name:</form:label>
			            <form:input type="text" path="firstName"/>
						<form:errors path="firstName" style="color:red;"/>
			            
			        </p>
			        <p>
			            <form:label path="lastName">Last Name:</form:label>
			            <form:input type="text" path="lastName"/>
			            <form:errors path="lastName" style="color:red;"/>
			        </p>
			        <p>
			            <form:label path="email">Email:</form:label>
			            <form:input type="text" path="email"/>
			            <form:errors path="email" style="color:red;"/>
			            
			        </p>
			        <p>
			        	<form:label path="location">Location:</form:label>
			        	<form:input type="text" path="location"/>
			        	<form:errors path="location" style="color:red;"/>
			        </p>
			        <p>
			        	<form:label path="state">State:</form:label>
			        	<form:select path="state">
			        			<form:options items="${listOfStates}" itemValue="id" itemLabel="state"></form:options>
			        	</form:select>
			        </p>
			        <p>
			            <form:label path="password">Password:</form:label>
			            <form:password path="password"/>
			            <form:errors path="password" style="color:red;"/>
			        </p>
			        <p>
			            <form:label path="passwordConfirmation">Password Confirmation:</form:label>
			            <form:password path="passwordConfirmation"/>
			            <form:errors path="passwordConfirmation" style="color:red;"/>
			        </p>
			        <input type="submit" value="Register!"/>
			    </form:form>
			</div>
			<div class="rightside container">
			    <h1>Login</h1>
			    <p style="color:red;"><c:out value="${errorLogin}" /></p>
			    <form method="post" action="/login">
			        <p>
			            <label for="email">Email</label>
			            <input type="text" id="email" name="email"/>
			        </p>
			        <p>
			            <label for="password">Password</label>
			            <input type="password" id="password" name="password"/>
			        </p>
			        <input type="submit" value="Login!"/>
			    </form>
			</div>
		</div>
		
		<script src="/webjars/jquery/jquery.min.js"></script>
		<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="js/app.js"></script>
	</body>
</html>