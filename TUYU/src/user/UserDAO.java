package user;

import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.ResultSet;

public class UserDAO {
	
	public int login(String userEmail, String userPW) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT USERPW FROM USER_DB WHERE USEREMAIL = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, userEmail);
			rs = ps.executeQuery();
			if (rs.next()) {
				if (rs.getString(1).equals(userPW)) {
					return 1;
				} else {
					return 0;
				}
			}
			return -1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {if(conn!=null){conn.close();}}catch(Exception e){e.printStackTrace();}
			try {if(ps!=null){ps.close();}}catch(Exception e){e.printStackTrace();}
			try {if(rs!=null){rs.close();}}catch(Exception e){e.printStackTrace();}
		}
		return -2;
	}
	
	public int join(UserDTO user) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "INSERT INTO USER_DB VALUES(?,?,?,?,0)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, user.getUserName());
			ps.setString(2, user.getUserEmail());
			ps.setString(3, user.getUserPW());
			ps.setString(4, user.getUserEmailHash());
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
	
	public String getUserName(String userEmail) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT USERNAME FROM USER_DB WHERE USEREMAIL = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, userEmail);
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
	
	public int getUserEmailChecked(String userEmail) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT USEREMAILCHECKED FROM USER_DB WHERE USEREMAIL = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, userEmail);
			rs = ps.executeQuery();
			while (rs.next()) {
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
	
	public int setUserEmailChecked(String userEmail) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "UPDATE USER_DB SET USEREMAILCHECKED = 1 WHERE USEREMAIL = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, userEmail);
			rs = ps.executeQuery();
			while (rs.next()) {
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
	
	public String getUserEmail(String userName) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "SELECT USEREMAIL FROM USER_DB WHERE USERNAME = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, userName);
			rs = ps.executeQuery();
			while (rs.next()) {
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
	
	public int userUpdate(String userName, String userEmail) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "UPDATE USER_DB SET USERNAME = ? WHERE USEREMAIL = ?";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, userName);
			ps.setString(2, userEmail);
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
	
}
