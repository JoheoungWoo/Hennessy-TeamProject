package guddn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import guddn.User; // 

public class UserDAO{	
	private Connection conn;
	private PreparedStatement pstmt;
	private Statement stmt;
	private ResultSet rs;
		
	public UserDAO() {
		try {
			String URL = "jdbc:mysql://localhost:3306/game_schema?characterEncoding=UTF-8&serverTimezone=UTC&useSSL=false";
			String ID = "root";
			String Password = "1234";
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(URL, ID, Password);
		} catch (Exception e) {
			e.printStackTrace();
		}
	} // 사용자로부터 요청이 들어오면 미리 DB 호출을 함 (UserDAO.login(), UserDAO.join())
	
	
	public User getUser(int userIDNum) {
		String SQL = "SELECT * FROM user_table WHERE user_id_num = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, userIDNum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				User user = new User();
				user.setUserIDNum(rs.getInt(1));
				user.setUserID(rs.getString(2));
				user.setUserPassword(rs.getString(3));
				user.setUserNickName(rs.getString(4));
				user.setUserName(rs.getString(5));
				user.setUserGender(rs.getString(6));
				user.setUserEmail(rs.getString(7));
				user.setUserRank(rs.getInt(8));
				user.setUserExp(rs.getInt(9));
				user.setUserPoint(rs.getInt(10));
				user.setUserAvailable(rs.getInt(12));
				user.setUserJoinDate(rs.getString(13));
				
				return user;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
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
		String SQL = "SELECT user_id_num FROM user_table ORDER BY user_id_num DESC";
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
	
	public int rankUp(String userID) {
		String SQL = "SELECT * FROM user_table WHERE user_id = ?";
		String RankUP = "UPDATE user_table SET user_rank = user_rank + 1, user_exp = 0 WHERE user_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				if(rs.getInt(9) >= 100) {				
						PreparedStatement up = conn.prepareStatement(RankUP);
						up.setString(1, userID);
						up.executeUpdate();
						up.close();
					return 1;		
				} else {
					return 0;
				}
			} 
		} catch (Exception e) {
				e.printStackTrace();
		}
		return -1;
	}
	
	public int login(String userID, String userPassword) {
			String query = "SELECT * FROM user_table WHERE user_id = ?"; // 미리 스키마에 접근한 상태이므로 테이블 선언만 하면 됨
			//String query2 = "insert into game_schema.board_table(board_user,board_title,board_content) values('"++"','\"++\"','\"++\"')";		
			try {
				pstmt = conn.prepareStatement(query);
				pstmt.setString(1, userID); // 파이썬 %d 를 통해 변수값을 전달하는 것과 유사함
				rs = pstmt.executeQuery();		
				if (rs.next()) {
					if(rs.getString(3).equals(userPassword)) {
						if(rs.getInt(12) == 1) {
							if(!rs.getString(11).equals("YES")) {
								return 1; //로그인 성공 시 요청자 loginAction.jsp/result 에게 결과값 1을 반환시킴
								} else if(rs.getString(11).equals("YES")){
								return 2;
							}
						} return -3; //유저 권한 없음
				}else {
					return 0; //비밀번호 불일치
					} 
				}
				return -1; // DB 오류, 검색 시 아이디가 존재하지 않음
			} catch (Exception e) {
				e.printStackTrace();
		}
			return -2; // DB 오류	
	}
	
	public int join(User user) {
		String SQL = "INSERT INTO user_table VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, user.getUserID());
			pstmt.setString(3, user.getUserPassword());
			pstmt.setString(4, user.getUserNickName());
			pstmt.setString(5, user.getUserName());
			pstmt.setString(6, user.getUserGender());
			pstmt.setString(7, user.getUserEmail());
			pstmt.setInt(8, 1); // 랭크 1
			pstmt.setInt(9, 0); // 경험치 0
			pstmt.setInt(10, 0); // 포인트 0
			pstmt.setString(11, "NO"); // 관리자 권한 false
			pstmt.setInt(12, 1); // 유저 권한 0
			pstmt.setString(13, getDate());
			pstmt.setString(14, user.getUserFileName());
			pstmt.setString(15, user.getUserFileRealName());
			return pstmt.executeUpdate(); 
		} catch(Exception e) {
			e.printStackTrace();
		}
		finally {
			try {if(conn != null) {conn.close();}} catch (Exception ex) {ex.printStackTrace();}
			try {if(rs != null)   {rs.close();}}   catch (Exception ex) {ex.printStackTrace();}
			try {if(pstmt != null){pstmt.close();}}catch (Exception ex) {ex.printStackTrace();}
		}
		return -1;
	}
	
	public int delete(int userIDNum) {
		String SQL = "UPDATE user_table SET user_available = 0 WHERE user_id_num = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, userIDNum);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int restore(int userIDNum) { // 관리자만 이용 가능
		String SQL = "UPDATE user_table SET user_available = 1 WHERE user_id_num = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, userIDNum);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int adminUpdate(int UserIDNum, String userPassword, String userNickName, String userName, String userGender, String userEmail, String userFileName, String userFileRealName) {
		String SQL = "UPDATE user_table SET user_pw = ?, user_nickname = ?, user_name = ?, user_gender = ?, user_email = ?, user_filename = ?, user_filerealname = ? WHERE user_id_num = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userNickName);
			pstmt.setString(3, userName);
			pstmt.setString(4, userGender);
			pstmt.setString(5, userEmail);
			pstmt.setString(6, userFileName);
			pstmt.setString(7, userFileRealName);
			pstmt.setInt(8, UserIDNum);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int idCheck(String userID) {
		String SQL = "SELECT user_id FROM user_table WHERE user_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return 0; //중복된 아이디 존재
			}else {
				return 1; //중복된 아이디 없음
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<User> getList(int pageNumber) { // 관리자 페이지 내에서 사용될 것
		String SQL = "SELECT * FROM user_table WHERE user_id_num < ? ORDER BY user_id_num DESC";
		ArrayList<User> list = new ArrayList<User>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				User user = new User();
				user.setUserIDNum(rs.getInt(1));
				user.setUserID(rs.getString(2));
				user.setUserPassword(rs.getString(3));
				user.setUserNickName(rs.getString(4));
				user.setUserName(rs.getString(5));
				user.setUserGender(rs.getString(6));
				user.setUserEmail(rs.getString(7));
				user.setUserRank(rs.getInt(8));
				user.setUserExp(rs.getInt(9));
				user.setUserPoint(rs.getInt(10));
				user.setIsAdmin(rs.getString(11));
				user.setUserAvailable(rs.getInt(12));
				user.setUserJoinDate(rs.getString(13));
				user.setUserFileName(rs.getString(14));
				user.setUserFileRealName(rs.getString(15));
				list.add(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM user_table WHERE user_id_num < ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;	
	}
		
	public ArrayList<User> searchUser(String col, String word, int pageNumber) {// 검색 유형과 문장을 가져온다.
        ArrayList<User> list = new ArrayList<User>();
        try {
        	StringBuffer sql = new StringBuffer(); 
            if (col.equals("all")) {
                sql.append("SELECT * ");
                sql.append("FROM user_table ");
                sql.append("WHERE user_id_num < ? AND user_id LIKE ? OR user_nickname LIKE ? OR user_name LIKE ? ");
                sql.append("ORDER BY user_id_num DESC LIMIT 10");
                pstmt = conn.prepareStatement(sql.toString());
                pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
                pstmt.setString(2, "%" + word + "%");
                pstmt.setString(3, "%" + word + "%");
                pstmt.setString(4, "%" + word + "%");
            } else if (col.equals("user_id")) {
                sql.append("SELECT * ");
                sql.append("FROM user_table ");
                sql.append("WHERE user_id_num < ? AND user_id LIKE ? ");
                sql.append("ORDER BY user_id_num DESC LIMIT 10");
                pstmt = conn.prepareStatement(sql.toString());
                pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
                pstmt.setString(2, "%" + word + "%");
            } else if (col.equals("user_nickname")) {
                sql.append("SELECT * ");
                sql.append("FROM user_table ");
                sql.append("WHERE user_id_num < ? AND user_nickname LIKE ? ");
                sql.append("ORDER BY user_id_num DESC LIMIT 10");
                pstmt = conn.prepareStatement(sql.toString());
                pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
                pstmt.setString(2, "%" + word + "%");
            } else if (col.equals("user_name")) {
                sql.append("SELECT * ");
                sql.append("FROM user_table ");
                sql.append("WHERE user_id_num < ? AND user_name LIKE ? ");
                sql.append("ORDER BY user_id_num DESC LIMIT 10");
                pstmt = conn.prepareStatement(sql.toString());
                pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
                pstmt.setString(2, "%" + word + "%");
            } else {
                sql.append("SELECT * ");
                sql.append("FROM user_table WHERE user_id_num < ? ");
                sql.append("ORDER BY user_id_num DESC LIMIT 10");
                pstmt = conn.prepareStatement(sql.toString());
                pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
            }
            rs = pstmt.executeQuery(); // SELECT
            while (rs.next() == true) {
            	User user = new User();
            	user.setUserIDNum(rs.getInt(1));
            	user.setUserID(rs.getString(2));
            	user.setUserPassword(rs.getString(3));
            	user.setUserNickName(rs.getString(4));
            	user.setUserName(rs.getString(5));
            	user.setUserGender(rs.getString(6));
            	user.setUserEmail(rs.getString(7));
            	user.setUserRank(rs.getInt(8));
            	user.setUserExp(rs.getInt(9));
            	user.setUserPoint(rs.getInt(10));
            	user.setUserAvailable(rs.getInt(12));
            	user.setUserJoinDate(rs.getString(13));
				user.setUserFileName(rs.getString(14));
				user.setUserFileRealName(rs.getString(15));
	            list.add(user);//list에 해당 인스턴스를 담는다.
            }
 
        } catch (Exception e) {
            e.printStackTrace();
        }
	      return list;
	}
	
	public int updatedata(String userID,String userNickName,String userPassword) {
		String SQL = "UPDATE user_table SET user_pw = ?,user_nickname = ? WHERE user_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userNickName);
			pstmt.setString(3, userID);
			

			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		return -1;
	}
	
	public int u_account_delete(String userID) {
		PreparedStatement pstmt = null;
		String SQL1 = "UPDATE user_table SET user_available = 0 WHERE user_id = ?";
		try {
			pstmt = conn.prepareStatement(SQL1);
			pstmt.setString(1, userID);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		
		
		}
		return -1;
		}
	

	public int u_board_delete(String userID) {
		PreparedStatement pstmt = null;
		String SQL2 = "UPDATE board_table SET board_available = 0 WHERE board_user = ?";
		try {
			pstmt = conn.prepareStatement(SQL2);
			pstmt.setString(1, userID);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
			
		
		}
			return -1;
		}
	
}
				

		
