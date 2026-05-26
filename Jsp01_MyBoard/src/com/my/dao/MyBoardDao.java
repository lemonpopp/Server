package com.my.dao;

import static common.JDBCTemplate.*;

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
}
