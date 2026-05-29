package com.login.dao;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.login.dto.MyMemberDto;

public class MyMemberDao {
	
	//[관리자 기능]
	//회원 전체 정보 조회
	public List<MyMemberDto> selectAll(){
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<MyMemberDto> res = new ArrayList<MyMemberDto>();
		
		String sql = " SELECT * FROM MYMEMBER ORDER BY MYNO DESC ";
		
		try {
			pstm = con.prepareStatement(sql);
			System.out.println("3.query 준비: "+sql);
			
			rs = pstm.executeQuery();
			System.out.println("4.query 실행 및 리턴");
			
			while(rs.next()) {
				MyMemberDto tmp = new MyMemberDto();
				tmp.setMyno(rs.getInt(1));
				tmp.setMyid(rs.getString(2));
				tmp.setMypw(rs.getString(3));
				tmp.setMyname(rs.getString(4));
				tmp.setMyaddr(rs.getString(5));
				tmp.setMyphone(rs.getString(6));
				tmp.setMyemail(rs.getString(7));
				tmp.setMyenabled(rs.getString(8));
				tmp.setMyrole(rs.getString(9));
				
				res.add(tmp);
			}
			
			
		} catch (SQLException e) {
			System.out.println("3/4 에러 발생");
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("5.db 종료");
		}
		
		return res;
	}
	
	//회원 정보 조회
	public MyMemberDto selectUser(int myno) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		MyMemberDto res = null;
		
		String sql = " SELECT * FROM MYMEMBER WHERE MYNO=? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1,myno);
			System.out.println("3.query 준비: " + sql);
			
			rs = pstm.executeQuery();
			System.out.println("4.query 실행 및 리턴");
			
			if(rs.next()) {
				res = new MyMemberDto();
				res.setMyno(rs.getInt(1));
				res.setMyid(rs.getString(2));
				res.setMypw(rs.getString(3));
				res.setMyname(rs.getString(4));
				res.setMyaddr(rs.getString(5));
				res.setMyphone(rs.getString(6));
				res.setMyemail(rs.getString(7));
				res.setMyenabled(rs.getString(8));
				res.setMyrole(rs.getString(9));
			}
			
		} catch (SQLException e) {
			System.out.println("3/4 단계 에러");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("5.db 종료");
		}
		
		return res;
	}
	
	//회원 등급 변경
	public int updateRole(int myno, String myrole) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = " UPDATE MYMEMBER SET MYROLE=? WHERE MYNO=? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, myrole);
			pstm.setInt(2, myno);
			System.out.println("3.query 준비: "+sql);
			
			res = pstm.executeUpdate();
			System.out.println("4.query 실행 및 리턴");
			
			if(res>0) {
				commit(con);
			}else {
				rollback(con);
			}
			
		} catch (SQLException e) {
			System.out.println("3/4 단계 에러");
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
			System.out.println("5.db 종료");
		}
		
		return res;
	}
	
	//[회원 기능]
	//login
	public MyMemberDto login(String id, String pw) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		MyMemberDto res = new MyMemberDto();
		
		String sql =" SELECT * FROM MYMEMBER "+
		            " WHERE MYID=? AND MYPW=? AND MYENABLED=? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, id);
			pstm.setString(2, pw);
			pstm.setString(3, "Y");
			System.out.println("3.query 준비: "+sql);
			
			rs = pstm.executeQuery();
			System.out.println("4.query 실행");
			
			if(rs.next()) {
				res.setMyno(rs.getInt(1));
				res.setMyid(rs.getString(2));
				res.setMypw(rs.getString(3));
				res.setMyname(rs.getString(4));
				res.setMyaddr(rs.getString(5));
				res.setMyphone(rs.getString(6));
				res.setMyemail(rs.getString(7));
				res.setMyenabled(rs.getString(8));
				res.setMyrole(rs.getString(9));
			}
			
		} catch (SQLException e) {
			System.out.println("3/4 단계 에러");
			e.printStackTrace();
		} finally {
			System.out.println("5.db 종료");
			close(rs);
			close(pstm);
			close(con);
		}
	
		
		return res;
	}

	public boolean deleteMemeber(int myno) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = " UPDATE MYMEMBER SET MYENABLED = 'N' WHERE MYNO=? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, myno);
			System.out.println("3.query 준비: "+sql);
			
			res = pstm.executeUpdate();
			System.out.println("4.query 실행 및 리턴");
			
			if(res>0) {
				commit(con);
			}else {
				rollback(con);
			}
			
		} catch (SQLException e) {
			System.out.println("3/4 단계 에러");
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
			System.out.println("5.db 종료\n");
		}
		
		return (res>0)? true:false;
	}

	//회원 정보 수정
	public boolean updateUser(MyMemberDto dto) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = " UPDATE MYMEMBER SET MYADDR=?, MYPHONE=?, MYEMAIL=? WHERE MYNO=? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, dto.getMyaddr());
			pstm.setString(2, dto.getMyphone());
			pstm.setString(3, dto.getMyemail());
			pstm.setInt(4, dto.getMyno());
			System.out.println("3.query 준비: "+sql);
			
			res = pstm.executeUpdate();
			System.out.println("4.query 실행 및 리턴");
			
			if(res>0) {
				commit(con);
			}else {
				rollback(con);
			}
			
		} catch (SQLException e) {
			System.out.println("3/4 단계 에러");
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
			System.out.println("5.db 종료\n");
		}
				
		return (res>0)? true:false;
	}
}
