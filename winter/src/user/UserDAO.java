package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {

	public final static int LOGIN_SUCCESS = 1;
	public final static int INCORRECT_PW = 0;
	public final static int NOT_EXIST_EMAIL = -1;
	public final static int DATABASE_ERROR = -2;
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public UserDAO() {
		try {
			String dbURL = "jdbc:mysql://localhost:3306/winter?serverTimezone=UTC";
			String dbID = "root";
			String dbPassword = "root";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(User user) {
		String SQL = "SELECT pw FROM user WHERE email = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getEmail());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(user.getPw())) {
					setUser(user);
					return LOGIN_SUCCESS;
				} else {
					return INCORRECT_PW;
				}
			}
			return NOT_EXIST_EMAIL;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return DATABASE_ERROR;
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO user VALUES (0, 0, ?, ?, ?, now())";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(2, user.getEmail());
			pstmt.setString(4, user.getPw());
			return pstmt.executeUpdate();
		} catch(Exception e) {
			e.printStackTrace();
		}
		return DATABASE_ERROR;
	}
	
	
	public void setUser(User user) {
		String SQL = "SELECT * FROM user WHERE email = ?";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getEmail());
			rs = pstmt.executeQuery();
			if (rs.next()) {
				user.setUserID(rs.getInt(1));
				user.setAdmin(rs.getInt(2));
			}
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
}
