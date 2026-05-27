package com.mvc.dao;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.mvc.dto.MVCBoardDto;

public class MVCBoardDao {

	//전체 출력
	public List<MVCBoardDto> selectAll(){
		Connection con = getConnection();
		PreparedStatement pstm = null;
		ResultSet rs = null;
		List<MVCBoardDto> res = new ArrayList<MVCBoardDto>();
		
		String sql = " SELECT * FROM MVCBOARD ORDER BY SEQ DESC ";
		
		try {
			pstm = con.prepareStatement(sql);
			System.out.println("3.query 준비: " + sql);
			
			rs = pstm.executeQuery();
			System.out.println("4.query 실행 및 리턴");
			
			while(rs.next()) {
				MVCBoardDto tmp = new MVCBoardDto();
				tmp.setSeq(rs.getInt(1));
				tmp.setWriter(rs.getString(2));
				tmp.setTitle(rs.getString(3));
				tmp.setContent(rs.getString(4));
				tmp.setRegdate(rs.getDate(5));
				
				res.add(tmp);

			}
		} catch (SQLException e) {
			System.out.println("3/4 단계 에러");
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstm);
			close(con);
			System.out.println("5.db 종료\n");
		}
		
		return res;
	}
}
