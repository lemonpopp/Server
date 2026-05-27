package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class JDBCTemplate {
	//1.연결
	public static Connection getConnection() {
		//드라이버 등록
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			System.out.println("1.driver 등록");
		} catch (ClassNotFoundException e) {
			System.out.println("[Error] 드라이버 등록 실패");
			e.printStackTrace();
		}
		
		//연결
		String url = "jdbc:oracle:thin:@localhost:1521/orcl";
		String id = "MULTI";
		String pw = "MULTI";
		Connection con = null;
		
		try {
			con = DriverManager.getConnection(url,id,pw);
			System.out.println("2.DB 연결");
			con.setAutoCommit(false);
			//자동커밋X
		} catch (SQLException e) {
			System.out.println("[Error] 오라클 연결 실패");
			e.printStackTrace();
		}
		
		return con;
	}
	
	//2.해제
	public static void close(Connection con) {
		try {
			con.close();
		} catch (SQLException e) {
			System.out.println("[Error] con close 실패");
			e.printStackTrace();
		}
	}
	
	public static void close(Statement stmt) {
		try {
			stmt.close();
		} catch (SQLException e) {
			System.out.println("[Eroor] stmt close 실패");
			e.printStackTrace();
		}
	}
	public static void close(ResultSet rs) {
		try {
			rs.close();
		} catch (SQLException e) {
			System.out.println("[Error] rs close 실패");
			e.printStackTrace();
		}
	}
	
	//3.저장 / 취소
	public static void commit(Connection con) {
		try {
			con.commit();
		} catch (SQLException e) {
			System.out.println("[Error] commit 실패");
			e.printStackTrace();
		}
	}
	public static void rollback(Connection con) {
		try {
			con.rollback();
		} catch (SQLException e) {
			System.out.println("[Error] rollback 실패");
			e.printStackTrace();
		}
	}
	
	
}
