package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import bbs.BbsDTO;

public class CommentDAO {
	
	public int getNext() {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT ID3 FROM COMMENT_DB ORDER BY ID3 DESC";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
			return 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn!=null){conn.close();}}catch(Exception e){e.printStackTrace();}
			try {if(ps!=null){ps.close();}}catch(Exception e){e.printStackTrace();}
			try {if(rs!=null){rs.close();}}catch(Exception e){e.printStackTrace();}
		}
		return -1;
	}
	
	public int getNext2() {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT ID FROM COMMENT_DB ORDER BY ID DESC";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) {
				return 10000 * getNext();
			}
			return 10000;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn!=null){conn.close();}}catch(Exception e){e.printStackTrace();}
			try {if(ps!=null){ps.close();}}catch(Exception e){e.printStackTrace();}
			try {if(rs!=null){rs.close();}}catch(Exception e){e.printStackTrace();}
		}
		return -1;
	}
	
	public int getNext3(int ID2) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT ID2 FROM COMMENT_DB WHERE ID2 LIKE ? ORDER BY ID2 DESC";
		try {
			ps = conn.prepareStatement(sql);
			int ID4 = ID2 / 10;
			ps.setString(1, ID4 + "%");
			rs = ps.executeQuery();
			System.out.println(ID2);
			if (rs.next()) {
				return rs.getInt(1) + 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn!=null){conn.close();}}catch(Exception e){e.printStackTrace();}
			try {if(ps!=null){ps.close();}}catch(Exception e){e.printStackTrace();}
			try {if(rs!=null){rs.close();}}catch(Exception e){e.printStackTrace();}
		}
		return -1;
	}
	
	public String getDate() {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') FROM DUAL";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(ps != null) {ps.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch(Exception e) {e.printStackTrace();}
		}
		return "";
	}
	
	public int commentWrite(int Division, int ID, int ID2, int ID3, String userName, String userEmail, String userComment, String userIP) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		Division = 1;
		String sql = "INSERT INTO COMMENT_DB VALUES(?,?,?,?,?,?,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, Division);
			ps.setInt(2, ID);
			ps.setInt(3, getNext2());
			ps.setInt(4, getNext());
			ps.setString(5, userName);
			ps.setString(6, userEmail);
			ps.setString(7, userComment);
			ps.setString(8, userIP);
			ps.setString(9, getDate());
			return ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn!=null){conn.close();}}catch(Exception e){e.printStackTrace();}
			try {if(ps!=null){ps.close();}}catch(Exception e){e.printStackTrace();}
			try {if(rs!=null){rs.close();}}catch(Exception e){e.printStackTrace();}
		}
		return -1;
	}
	
	public int commentWrite2(int Division, int ID, int ID2, int ID3, String userName, String userEmail, String userComment, String userIP) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		Division = 0;
		String sql = "INSERT INTO COMMENT_DB VALUES(?,?,?,?,?,?,?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, Division);
			ps.setInt(2, ID);
			ps.setInt(3, getNext3(ID2));
			ps.setInt(4, 0);
			ps.setString(5, userName);
			ps.setString(6, userEmail);
			ps.setString(7, userComment);
			ps.setString(8, userIP);
			ps.setString(9, getDate());
			return ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn!=null){conn.close();}}catch(Exception e){e.printStackTrace();}
			try {if(ps!=null){ps.close();}}catch(Exception e){e.printStackTrace();}
			try {if(rs!=null){rs.close();}}catch(Exception e){e.printStackTrace();}
		}
		return -1;
	}
	
	public ArrayList<CommentDTO> getList(int ID) {
		ArrayList<CommentDTO> list2 = new ArrayList<CommentDTO>();
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM COMMENT_DB WHERE ID = ? ORDER BY ID2, DAY DESC";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ID);
			rs = ps.executeQuery();
			while (rs.next()) {
				CommentDTO com = new CommentDTO();
				com.setDivision(rs.getInt(1));
				com.setID(rs.getInt(2));
				com.setID2(rs.getInt(3));
				com.setID3(rs.getInt(4));
				com.setUserName(rs.getString(5));
				com.setUserEmail(rs.getString(6));
				com.setUserComment(rs.getString(7));
				com.setUserIP(rs.getString(8));
				com.setDay(rs.getString(9));
				list2.add(com);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn!=null){conn.close();}}catch(Exception e){e.printStackTrace();}
			try {if(ps!=null){ps.close();}}catch(Exception e){e.printStackTrace();}
			try {if(rs!=null){rs.close();}}catch(Exception e){e.printStackTrace();}
		}
		return list2;
	}
	
	public int commentDelete(int ID) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "DELETE COMMENT_DB WHERE ID = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ID);
			return ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn!=null){conn.close();}}catch(Exception e){e.printStackTrace();}
			try {if(ps!=null){ps.close();}}catch(Exception e){e.printStackTrace();}
			try {if(rs!=null){rs.close();}}catch(Exception e){e.printStackTrace();}
		}
		return -1;
	}
	
	public int commentDelete2(int ID, int ID2) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "DELETE COMMENT_DB WHERE ID = ? AND ID2 = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ID);
			ps.setInt(2, ID2);
			return ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn!=null){conn.close();}}catch(Exception e){e.printStackTrace();}
			try {if(ps!=null){ps.close();}}catch(Exception e){e.printStackTrace();}
			try {if(rs!=null){rs.close();}}catch(Exception e){e.printStackTrace();}
		}
		return -1;
	}
	
	public int commentDelete3(int ID, int ID2) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "DELETE COMMENT_DB WHERE ID = ? AND ID2 LIKE ?";
		try {
			ps = conn.prepareStatement(sql);
			int ID4 = ID2 / 10;
			ps.setInt(1, ID);
			ps.setString(2, ID4 + "%");
			return ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn!=null){conn.close();}}catch(Exception e){e.printStackTrace();}
			try {if(ps!=null){ps.close();}}catch(Exception e){e.printStackTrace();}
			try {if(rs!=null){rs.close();}}catch(Exception e){e.printStackTrace();}
		}
		return -1;
	}
	
	public int division(int ID2) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT DIVISION FROM COMMENT_DB WHERE ID2 = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ID2);
			rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn!=null){conn.close();}}catch(Exception e){e.printStackTrace();}
			try {if(ps!=null){ps.close();}}catch(Exception e){e.printStackTrace();}
			try {if(rs!=null){rs.close();}}catch(Exception e){e.printStackTrace();}
		}
		return -1;
	}
	
	public int commentUpdate(String Content, int ID2) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "UPDATE COMMENT_DB SET USERCOMMENT = ? WHERE ID2 = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, Content);
			ps.setInt(2, ID2);
			return ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn!=null){conn.close();}}catch(Exception e){e.printStackTrace();}
			try {if(ps!=null){ps.close();}}catch(Exception e){e.printStackTrace();}
			try {if(rs!=null){rs.close();}}catch(Exception e){e.printStackTrace();}
		}
		return -1;
	}
	
	public String getUserEmail(int ID2) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT USEREMAIL FROM COMMENT_DB WHERE ID2 = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ID2);
			rs = ps.executeQuery();
			if (rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn!=null){conn.close();}}catch(Exception e){e.printStackTrace();}
			try {if(ps!=null){ps.close();}}catch(Exception e){e.printStackTrace();}
			try {if(rs!=null){rs.close();}}catch(Exception e){e.printStackTrace();}
		}
		return "";
	}
}
