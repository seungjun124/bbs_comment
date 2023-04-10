package bbs;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import user.UserDTO;

public class BbsDAO {
	
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
	
	public int getNext() {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT ID FROM BBS_DB ORDER BY ID DESC";
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
	
	public int bbsWrite(String Subject, String Title, String Content, String userName, String userEmail) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "INSERT INTO BBS_DB VALUES(?,?,?,?,?,?,?,0,0)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, getNext());
			ps.setString(2, Subject);
			ps.setString(3, Title);
			ps.setString(4, Content);
			ps.setString(5, userName);
			ps.setString(6, userEmail);
			ps.setString(7, getDate());
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
	
	
	public ArrayList<BbsDTO> getList() {
		ArrayList<BbsDTO> list = new ArrayList<BbsDTO>();
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM BBS_DB ORDER BY ID DESC";
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			while (rs.next()) {
				BbsDTO bbs = new BbsDTO();
				bbs.setID(rs.getInt(1));
				bbs.setTitle(rs.getString(2));
				bbs.setSubject(rs.getString(3));
				bbs.setContent(rs.getString(4));
				bbs.setUserName(rs.getString(5));
				bbs.setUserEmail(rs.getString(6));
				bbs.setDay(rs.getString(7));
				bbs.setViews(rs.getInt(8));
				bbs.setLikes(rs.getInt(9));
				list.add(bbs);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn!=null){conn.close();}}catch(Exception e){e.printStackTrace();}
			try {if(ps!=null){ps.close();}}catch(Exception e){e.printStackTrace();}
			try {if(rs!=null){rs.close();}}catch(Exception e){e.printStackTrace();}
		}
		return list;
	}
	
	public int delete(int ID) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "DELETE FROM BBS_DB WHERE ID = ?";
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
	
	public String getUserEmail(int ID) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT USEREMAIL FROM BBS_DB WHERE ID = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ID);
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
	
	public int like(int ID) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			String sql = "UPDATE BBS_DB SET LIKES = LIKES + 1 WHERE ID = ?";
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
	
	public int view(int ID) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			String sql = "UPDATE BBS_DB SET VIEWS = VIEWS + 1 WHERE ID = ?";
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
	
	public BbsDTO getBbs(int ID) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT * FROM BBS_DB WHERE ID = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setInt(1, ID);
			rs = ps.executeQuery();
			if (rs.next()) {
				BbsDTO bbs = new BbsDTO();
				bbs.setID(rs.getInt(1));
				bbs.setTitle(rs.getString(2));
				bbs.setSubject(rs.getString(3));
				bbs.setContent(rs.getString(4));
				bbs.setUserName(rs.getString(5));
				bbs.setUserEmail(rs.getString(6));
				bbs.setDay(rs.getString(7));
				bbs.setViews(rs.getInt(8));
				bbs.setLikes(rs.getInt(9));
				return bbs;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn!=null){conn.close();}}catch(Exception e){e.printStackTrace();}
			try {if(ps!=null){ps.close();}}catch(Exception e){e.printStackTrace();}
			try {if(rs!=null){rs.close();}}catch(Exception e){e.printStackTrace();}
		}
		return null;
	}
	
	public int update(String Title, String Content, int ID) {
		String sql = "UPDATE BBS_DB SET Title = ? ,Content = ? WHERE ID = ?";
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, Title);
			ps.setString(2, Content);
			ps.setInt(3, ID);
			return ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(ps != null) {ps.close();}} catch(Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch(Exception e) {e.printStackTrace();}
		}
		return -1;
	}
	
	
}
