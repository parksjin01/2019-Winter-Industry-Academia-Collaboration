package recomm;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

/* tbJDBC package */
import com.tmax.tibero.jdbc.*;
import com.tmax.tibero.jdbc.ext.*;

public class RecommDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public RecommDAO() {
		try {
			String dbURL = "jdbc:tibero:thin:@10.10.0.52:8629/tibero";
			String dbID = "jw";
			String dbPassword = "root";
			Class.forName("com.tmax.tibero.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int getNext() {
		String SQL = "SELECT recommID FROM recomm ORDER BY recommID DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;	// ù��° �Խù��� ���
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	// �����ͺ��̽� ����
	}
	
	public int register(String name, String url, String intro) {
		String SQL = "INSERT INTO recomm VALUES (0, ?, ?, 1, ?)";
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, name);
			pstmt.setString(2, url);
			pstmt.setString(3, intro);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	// �����ͺ��̽� ����
	}
	
	public Recomm getRecomm(int recommID) {
		String SQL = "SELECT * FROM Recomm WHERE recommID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, recommID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				Recomm recomm = new Recomm();
				recomm.setRecommID(rs.getInt(1));
				recomm.setName(rs.getString(2));
				recomm.setUrl(rs.getString(3));
				recomm.setIntro(rs.getString(5));
				return recomm;
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public int update(int recommID, String name, String url, String intro) {
		String SQL = "UPDATE recomm SET name = ?, url = ?, intro = ? WHERE recommID = ?";
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, name);
			pstmt.setString(2, url);
			pstmt.setString(3, intro);
			pstmt.setInt(4, recommID);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	// �����ͺ��̽� ����
	}
	
	public int delete(int recommID) {
		String SQL = "UPDATE recomm SET recommAvailable = 0 WHERE recommID = ?";
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, recommID);	
			return pstmt.executeUpdate();		
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	// �����ͺ��̽� ����
	}
	
	public ArrayList<Recomm> getList() {
		String SQL = "SELECT * FROM recomm WHERE recommAvailable = 1 ORDER BY recommID DESC";
		ArrayList<Recomm> list = new ArrayList<Recomm>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Recomm recomm = new Recomm();
				recomm.setRecommID(rs.getInt(1));
				recomm.setName(rs.getString(2));
				recomm.setUrl(rs.getString(3));
				recomm.setIntro(rs.getString(5));
				list.add(recomm);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;	
	}
}
