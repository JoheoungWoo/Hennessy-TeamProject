package guddn;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

public class commentDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private Statement stmt;
	private ResultSet rs;
	
	public commentDAO() {
		try {
			String URL = "jdbc:mysql://localhost:3306/game_schema?useUnicode=true&characterEncoding=UTF-8";
			String ID = "root";
			String Password = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(URL, ID, Password);
		} catch (Exception e) {
			e.printStackTrace();
		}
	} // 사용자로부터 요청이 들어오면 미리 DB 호출을 함 (UserDAO.login(), UserDAO.join())
	
	public String getDate() {
		String SQL = "SELECT NOW()";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	
	public int getNext() {
		String SQL = "SELECT comment_id FROM comment_table ORDER BY comment_id DESC";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	
	public int write(String c_user,int c_board_id, String c_content, String c_filename, String c_filerealname) {
		String SQL = "INSERT INTO comment_table VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
		String InsPo = "UPDATE user_table SET user_point = user_point + 5 WHERE user_id = ?";
		try {
			PreparedStatement uppo = conn.prepareStatement(InsPo);
			uppo.setString(1, c_user);
			uppo.executeUpdate();
			uppo.close();
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setInt(2, c_board_id);
			pstmt.setString(3, c_user);
			pstmt.setString(4, c_content);
			pstmt.setString(5, getDate());
			pstmt.setInt(6, 1);
			if(c_filename == null || c_filerealname == null) {
				pstmt.setString(7, null);
				pstmt.setString(8, null);
			} else {
				pstmt.setString(7, c_filename);
				pstmt.setString(8, c_filerealname);
			}
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int update(int c_id, String c_content, String c_fileName, String c_fileRealName) {
		String SQL = "UPDATE comment_table SET comment_content = ?, comment_filename = ?, comment_filerealname = ? WHERE comment_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, c_content);
			pstmt.setString(2, c_fileName);
			pstmt.setString(3, c_fileRealName);
			pstmt.setInt(4, c_id);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int c_id) {
		String SQL = "UPDATE comment_table SET comment_available = 0 WHERE comment_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, c_id);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int restore(int c_id) {
		String SQL = "UPDATE comment_table SET comment_available = 1 WHERE comment_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, c_id);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int count(int c_board_id) {
		String SQL = "SELECT COUNT(comment_id) FROM comment_table WHERE comment_board_id = ? AND comment_available = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, c_board_id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
			return 1;	
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<comment> getList(int c_board_id, int pageNumber) {
		String SQL = "SELECT * FROM comment_table WHERE comment_id < ? AND comment_available = 1 AND comment_board_id = ? ORDER BY comment_id DESC LIMIT 10";
		ArrayList<comment> list = new ArrayList<comment>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			pstmt.setInt(2, c_board_id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				comment comment = new comment();
				comment.setC_id(rs.getInt(1));
				comment.setC_b_id(rs.getInt(2));
				comment.setC_user(rs.getString(3));
				comment.setC_content(rs.getString(4));
				comment.setC_date(rs.getString(5));
				comment.setC_available(rs.getInt(6));
				comment.setC_filename(rs.getString(7));
				comment.setC_filerealname(rs.getString(8));
				list.add(comment);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
}
