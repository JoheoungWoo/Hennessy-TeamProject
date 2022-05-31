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
import java.util.List;


public class boardDAO{	
	private Connection conn;
	private PreparedStatement pstmt;
	private Statement stmt;
	private ResultSet rs;
	
	String getId = null;
	String getPwd = null;
	String getTitle = null;
	String getContent = null;
	String getTag = null;
	String getdata = null;
	int getAvail = 0;
	int getb_ID = 0;
	
	String arr= new String();
	
	SimpleDateFormat format = new SimpleDateFormat ( "yyyy-MM-dd HH:mm:ss");
	Date now = new Date(); 
	String now_dt = format.format(now);
	
	public boardDAO() {
		try {
			String URL = "jdbc:mysql://localhost:3306/game_schema?useUnicode=true&characterEncoding=UTF-8";
			String ID = "root";
			String Password = "1234";
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection(URL, ID, Password);
		} catch (Exception e) {
			e.printStackTrace();
		}
	} 
	
	public board getBoard(int boardID) {
		String SQL = "SELECT * FROM board_table WHERE board_id = ?";
		String View = "UPDATE board_table SET board_view = board_view + 1 WHERE board_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				PreparedStatement upvi = conn.prepareStatement(View);
				upvi.setInt(1, boardID);
				upvi.executeUpdate();
				upvi.close();
				board board = new board();
				board.setB_id(rs.getInt(1));
				board.setB_user(rs.getString(2));
				board.setB_title(rs.getString(3));
				board.setB_content(rs.getString(4));
				board.setB_tag(rs.getString(5));
				board.setB_date(rs.getString(6));
				board.setB_comment(rs.getInt(7));
				board.setB_view(rs.getInt(8));
				board.setB_available(rs.getInt(9));
				
				return board;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public ArrayList<board> getNotice() {
		String SQL = "SELECT * FROM board_table WHERE board_tag = '공지사항' AND board_available = 1 ORDER BY board_id DESC LIMIT 10";
		ArrayList<board> list = new ArrayList<board>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				board board = new board();
				board.setB_id(rs.getInt(1));
				board.setB_user(rs.getString(2));
				board.setB_title(rs.getString(3));
				board.setB_content(rs.getString(4));
				board.setB_tag(rs.getString(5));
				board.setB_date(rs.getString(6));
				board.setB_comment(rs.getInt(7));
				board.setB_view(rs.getInt(8));
				board.setB_available(rs.getInt(9));
				list.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public ArrayList<board> getPost() {
		String SQL = "SELECT * FROM board_table WHERE board_tag = '자유 게시판' AND board_available = 1 ORDER BY board_id DESC LIMIT 10";
		ArrayList<board> list = new ArrayList<board>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				board board = new board();
				board.setB_id(rs.getInt(1));
				board.setB_user(rs.getString(2));
				board.setB_title(rs.getString(3));
				board.setB_content(rs.getString(4));
				board.setB_tag(rs.getString(5));
				board.setB_date(rs.getString(6));
				board.setB_comment(rs.getInt(7));
				board.setB_view(rs.getInt(8));
				board.setB_available(rs.getInt(9));
				list.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	public int boardcount() {
		String SQL = "SELECT COUNT(board_tag = '자유 게시판') FROM board_table WHERE board_available = 1";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
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
		String SQL = "SELECT board_id FROM board_table ORDER BY board_id DESC";
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
		
	
	
	public int write(String b_user, String b_title, String b_content, String b_tag, String b_filename, String b_filerealname) {
		String SQL = "INSERT INTO board_table VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
		String InsPo = "UPDATE user_table SET user_point = user_point + 10 WHERE user_id = ?";
		try {
			PreparedStatement uppo = conn.prepareStatement(InsPo);
			uppo.setString(1, b_user);
			uppo.executeUpdate();
			uppo.close();
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, b_user);
			pstmt.setString(3, b_title);
			pstmt.setString(4, b_content);
			pstmt.setString(5, b_tag);
			pstmt.setString(6, getDate());
			pstmt.setInt(7, 0);
			pstmt.setInt(8, 0);
			pstmt.setInt(9, 1);
			pstmt.setString(10, b_filename);
			pstmt.setString(11, b_filerealname);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	
	public String read() {
		try {		
			String query = "SELECT * FROM game_schema.board_table order by board_id DESC LIMIT 10";
			//String query2 = "INSERT INTO game_schema.board_table(board_user,board_title,board_content,board_tag,board_date,board_available)"+ "VALUES('"+b_user+"','"+b_title+"','"+b_content+"','"+b_tag+"','"+now_dt+"','"+b_avilable+"')";	
			pstmt = conn.prepareStatement(query);
			stmt = conn.createStatement();
			rs = pstmt.executeQuery();
			while(rs.next()){ 
						getb_ID = rs.getInt(1);
						arr += Integer.toString(getb_ID) + ",";
				
						getId = rs.getString(2); 
						arr += getId + ",";
						
						getTitle = rs.getString(3); 
						arr += getTitle + ",";
						
						getContent = rs.getString(4);
						arr += getContent + ",";
						
						getTag = rs.getString(5);
						arr += getTag + ",";
						
						getdata = rs.getString(6);
						arr += getdata + ",";
						
						
			}
			return arr;
				
		} catch(Exception e) {
			e.printStackTrace();
		}	
		return "-2";
	}
	
	public ArrayList<board> getList(int pageNumber) {
		String SQL = "SELECT * FROM board_table WHERE board_id < ? AND board_available = 1 ORDER BY board_id DESC LIMIT 10";
		ArrayList<board> list = new ArrayList<board>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				board board = new board();
				board.setB_id(rs.getInt(1));
				board.setB_user(rs.getString(2));
				board.setB_title(rs.getString(3));
				board.setB_content(rs.getString(4));
				board.setB_tag(rs.getString(5));
				board.setB_date(rs.getString(6));
				board.setB_comment(rs.getInt(7));
				board.setB_view(rs.getInt(8));
				board.setB_available(rs.getInt(9));
				list.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	
	public boolean nextPage(int pageNumber) {
		String SQL = "SELECT * FROM board_table WHERE board_id < ? AND board_Available = 1";
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
	
	public int update(int boardID, String boardTitle, String boardContent, String boardTag, String fileName, String fileRealName) {
		String SQL = "UPDATE board_table SET board_title = ?, board_content = ?, board_tag = ?, board_filename = ?, board_filerealname = ? WHERE board_id = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, boardTitle);
			pstmt.setString(2, boardContent);
			pstmt.setString(3, boardTag);
			pstmt.setString(4, fileName);
			pstmt.setString(5, fileRealName);
			pstmt.setInt(6, boardID);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int delete(int boardID) {
		String SQL = "UPDATE board_table SET board_available = 0 WHERE board_ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public int restore(int boardID) {
		String SQL = "UPDATE board_table SET board_available = 1 WHERE board_ID = ?";
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, boardID);
			return pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return -1;
	}
	
	public ArrayList<board> getSearch(String searchField, String searchText){ //
	      ArrayList<board> list = new ArrayList<board>();
	      String SQL ="SELECT * FROM board_table WHERE "+searchField.trim();
	      try {
	            if(searchText != null && !searchText.equals("") ){
	                SQL +=" LIKE '%"+searchText.trim()+"%' ORDER BY board_id DESC LIMIT 10";
	            }
	            PreparedStatement pstmt=conn.prepareStatement(SQL);
				rs=pstmt.executeQuery();//select
	         while(rs.next()) {
	            board board = new board();
	            board.setB_id(rs.getInt(1));
	            board.setB_user(rs.getString(2));
	            board.setB_title(rs.getString(3));
	            board.setB_content(rs.getString(4));
	            board.setB_tag(rs.getString(5));
	            board.setB_date(rs.getString(6));
	            board.setB_comment(rs.getInt(7));
	            board.setB_view(rs.getInt(8));
	            board.setB_available(rs.getInt(9));
	            board.setB_filename(rs.getString(10));
	            board.setB_filerealname(rs.getString(11));
	            list.add(board);
	         }         
	      } catch(Exception e) {
	         e.printStackTrace();
	      }
	      return list;
	   }

	
	public ArrayList<board> searchBoard(String col, String word, int pageNumber) {// 
        ArrayList<board> list = new ArrayList<board>();
        try {
        	StringBuffer sql = new StringBuffer(); 
            if (col.equals("all")) {
                sql.append("SELECT * ");
                sql.append("FROM board_table ");
                sql.append("WHERE board_id < ? AND board_user LIKE ? OR board_title LIKE ? OR board_content LIKE ? ");
                sql.append("ORDER BY board_id DESC LIMIT 10");
                pstmt = conn.prepareStatement(sql.toString());
                pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
                pstmt.setString(2, "%" + word + "%");
                pstmt.setString(3, "%" + word + "%");
                pstmt.setString(4, "%" + word + "%");
            } else if (col.equals("user")) {
                sql.append("SELECT * ");
                sql.append("FROM board_table ");
                sql.append("WHERE board_id < ? AND board_user LIKE ? ");
                sql.append("ORDER BY board_id DESC LIMIT 10");
                pstmt = conn.prepareStatement(sql.toString());
                pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
                pstmt.setString(2, "%" + word + "%");
            } else if (col.equals("title")) {
                sql.append("SELECT * ");
                sql.append("FROM board_table ");
                sql.append("WHERE board_id < ? AND board_title LIKE ? ");
                sql.append("ORDER BY board_id DESC LIMIT 10");
                pstmt = conn.prepareStatement(sql.toString());
                pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
                pstmt.setString(2, "%" + word + "%");
            } else if (col.equals("content")) {
                sql.append("SELECT * ");
                sql.append("FROM board_table ");
                sql.append("WHERE board_id < ? AND board_content LIKE ? ");
                sql.append("ORDER BY board_id DESC LIMIT 10");
                pstmt = conn.prepareStatement(sql.toString());
                pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
                pstmt.setString(2, "%" + word + "%");
            } else {
                sql.append("SELECT * ");
                sql.append("FROM board_table WHERE board_id < ? ");
                sql.append("ORDER BY board_id DESC LIMIT 10");
                pstmt = conn.prepareStatement(sql.toString());
                pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
            }
            rs = pstmt.executeQuery(); // SELECT
            while (rs.next() == true) {
            	board board = new board();
	            board.setB_id(rs.getInt(1));
	            board.setB_user(rs.getString(2));
	            board.setB_title(rs.getString(3));
	            board.setB_content(rs.getString(4));
	            board.setB_tag(rs.getString(5));
	            board.setB_date(rs.getString(6));
	            board.setB_comment(rs.getInt(7));
	            board.setB_view(rs.getInt(8));
	            board.setB_available(rs.getInt(9));
	            board.setB_filename(rs.getString(10));
	            board.setB_filerealname(rs.getString(11));
	            list.add(board);
            }
 
        } catch (Exception e) {
            e.printStackTrace();
        }
	      return list;
	}
	
	public ArrayList<board> searchAllBoard(String word, int pageNumber) {// 
        ArrayList<board> list = new ArrayList<board>();
        try {
        	StringBuffer sql = new StringBuffer();
        	if (word != null) {
               	sql.append("SELECT * ");
                sql.append("FROM board_table ");
                sql.append("WHERE board_id < ? AND board_user LIKE ? OR board_title LIKE ? OR board_content LIKE ? ");
                sql.append("ORDER BY board_id DESC LIMIT 10");
                pstmt = conn.prepareStatement(sql.toString());
                pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
                pstmt.setString(2, "%" + word + "%");
                pstmt.setString(3, "%" + word + "%");
                pstmt.setString(4, "%" + word + "%");
        	} else {
        		sql.append("SELECT * ");
                sql.append("FROM board_table WHERE board_id < ? ");
                sql.append("ORDER BY board_id DESC LIMIT 10");
                pstmt = conn.prepareStatement(sql.toString());
                pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
        	}
            rs = pstmt.executeQuery(); // SELECT
            while (rs.next() == true) {
            	board board = new board();
	            board.setB_id(rs.getInt(1));
	            board.setB_user(rs.getString(2));
	            board.setB_title(rs.getString(3));
	            board.setB_content(rs.getString(4));
	            board.setB_tag(rs.getString(5));
	            board.setB_date(rs.getString(6));
	            board.setB_comment(rs.getInt(7));
	            board.setB_view(rs.getInt(8));
	            board.setB_available(rs.getInt(9));
	            board.setB_filename(rs.getString(10));
	            board.setB_filerealname(rs.getString(11));
	            list.add(board);
            }
 
        } catch (Exception e) {
            e.printStackTrace();
        }
	      return list;
	}
	
	public ArrayList<board> getList2(int pageNumber) {
		String SQL = "SELECT * FROM board_table WHERE board_id < ? ORDER BY board_id DESC";
		ArrayList<board> list = new ArrayList<board>();
		try {
			PreparedStatement pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, getNext() - (pageNumber - 1) * 10);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				board board = new board();
				board.setB_id(rs.getInt(1));
				board.setB_user(rs.getString(2));
				board.setB_title(rs.getString(3));
				board.setB_content(rs.getString(4));
				board.setB_tag(rs.getString(5));
				board.setB_date(rs.getString(6));
				board.setB_comment(rs.getInt(7));
				board.setB_view(rs.getInt(8));
				board.setB_available(rs.getInt(9));
				list.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	public ArrayList<board> getBoardList2(int startRow, int pageSize) {
		String SQL = "SELECT board_id, board_user, board_title, board_tag, board_date FROM board_table WHERE board_tag = '자유 게시판' AND board_available = 1  ORDER BY board_id DESC LIMIT ?, ?";
		ArrayList<board> boardList = new ArrayList<board>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			
			pstmt.setInt(1, startRow-1);
			pstmt.setInt(2, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				board board = new board();
				board.setB_id(rs.getInt(1));
				board.setB_user(rs.getString(2));
				board.setB_title(rs.getString(3));
				board.setB_tag(rs.getString(4));
				board.setB_date(rs.getString(5));
				
				boardList.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return boardList;	
	}
	
	public ArrayList<board> getBoardList(int pageSize) {
		String SQL = "SELECT board_id, board_user, board_title, board_tag, board_date FROM board_table WHERE board_tag = '자유 게시판' AND board_id < ? AND board_available = 1 ORDER BY board_id DESC LIMIT 10";
		ArrayList<board> boardList = new ArrayList<board>();
		
		try {
			pstmt = conn.prepareStatement(SQL);		
			pstmt.setInt(1, getNext() - (pageSize - 1) * 10);		
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				board board = new board();
				board.setB_id(rs.getInt(1));
				board.setB_user(rs.getString(2));
				board.setB_title(rs.getString(3));
				board.setB_tag(rs.getString(4));
				board.setB_date(rs.getString(5));		
				boardList.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return boardList;	
	}

	public ArrayList<board> getUserBoard(String userID, int startRow, int pageSize) {
		String SQL = "SELECT board_id, board_user, board_title, board_tag, board_date FROM board_table WHERE board_user = ? AND board_tag = '자유 게시판' AND board_available = 1  ORDER BY board_id DESC LIMIT ?, ?";
		ArrayList<board> boardList = new ArrayList<board>();
		
		try {
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, startRow-1);
			pstmt.setInt(3, pageSize);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				board board = new board();
				board.setB_id(rs.getInt(1));
				board.setB_user(rs.getString(2));
				board.setB_title(rs.getString(3));
				board.setB_tag(rs.getString(4));
				board.setB_date(rs.getString(5));
				
				boardList.add(board);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return boardList;	
	}
}