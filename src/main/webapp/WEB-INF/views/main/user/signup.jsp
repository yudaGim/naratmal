<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	<link type="text/css" rel="stylesheet" href="${path}/resources/css/main.css">
	<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
	    function sample4_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 참고 항목 변수
	
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample4_postcode').value = data.zonecode;
	                document.getElementById("sample4_roadAddress").value = roadAddr;
	                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
	                
	                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
	                if(roadAddr !== ''){
	                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
	                } else {
	                    document.getElementById("sample4_extraAddress").value = '';
	                }
	
	                var guideTextBox = document.getElementById("guide");
	                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	                if(data.autoRoadAddress) {
	                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	                    guideTextBox.style.display = 'block';
	
	                } else if(data.autoJibunAddress) {
	                    var expJibunAddr = data.autoJibunAddress;
	                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	                    guideTextBox.style.display = 'block';
	                } else {
	                    guideTextBox.innerHTML = '';
	                    guideTextBox.style.display = 'none';
	                }
	            }
	        }).open();
	    }
	</script>
	</head>
	<body>
		<div id="main-content-body">
			<h2>회원가입</h2>
			<form action="${path}/main/user/signup-complete" method="post">
				<div class="form-floating">
					<input type="text" class="form-control" id="floatingId" placeholder="아이디" name="userId">
					<label for="floatingId">아이디</label>
				</div>
				<div class="form-floating">
					<input type="password" class="form-control" id="floatingPassword" placeholder="비밀번호" name="userPassword">
					<label for="floatingPassword">비밀번호</label>
				</div>
				<div class="form-floating">
					<input type="text" class="form-control" id="floatingName" placeholder="이름" name="userName">
					<label for="floatingName">이름</label>
				</div>
				<div class="form-floating">
					<input type="text" class="form-control" id="floatingName" placeholder="전화번호" name="userTel">
					<label for="floatingName">전화번호</label>
				</div>
				<div class="form-floating">
					<input type="text" class="form-control" id="sample4_postcode" placeholder="우편번호" name="zipcode">
					<label for="sample4_postcode">우편번호</label>
				</div>
				<input type="button" class="btn btn-dark" onclick="sample4_execDaumPostcode()" value="우편번호 찾기">
				<div class="form-floating">
					<input type="text" class="form-control" id="sample4_roadAddress" placeholder="도로명주소" name="addr">
					<label for="sample4_roadAddress">도로명주소</label>
				</div>
				<div class="form-floating" hidden>
					<input type="text" class="form-control" id="sample4_jibunAddress" placeholder="지번주소">
					<label for="sample4_jibunAddress">지번주소</label>
				</div>
				<div class="form-floating">
					<input type="text" class="form-control" id="sample4_detailAddress" placeholder="상세주소" name="addrDetail">
					<label for="sample4_detailAddress">상세주소</label>
				</div>
				<div class="form-floating" hidden>
					<input type="text" class="form-control" id="sample4_extraAddress" placeholder="참고항목">
					<label for="sample4_extraAddress">참고항목</label>
				</div>
				<span id="guide" style="color:#999;display:none"></span>
				
				<input type="submit" class="btn btn-dark" value="회원가입">
				<input type="reset" class="btn btn-dark" value="취소">
			</form>
		</div>
	</body>
</html>