package com.my.dao;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.my.dto.MyBoardDto;

public class MyBoardDao {

	//전체 출력
	public List<MyBoardDto> selectAll(){
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<MyBoardDto> res = new ArrayList<MyBoardDto>();
		String sql = " SELECT * FROM MYBOARD ORDER BY MYNO DESC ";
		
		try {
			pstm = con.prepareStatement(sql);
			System.out.println("3.query 준비: " + sql);
			
			rs = pstm.executeQuery();
			System.out.println("4.query 실행 및 리턴");
			
			while(rs.next()) {
				MyBoardDto dto = new MyBoardDto(rs.getInt(1), rs.getString(2), rs.getString(3), rs.getString(4), rs.getDate(5));
				res.add(dto);
			}
			
		} catch (SQLException e) {
			System.out.println("3/4 단계 오류");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("5.db 종료");
		}
		
		return res;
	}
	
	
	//선택 출력
	public MyBoardDto selectOne(int myno) {
		String sql = " SELECT * FROM MYBOARD WHERE MYNO=? ";
		//쿼리문을 실행하여 MyBoardDto객체에 결과를 저장 후 리턴
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		MyBoardDto res = null;
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, myno);
			System.out.println("3.query 준비: " + sql);
			
			rs = pstm.executeQuery();
			System.out.println("4.query 실행 및 리턴");
			
			if(rs.next()) {
				res = new MyBoardDto();
				res.setMyno(rs.getInt(1));
				res.setMyname(rs.getString(2));
				res.setMytitle(rs.getString(3));
				res.setMycontent(rs.getString(4));
				res.setMydate(rs.getDate(5));
				
			}
			
		} catch (SQLException e) {
			System.out.println("3/4단계 에러");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("5.db 종료\n");
		}
		
		
		return res;
	}
	
	//글작성
	public int insert(MyBoardDto dto) {
		//myname, mytitle, mycontent
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		
		String sql = " INSERT INTO MYBOARD VALUES(SEQ_MYBOARD.NEXTVAL,?,?,?, SYSDATE) ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, dto.getMyname());
			pstm.setString(2, dto.getMytitle());
			pstm.setString(3, dto.getMycontent());
			System.out.println("3.query 준비: " + sql);
			
			res = pstm.executeUpdate();
			System.out.println("4.query 실행");
			
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
		
		return res;
	}
	
	//수정
	public int update(MyBoardDto dto) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		String sql = " UPDATE MYBOARD SET MYTITLE=?, MYCONTENT=? WHERE MYNO=? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setString(1, dto.getMytitle());
			pstm.setString(2, dto.getMycontent());
			pstm.setInt(3, dto.getMyno());
			System.out.println("3.query 준비: " + sql);
			
			res = pstm.executeUpdate();
			System.out.println("4.query 실행");
			
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
		return res;
	}
	
	//삭제
	public int delete(int myno) {
		Connection con = getConnection();
		PreparedStatement pstm = null;
		int res = 0;
		String sql = " DELETE FROM MYBOARD WHERE MYNO=? ";
		
		try {
			pstm = con.prepareStatement(sql);
			pstm.setInt(1, myno);
			res = pstm.executeUpdate();
			
			if(res>0) {
				commit(con);
			}else {
				rollback(con);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstm);
			close(con);
		}
		
		return res;
	}
}
