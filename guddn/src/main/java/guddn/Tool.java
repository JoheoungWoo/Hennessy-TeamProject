package guddn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Map;
import java.util.List;


public class Tool {
	private Connection conn;
	private PreparedStatement pstmt;
	private Statement stmt;
	private ResultSet rs;
		
	public Tool() {
		try {
			String URL = "jdbc:mysql://localhost:3306/game_schema?useUnicode=true&characterEncoding=UTF-8";
			String ID = "root";
			String Password = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(URL, ID, Password);
		} catch (Exception e) {
			e.printStackTrace();
		}
	} // 사용자로부터 요청이 들어오면 미리 DB 호출을 함 (UserDAO.login(), UserDAO.join())
	
	public static boolean isEmpty(Object obj) {		
		if(obj == null) return true;		
		if ((obj instanceof String) && (((String)obj).trim().length() == 0)) { return true; }
		if (obj instanceof Map) { return ((Map<?, ?>) obj).isEmpty(); }	
		if (obj instanceof Map) { return ((Map<?, ?>)obj).isEmpty(); }
		if (obj instanceof List) { return ((List<?>)obj).isEmpty(); }
		if (obj instanceof Object[]) { return (((Object[])obj).length == 0); }		
		return false;	
	}

}
