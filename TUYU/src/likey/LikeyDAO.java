package likey;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LikeyDAO {

	public int like(String userEmail, int ID, String userIP) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "INSERT INTO LIKEY VALUES(?,?,?)";
		try {
			ps = conn.prepareStatement(sql);
			ps.setString(1, userEmail);
			ps.setInt(2, ID);
			ps.setString(3, userIP);
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
	
	public int likeDelete(int ID) {
		Connection conn = util.DatabaseUtil.getConnection();
		PreparedStatement ps = null;
		ResultSet rs = null;
		String sql = "DELETE LIKEY WHERE ID = ?";
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
}
