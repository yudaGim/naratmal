package com.naratmal.mvc.service;

import java.sql.SQLException;
import java.util.List;

import com.naratmal.mvc.exception.DuplicatedException;
import com.naratmal.mvc.exception.NotDBInputException;
import com.naratmal.mvc.exception.NotExistException;
import com.naratmal.mvc.exception.NotLoginException;
import com.naratmal.mvc.vo.Page;
import com.naratmal.mvc.vo.Users;

public interface UserService {
	/**
	 * 회원 가입
	 * @param: Users(userId, userName, userPassword, userTel, userBirth, zipcode, addr,
	 * 			addrDetail, addrRef)
	 * */
	void insertUser(Users users) throws SQLException, DuplicatedException, NotDBInputException;
	
	/**
	 * 로그인
	 * @param: Users(userId, UserPassword)
	 * @return: Users
	 * */
	Users login(Users users) throws SQLException, NotExistException;

	/**
	 * 회원 정보 수정
	 * @param: Users(입력된 값에 따라 동적으로 회원 정보 수정)
	 * */
	void updateUser(Users users) throws SQLException, NotLoginException, NotDBInputException;
	
	/**
	 * 아이디 찾기
	 * @param: String userId
	 * @return: Users
	 * */
	Users findById(String userId) throws SQLException;
	
	/**
	 * 회원 검색
	 * @param: Users(userId, userName, userTel, userBirth, addr, userQuit 중
	 * 			입력된 값에 따라 동적으로 검색)
	 * 			Page(null이냐 아니냐에 따라서 동적으로 페이징 처리)
	 * @return: List<Users>
	 * */
	List<Users> findUsers(Users users, Page page) throws SQLException;
}
