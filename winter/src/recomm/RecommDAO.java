package recomm;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import DBconst.TibeLookUp;

public class RecommDAO {
	
	private Connection conn;
	private ResultSet rs;
	
	public RecommDAO() {
//		try {
//			String dbURL = "jdbc:tibero:thin:@10.10.0.52:8629:tibero";
//			String dbID = "jw";
//			String dbPassword = "root";
//			Class.forName("com.tmax.tibero.jdbc.Driver");
//			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
		try {
			TibeLookUp tbLookUp = new TibeLookUp();
	        conn = tbLookUp.getConnection();
	        System.out.println(conn);
        } catch (Exception e) {
                // TODO Auto-generated catch block
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
			return 1;	// first upload
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	// database error
	}
	
	public int register(String name, String url, String intro) {
		String SQL = "INSERT INTO recomm VALUES (recomm_id_increment.nextval, ?, ?, 1, ?)";
		try {
			
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, name);
			pstmt.setString(2, url);
			pstmt.setString(3, intro);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;	// database error
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
		return -1;	// database error
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
		return -1;	// database error
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
